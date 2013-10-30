module Data.LDP8806 where

import Control.Monad.Reader
import Data.Bits
import Data.Binary
import qualified Data.ByteString.Lazy as BL
import System.IO

type LED = Integer
type Gamma = Integer

data ChannelOrder = RGB
                  | GRB
                  | BRG

data Color = Color { redValue :: Integer
                   , greenValue :: Integer
                   , blueValue :: Integer
                   } deriving (Eq, Show)


data LEDStrip = LEDStrip { stripNumLeds :: Integer
                         , stripOrder :: ChannelOrder
                         , stripDevice :: Handle
                         }

type SPI = ReaderT LEDStrip IO

mkGamma :: Color -> [Gamma]
mkGamma color = [gamma (redValue color), gamma (greenValue color), gamma (blueValue color)]
        where gamma i = 0x80 .|. floor (((fromIntegral i / 255.0) ** 2.5) * 127.0 + 0.5)


mkStrip :: Integer -> String -> IO LEDStrip
mkStrip i path = fmap (LEDStrip i RGB) $ openBinaryFile path WriteMode

runSPI :: SPI a -> LEDStrip -> IO a
runSPI spi strip = do
       v <- runReaderT spi strip
       hClose (stripDevice strip)
       return v

setLeds :: [Color] -> SPI ()
setLeds colors = do
        fileHandle <- asks stripDevice
        liftIO $ mapM_ (writeColorBuffer fileHandle) buffers
  where writeColorBuffer fh buf = (BL.hPut fh buf >> hFlush fh)
        buffers = map (encode . mkGamma) colors
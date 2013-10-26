module Data.LDP8806 where

import Control.Monad.Reader
import Data.Bits
import System.IO

type Gamma = Integer

data ChannelOrder = RGB
                  | GRB
                  | BRG

data LEDStrip = LEDStrip { stripNumLeds :: Integer
                         , stripDevice :: Handle
                         , stripOrder :: ChannelOrder
                         }

type SPI = ReaderT LEDStrip IO

mkGamma :: Integer -> Gamma
mkGamma i = 0x80 .|. floor (((fromIntegral i / 255.0) ** 2.5) * 127.0 + 0.5)

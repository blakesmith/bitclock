module Bitclock.Clock (
       Color(..),
       getBitTime
       ) where

import qualified Data.List as L
import Data.Time.Clock.POSIX
import Data.Bits

data Color = Color { redValue :: Integer
                   , greenValue :: Integer
                   , blueValue :: Integer
                   } deriving (Eq, Show)

data Endianness = Big
                | Little


bitValue :: Integer -> Int -> Bool
bitValue v n = (==) 1 $ (.&.) 1 $ shiftR v n

getTimestampBits :: POSIXTime -> [Bool]
getTimestampBits pt = L.zipWith bitValue (L.repeat timestamp) [0..63]
                 where timestamp = round pt

applyColor :: [Bool] -> [Color]
applyColor bits = map color bits
           where color True = Color 255 0 0
                 color False = Color 0 0 0

endianness :: Endianness -> [Bool] -> [Bool]
endianness Big = L.reverse
endianness Little = id

getBitTime :: IO [Color]
getBitTime = fmap (applyColor . endianness Big . getTimestampBits) getPOSIXTime
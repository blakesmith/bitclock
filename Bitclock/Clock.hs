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


bitValue :: Integer -> Int -> Bool
bitValue v n = (==) 1 $ (.&.) 1 $ shiftR v n

getTimestampBits :: POSIXTime -> [Bool]
getTimestampBits pt = L.zipWith bitValue (L.repeat timestamp) [0..64]
                 where timestamp = round pt

applyColor :: [Bool] -> [Color]
applyColor bits = map color bits
           where color True = Color 255 0 0
                 color False = Color 0 0 0

getBitTime :: IO [Color]
getBitTime = fmap (applyColor . getTimestampBits) getPOSIXTime
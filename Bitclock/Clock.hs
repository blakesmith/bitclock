{-# LANGUAGE ScopedTypeVariables #-}
module Bitclock.Clock (
       Color(..), Endianness(..), ClockState,
       newClock, readClock
       ) where

import Control.Concurrent
import Control.Monad
import qualified Data.List as L
import Data.Time.Clock.POSIX
import Data.Bits
import Data.LDP8806 (Color(..))

data Endianness = Big
                | Little deriving (Show)

type ClockState = MVar [Color]

newClock :: Int -> Int -> Endianness -> IO ClockState
newClock sampleMs ledCount end = do
         state <- getBitTime ledCount end >>= newMVar
         _ <- forkIO $ forever $ getBitTime ledCount end >>= swapMVar state >> threadDelay (sampleMs * 1000)
         return state

readClock :: ClockState -> IO [Color]
readClock = readMVar

bitValue :: Integer -> Int -> Bool
bitValue v n = (==) 1 $ (.&.) 1 $ shiftR v n

period :: (Fractional b) => Integer -> Integer -> b
period n d = fromIntegral n / fromIntegral d

periodLength :: Integer
periodLength = round posixDayLength

posixSecondsForToday :: POSIXTime -> Integer
posixSecondsForToday p = flip mod periodLength . round $ p

colorByTimeOfDay :: Color -> Color -> POSIXTime -> Color
colorByTimeOfDay c1 c2 t = Color r g b
                 where r :: Integer = floor $ (fromIntegral $ redValue c2) * p + (fromIntegral $ redValue c1) * (1.0 - p)
                       g :: Integer = floor $ (fromIntegral $ greenValue c2) * p + (fromIntegral $ greenValue c1) * (1.0 - p)
                       b :: Integer = floor $ (fromIntegral $ blueValue c2) * p + (fromIntegral $ blueValue c1) * (1.0 - p)
                       p :: Double = period (posixSecondsForToday t) periodLength

getTimestampColors :: Int -> POSIXTime -> [Color]
getTimestampColors ledCount pt = map color bits
                 where bits = L.zipWith bitValue (L.repeat timestamp) [0..ledCount-1]
                       timestamp = round pt
                       color True = colorByTimeOfDay startColor endColor pt
                       color False = Color 0 0 0
                       startColor = Color 255 127 0
                       endColor = Color 0 0 255

endianness :: Endianness -> [a] -> [a]
endianness Big = L.reverse
endianness Little = id

getBitTime :: Int -> Endianness -> IO [Color]
getBitTime ledCount end = fmap (endianness end . getTimestampColors ledCount) getPOSIXTime
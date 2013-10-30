module Bitclock.Clock (
       Color(..), ClockState,
       newClock, readClock
       ) where

import Control.Concurrent
import Control.Monad
import qualified Data.List as L
import Data.Time.Clock.POSIX
import Data.Bits
import Data.LDP8806 (Color(..))

data Endianness = Big
                | Little

type ClockState = MVar [Color]

newClock :: Int -> Int -> IO ClockState
newClock sampleMs ledCount = do
         state <- getBitTime ledCount>>= newMVar
         _ <- forkIO $ forever $ getBitTime ledCount >>= swapMVar state >> threadDelay (sampleMs * 1000)
         return state

readClock :: ClockState -> IO [Color]
readClock = readMVar

bitValue :: Integer -> Int -> Bool
bitValue v n = (==) 1 $ (.&.) 1 $ shiftR v n

getTimestampBits :: Int -> POSIXTime -> [Bool]
getTimestampBits ledCount pt = L.zipWith bitValue (L.repeat timestamp) [0..ledCount-1]
                 where timestamp = round pt

applyColor :: [Bool] -> [Color]
applyColor bits = map color bits
           where color True = Color 255 0 0
                 color False = Color 0 0 0

endianness :: Endianness -> [Bool] -> [Bool]
endianness Big = L.reverse
endianness Little = id

getBitTime :: Int -> IO [Color]
getBitTime ledCount = fmap (applyColor . endianness Big . getTimestampBits ledCount) getPOSIXTime
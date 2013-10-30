module Bitclock.Strip (
       runStrip
       ) where

import Bitclock.Clock
import Control.Concurrent
import Control.Monad
import Control.Monad.IO.Class
import Data.LDP8806

runStrip :: Int -> Int -> String -> ClockState -> IO ClockState
runStrip sampleMs ledCount fh cs = do
         _ <- forkIO $ forever $ mkStrip ledCount fh >>= doRead >> threadDelay (sampleMs * 1000)
         return cs

    where doRead = runSPI $ liftIO (readClock cs) >>= setLeds

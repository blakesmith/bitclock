module Bitclock.Strip (
       runStrip
       ) where

import Bitclock.Clock
import Control.Concurrent
import Control.Monad
import Control.Monad.IO.Class
import Data.LDP8806

runStrip :: Int -> ClockState -> IO ClockState
runStrip sampleMs cs = do
         _ <- forkIO $ forever $ mkStrip 64 "/tmp/clock_test" >>= doRead >> threadDelay (sampleMs * 1000)
         return cs

    where doRead = runSPI $ liftIO (readClock cs) >>= setLeds

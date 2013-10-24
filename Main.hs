import Bitclock.Clock
import Control.Monad
import Control.Concurrent

wait :: IO ()
wait = newEmptyMVar >>= takeMVar

clockReader :: Int -> ClockState -> IO ()
clockReader delayMs clk = forever $ fmap show (readClock clk) >>= putStrLn >> threadDelay (delayMs * 1000)

main :: IO ()
main = putStrLn "Starting Clock" >> newClock 250 >>= clockReader 1000 >> wait
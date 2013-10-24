import Bitclock.Clock
import Control.Monad
import Control.Concurrent

wait :: IO ()
wait = newEmptyMVar >>= takeMVar

readClock :: Int -> ClockState -> IO ()
readClock delayMs clk = forever $ fmap show (readMVar clk) >>= putStrLn >> threadDelay (delayMs * 1000)

main :: IO ()
main = putStrLn "Starting Clock" >> newClock 250 >>= readClock 1000 >> wait
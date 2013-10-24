import Bitclock.Clock
import Control.Concurrent

wait :: IO ()
wait = newEmptyMVar >>= takeMVar

main :: IO ()
main = putStrLn "Starting Clock" >> newClock >> wait
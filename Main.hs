import Bitclock.Clock
import Control.Concurrent

main :: IO ()
main = newClock >> threadDelay 1000000 >> putStrLn "Started"
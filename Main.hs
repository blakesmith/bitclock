import Control.Concurrent
import Bitclock.Args
import Bitclock.Clock
import Bitclock.Strip

block :: IO ()
block = newEmptyMVar >>= takeMVar

main :: IO ()
main = do
     args <- getArgs
     putStrLn "Starting Clock"
     newClock 250 (ledCount args) >>= runStrip 500 (ledCount args) (devicePath args) >> block

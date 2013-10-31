import Control.Concurrent
import Control.Monad
import Bitclock.Args
import Bitclock.Clock
import Bitclock.Strip

block :: IO ()
block = forever $ threadDelay (10000 * 1000)

main :: IO ()
main = do
     args <- getArgs
     putStrLn "Starting Clock"
     newClock 250 (ledCount args) >>= runStrip 500 (ledCount args) (devicePath args) >> block

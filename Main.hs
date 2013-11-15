
import Control.Concurrent
import Control.Monad
import Bitclock.Args
import Bitclock.Clock
import Bitclock.Strip

block :: IO ()
block = forever $ threadDelay (10000 * 1000)

main :: IO ()
main = do
     args <- getArguments
     putStrLn "Starting Clock"
     newClock 100 (ledCount args) (endianness args) >>= runStrip 100 (ledCount args) (devicePath args) >> block

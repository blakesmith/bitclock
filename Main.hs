import Bitclock.Args
import Bitclock.Clock
import Bitclock.Strip
import Bitclock.Web

main :: IO ()
main = do
     args <- getArgs
     webArgs <- getSnapConfig args
     putStrLn "Starting Clock"
     newClock 250 (ledCount args) >>= runStrip 500 (ledCount args) (devicePath args) >>= serveWeb webArgs

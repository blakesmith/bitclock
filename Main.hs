import Bitclock.Args
import Bitclock.Clock
import Bitclock.Strip
import Bitclock.Web

main :: IO ()
main = do
     args <- getArgs
     webArgs <- getSnapConfig args
     putStrLn "Starting Clock"
     newClock 250 64 >>= runStrip 500 64 "/tmp/clock_test" >>= serveWeb webArgs
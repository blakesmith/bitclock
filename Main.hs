import Bitclock.Clock
import Bitclock.Strip
import Bitclock.Web

main :: IO ()
main = putStrLn "Starting Clock" >> newClock 250 >>= runStrip 500 64 "/tmp/clock_test" >>= serveWeb
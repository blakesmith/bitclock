import Bitclock.Clock
import Bitclock.Web

main :: IO ()
main = putStrLn "Starting Clock" >> newClock 250 >>= serveWeb
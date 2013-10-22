import Bitclock.Clock

main :: IO ()
main = fmap show getBitTime >>= putStrLn
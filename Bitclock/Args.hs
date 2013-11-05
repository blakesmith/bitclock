module Bitclock.Args (
       getArguments,
       endianness, ledCount, devicePath
       ) where

import System.Console.GetOpt
import System.Environment
import Bitclock.Clock (Endianness(..))

data Args = Args { ledCount :: Int
                 , devicePath :: FilePath
                 , endianness :: Endianness
                 } deriving (Show)

version :: String
version = "0.0.1"

defaultArgs :: Args
defaultArgs = Args { ledCount = 64
                   , devicePath = "/dev/spidev0.0"
                   , endianness = Big
                   }

clockArgs :: [OptDescr (Args -> Args)]
clockArgs = [ Option ['l'] ["led-count"]
                    (ReqArg
                            (\arg opt -> opt { ledCount = read arg })
                            "COUNT")
                            "LED Strip Count, defaults to 64"
            , Option ['d'] ["device-path"]
                     (ReqArg
                            (\arg opt -> opt { devicePath = arg })
                            "PATH")
                            "Strip device path, defaults to /dev/spidev0.0"
            , Option ['e'] ["endianness"]
                     (ReqArg
                            (\arg opt -> opt { endianness = mkEnd arg })
                            "big OR little")
                            "Clock endianness. Specify 'big' or 'little'. Defaults to 'big'"
            ]
    where mkEnd "little" = Little
          mkEnd _        = Big

readOptions :: [String] -> IO (Args, [String])
readOptions argv =
    case getOpt Permute clockArgs argv of
        (o,n,[]  ) -> return (foldl (flip id) defaultArgs o, n)
        (_,_,errs) -> ioError (userError (concat errs ++ usageInfo header clockArgs))
  where header = "BitClock LED Daemon " ++ version ++ "\n" ++ "Usage: bitclockd [OPTION...]"

getArguments :: IO Args
getArguments = do
        argv <- getArgs
        (args,_) <- readOptions argv
        return args

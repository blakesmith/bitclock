{-# LANGUAGE DeriveDataTypeable #-}
module Bitclock.Args (
       getArguments,
       ledCount, devicePath
       ) where

import System.Console.GetOpt
import System.Environment

data Args = Args { ledCount :: Int
                 , devicePath :: FilePath
                 } deriving (Show)

version :: String
version = "0.0.1"

defaultArgs :: Args
defaultArgs = Args { ledCount = 64
                   , devicePath = "/dev/spidev0.0"
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
            ]

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

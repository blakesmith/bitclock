{-# LANGUAGE DeriveDataTypeable #-}
module Bitclock.Args (
       getArgs,
       ledCount, devicePath
       ) where

import System.Console.CmdArgs

data Args = Args { ledCount :: Int
                 , devicePath :: FilePath
                 } deriving (Data, Typeable, Show)

version :: String
version = "0.0.1"

clockArgs :: Args
clockArgs = Args { ledCount = 64 &= typ "COUNT" &= help "LED Strip Count (defaults to 64)"
                 , devicePath = "/dev/spidev0.0" &= typFile &= help "Strip device path, defaults to /dev/spidev0.0"
                 }
           &= program "bitclockd"
           &= summary ("BitClock LPD8806 LED Strip Clock " ++ version)

getArgs :: IO Args
getArgs = cmdArgs clockArgs


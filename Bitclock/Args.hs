{-# LANGUAGE DeriveDataTypeable #-}
module Bitclock.Args (
       getArgs, getSnapConfig,
       ledCount, devicePath
       ) where

import Snap.Core
import Snap.Http.Server.Config
import System.Console.CmdArgs

data Args = Args { ledCount :: Int
                 , devicePath :: FilePath
                 , webAccessLog :: FilePath
                 , webErrorLog :: FilePath
                 , webPort :: Int
                 } deriving (Data, Typeable, Show)

version :: String
version = "0.0.1"

clockArgs :: Args
clockArgs = Args { ledCount = 64 &= typ "COUNT" &= help "LED Strip Count (defaults to 64)"
                 , devicePath = "/dev/spidev0.0" &= typFile &= help "Strip device path, defaults to /dev/spidev0.0"
                 , webAccessLog = "/var/log/bitclock/access.log" &= name "a" &= typFile &= help "Web access log, defaults to /var/log/bitclock/access.log"
                 , webErrorLog = "/var/log/bitclock/error.log" &= name "e" &= typFile &= help "Web error log, defaults to /var/log/bitclock/error.log"
                 , webPort = 8000 &= name "p" &= typ "PORT" &= help "Web listen port, defaults to 8000"
                 }
           &= program "bitclockd"
           &= summary ("BitClock LPD8806 LED Strip Clock " ++ version)

getArgs :: IO Args
getArgs = cmdArgs clockArgs

getSnapConfig :: MonadSnap m => Args -> IO (Config m a)
getSnapConfig ar = return config
              where config = setAccessLog (ConfigFileLog (webAccessLog ar)) .
                             setErrorLog (ConfigFileLog (webErrorLog ar)) .
                             setPort (webPort ar)
                             $ defaultConfig

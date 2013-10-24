{-# LANGUAGE OverloadedStrings #-}
module Bitclock.Web (
       serveWeb
       ) where

import Bitclock.Clock
import qualified Data.ByteString.Char8 as C
import Control.Monad.IO.Class
import Snap.Core
import Snap.Http.Server

serveWeb :: ClockState -> IO ()
serveWeb clk = quickHttpServe (routes clk)

routes :: ClockState -> Snap ()
routes clk = ifTop (root clk)

root :: ClockState -> Snap ()
root clk = do
     time <- liftIO $ readClock clk
     writeBS $ C.pack $ show time


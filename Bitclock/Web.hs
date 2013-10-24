{-# LANGUAGE OverloadedStrings #-}
module Bitclock.Web (
       serveWeb
       ) where

import Bitclock.Clock
import Snap.Core
import Snap.Http.Server

serveWeb :: ClockState -> IO ()
serveWeb clk = quickHttpServe routes

routes :: Snap ()
routes = ifTop (writeBS "Hello world!")


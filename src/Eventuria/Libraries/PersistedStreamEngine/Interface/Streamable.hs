{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
module Eventuria.Libraries.PersistedStreamEngine.Interface.Streamable where

import Control.Monad.IO.Class
import Control.Exception
import Streamly
import Data.Aeson

import Eventuria.Libraries.PersistedStreamEngine.Interface.PersistedItem

class (FromJSON item,
       Monad monad,
       IsStream stream,
       MonadIO (stream monad),
       MonadAsync monad,
       Semigroup (stream monad (Either SomeException (Persisted item)))) => Streamable stream monad item

instance FromJSON item =>  Streamable SerialT IO item
instance FromJSON item =>  Streamable ParallelT IO  item
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidObserverBoundary where

import Data.Proxy (Proxy(..))
import EmergentAxialLisp.LambdaCanonTypeCore

invalidObserverBoundary :: ()
invalidObserverBoundary = requireObserverBoundary (Proxy @127)

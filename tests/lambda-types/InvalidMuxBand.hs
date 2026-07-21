{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidMuxBand where

import Data.Proxy (Proxy(..))
import EmergentAxialLisp.LambdaCanonTypeCore

invalidMuxBand :: ()
invalidMuxBand = requireAscii7 (Proxy @135)

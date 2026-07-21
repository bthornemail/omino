{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidFoldBand where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.LagrangeSpaceTypeCore

invalidFoldBand :: FoldedByte 4 0 128
invalidFoldBand = LockFoldedByte (Proxy @4) (Proxy @0) (Proxy @128)

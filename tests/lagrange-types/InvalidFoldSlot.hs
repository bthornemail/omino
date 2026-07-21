{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidFoldSlot where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.LagrangeSpaceTypeCore

invalidFoldSlot :: FoldedByte 0 32 32
invalidFoldSlot = LockFoldedByte (Proxy @0) (Proxy @32) (Proxy @32)

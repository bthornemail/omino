{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidByte where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.LagrangeSpaceTypeCore

invalidByte :: LagrangeSpaceCell 128 0 0
invalidByte = LockSpaceCell (Proxy @128) (Proxy @0) (Proxy @0)

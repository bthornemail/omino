{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidAddressPlane where

import Data.Proxy (Proxy(..))
import OmiImo.CanonicalResolverAuthorities

invalidAddressPlane :: PlaneWitness 256
invalidAddressPlane =
  PlaneWitness
    (Proxy @256)
    (Proxy @(ClassifyAddressPlane 256))

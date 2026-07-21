{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidRemoteInterface where

import Data.Proxy (Proxy(..))
import EmergentAxialLisp.OctahedralTypeCore

invalidRemoteInterface :: InterfaceCell 0 Remote83
invalidRemoteInterface = InterfaceCell (Proxy @0) (Proxy @Remote83)

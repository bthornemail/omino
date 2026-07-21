{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidWeight where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.Layer4TetrahedronCore

invalidWeight :: EntrainmentToken 11 4
invalidWeight = LockWavefront (Proxy @11) (Proxy @4)

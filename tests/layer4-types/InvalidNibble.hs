{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidNibble where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.Layer4TetrahedronCore

invalidNibble :: EntrainmentToken 16 4
invalidNibble = LockWavefront (Proxy @16) (Proxy @4)

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidActiveIdentity where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.MetamorphicCompilerCore

invalidActiveIdentity :: MetamorphicToken 15 30
invalidActiveIdentity = LockExportInvariance (Proxy @15) (Proxy @30)

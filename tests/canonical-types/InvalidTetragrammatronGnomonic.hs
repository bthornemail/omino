{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidTetragrammatronGnomonic where

import Data.Proxy (Proxy(..))
import OmiImo.CanonicalResolverAuthorities

invalidTetragrammatronGnomonic :: AuthorityEnvelope TetragrammatronGovernor 43605
invalidTetragrammatronGnomonic = TetragrammatronToken (Proxy @43605)

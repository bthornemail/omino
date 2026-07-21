{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidMetatronFold where

import Data.Proxy (Proxy(..))
import OmiImo.CanonicalResolverAuthorities

invalidMetatronFold :: AuthorityEnvelope MetatronScribe 60
invalidMetatronFold = MetatronToken (Proxy @60)

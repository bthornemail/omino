{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module InvalidA080Face4 where

import Data.Proxy (Proxy(..))
import EmergentAxialLisp.OctahedralTypeCore

invalidA080Face4 :: OctahedralCell 41088 Face4
invalidA080Face4 = OctahedralCell (Proxy @41088) (Proxy @Face4)

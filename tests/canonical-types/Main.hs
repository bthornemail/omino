{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Proxy (Proxy(..))
import GHC.TypeLits (symbolVal)
import OmiImo.CanonicalResolverAuthorities

verifyTetragrammatronSystem :: AuthorityEnvelope TetragrammatronGovernor 120
verifyTetragrammatronSystem = TetragrammatronToken (Proxy @120)

verifyTetragrammatronFold :: AuthorityEnvelope TetragrammatronGovernor 60
verifyTetragrammatronFold = TetragrammatronToken (Proxy @60)

verifyMetatronFlags :: AuthorityEnvelope MetatronScribe 24
verifyMetatronFlags = MetatronToken (Proxy @24)

verifyMetatronCarry :: AuthorityEnvelope MetatronScribe 65536
verifyMetatronCarry = MetatronToken (Proxy @65536)

verifyGnomonicA :: AuthorityEnvelope GnomonicAzimuth 43605
verifyGnomonicA = GnomonicToken (Proxy @43605)

verifyGnomonicB :: AuthorityEnvelope GnomonicAzimuth 21930
verifyGnomonicB = GnomonicToken (Proxy @21930)

checkLowAffinePlane :: PlaneWitness 72
checkLowAffinePlane =
  PlaneWitness
    (Proxy @72)
    (Proxy @(ClassifyAddressPlane 72))

plane72Name :: String
plane72Name = symbolVal (Proxy @(ClassifyAddressPlane 72))

main :: IO ()
main = do
  let _ = verifyTetragrammatronSystem
  let _ = verifyTetragrammatronFold
  let _ = verifyMetatronFlags
  let _ = verifyMetatronCarry
  let _ = verifyGnomonicA
  let _ = verifyGnomonicB
  let _ = checkLowAffinePlane
  putStrLn "Canonical resolver authority type invariants verified."
  putStrLn ("Address 0x48 plane: " ++ plane72Name)

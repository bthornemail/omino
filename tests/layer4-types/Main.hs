{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.Layer4TetrahedronCore
import GHC.TypeLits (KnownNat, natVal)

verifyCentroid :: EntrainmentToken 0 0
verifyCentroid = LockWavefront (Proxy @0) (Proxy @0)

verifyOuter :: EntrainmentToken 15 1
verifyOuter = LockWavefront (Proxy @15) (Proxy @1)

verifyInternal :: EntrainmentToken 10 6
verifyInternal = LockWavefront (Proxy @10) (Proxy @6)

verifyCentral :: EntrainmentToken 11 12
verifyCentral = LockWavefront (Proxy @11) (Proxy @12)

verifyCompact :: BranchToken 7 Compact743
verifyCompact = BranchToken (Proxy @7) (Proxy @Compact743)

verifyExtended :: BranchToken 8 Extended844
verifyExtended = BranchToken (Proxy @8) (Proxy @Extended844)

weightB :: KnownNat (ResolvePascalWeight 11) => Integer
weightB = natVal (Proxy @(ResolvePascalWeight 11))

main :: IO ()
main = do
  let _ = verifyCentroid
  let _ = verifyOuter
  let _ = verifyInternal
  let _ = verifyCentral
  let _ = verifyCompact
  let _ = verifyExtended
  putStrLn "Layer-4 Pascal multiplicity type invariants verified."
  putStrLn ("Nibble 0xB weight: " ++ show weightB)

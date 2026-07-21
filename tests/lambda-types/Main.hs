{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Proxy (Proxy(..))
import EmergentAxialLisp.LambdaCanonTypeCore
import GHC.TypeLits (KnownNat, natVal)

proveAbsoluteCentroid :: CentroidProof 0 0
proveAbsoluteCentroid = ProveVoidCore

validateOmiPortGate :: VerifiedLambdaBlock 15 30
validateOmiPortGate = OmiPortGate (Proxy @15) (Proxy @30)

compileCanonicalBlock
  :: LambdaCanonBlock
      "rules.o"
      "asserts"
      "fact_0x48"
      "incidence"
      "epistemology"
compileCanonicalBlock =
  AssembleBlock
    (BindPair (Proxy @LevelM1) (Proxy @"rules.o"))
    (BindPair (Proxy @Level0) (Proxy @"asserts"))
    (BindPair (Proxy @Level1) (Proxy @"fact_0x48"))
    (BindPair (Proxy @Level2) (Proxy @"incidence"))
    (BindPair (Proxy @Level3) (Proxy @"epistemology"))

lockObserverBoundary :: IsObserverBoundary 128 => String
lockObserverBoundary = "Shifted 0x80 observer boundary locked."

requireDeclarationToken :: RequireAscii7 127 => Proxy (ClassifyMuxBand 127)
requireDeclarationToken = Proxy

asciiGuardWitness :: ()
asciiGuardWitness = requireAscii7 (Proxy @127)

observerGuardWitness :: ()
observerGuardWitness = requireObserverBoundary (Proxy @128)

trackingValue :: KnownNat (EvaluateQ 15 30) => Integer
trackingValue = natVal (Proxy @(EvaluateQ 15 30))

main :: IO ()
main = do
  let _ = proveAbsoluteCentroid
  let _ = validateOmiPortGate
  let _ = compileCanonicalBlock
  let _ = requireDeclarationToken
  let _ = asciiGuardWitness
  let _ = observerGuardWitness
  putStrLn "Lambda Canon type-level invariants verified."
  putStrLn lockObserverBoundary
  putStrLn ("Verified tracking value Q(15,30): " ++ show trackingValue)

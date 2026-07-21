{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Data.Proxy (Proxy (..))
import GHC.TypeLits (KnownNat, natVal)
import Omino.ConformanceGuardrail

conformingMaxCeiling :: ConformanceToken 6 2 239
conformingMaxCeiling = LockToken

conformingOriginCentroid :: ConformanceToken 0 0 0
conformingOriginCentroid = LockToken

conformingMirror :: MirrorToken 0 128
conformingMirror = MirrorToken

conformingAssembler :: AssemblerToken 5039 127
conformingAssembler = AssemblerToken

slotValue :: forall f r l. KnownNat (ComputeSlot f r l) => Integer
slotValue = natVal (Proxy @(ComputeSlot f r l))

mirrorValue :: forall local. KnownNat (MirrorAxis local) => Integer
mirrorValue = natVal (Proxy @(MirrorAxis local))

main :: IO ()
main = do
  let _ = conformingMaxCeiling
  let _ = conformingOriginCentroid
  let _ = conformingMirror
  let _ = conformingAssembler
  putStrLn "Omino conformance guardrail type invariants verified."
  putStrLn ("MirrorAxis(0x00): " ++ show (mirrorValue @0))
  putStrLn ("Slot(6,2,239): " ++ show (slotValue @6 @2 @239))

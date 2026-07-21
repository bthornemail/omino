{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE GADTs #-}

module Main where

import Data.Proxy (Proxy (..))
import GHC.TypeLits (KnownNat, natVal)
import EmergentAxialLisp.MetaCompilerCore

verifyOriginSlot :: VerifiedSlot 0 0 0
verifyOriginSlot = VerifiedSlot

verifyIntermediateSlot :: VerifiedSlot 2 1 100
verifyIntermediateSlot = VerifiedSlot

verifyMaxSlot :: VerifiedSlot 6 2 239
verifyMaxSlot = VerifiedSlot

verifyAssemblerWord :: MachineInstruction 2 1780 63
verifyAssemblerWord = MachineInstruction

slotValue :: forall f r l. KnownNat (Slot5040 f r l) => Integer
slotValue = natVal (Proxy @(Slot5040 f r l))

main :: IO ()
main = do
  let _ = verifyOriginSlot
  let _ = verifyIntermediateSlot
  let _ = verifyMaxSlot
  let _ = verifyAssemblerWord
  case (advanceStage (SurfaceExpr "omi---imo?O_o") :: Either String (AST 'Parsed)) of
    Right (ParsedExpr [_]) -> pure ()
    _ -> error "surface parser did not preserve expression"
  case (advanceStage (CoreIR [CoreNil, CoreSlot 1780]) :: Either String (AST 'Lowered)) of
    Right (BinaryBlob bytes)
      | bytes == [0xF8, 0x00, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0xF8] -> pure ()
    _ -> error "resolved lowering emitted unexpected bytes"
  putStrLn "Meta-compiler type-level pipeline invariants verified."
  putStrLn ("Slot(2,1,100): " ++ show (slotValue @2 @1 @100))
  putStrLn ("Slot(6,2,239): " ++ show (slotValue @6 @2 @239))

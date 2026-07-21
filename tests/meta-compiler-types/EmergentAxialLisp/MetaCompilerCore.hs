{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE NoStarIsType #-}

module EmergentAxialLisp.MetaCompilerCore where

import Data.Kind (Constraint)
import Data.Word (Word8, Word16, Word32)
import GHC.TypeLits

data CoreInst
  = CoreNil
  | CorePair Word32 Word32
  | CoreScope Word8
  | CoreLower Word16
  | CoreSlot Word16
  deriving (Eq, Show)

data Stage
  = Surface
  | Parsed
  | Expanded
  | Typed
  | Normalized
  | Resolved
  | Lowered

type family NextStage (s :: Stage) :: Stage where
  NextStage 'Surface = 'Parsed
  NextStage 'Parsed = 'Expanded
  NextStage 'Expanded = 'Typed
  NextStage 'Typed = 'Normalized
  NextStage 'Normalized = 'Resolved
  NextStage 'Resolved = 'Lowered

data AST (stage :: Stage) where
  SurfaceExpr :: String -> AST 'Surface
  ParsedExpr :: [String] -> AST 'Parsed
  CoreIR :: [CoreInst] -> AST 'Resolved
  BinaryBlob :: [Word8] -> AST 'Lowered

class PureCompilerPass (current :: Stage) (next :: Stage) where
  advanceStage :: AST current -> Either String (AST next)

instance PureCompilerPass 'Surface 'Parsed where
  advanceStage (SurfaceExpr str) = Right (ParsedExpr [str])

instance PureCompilerPass 'Resolved 'Lowered where
  advanceStage (CoreIR _instructions) =
    Right (BinaryBlob [0xF8, 0x00, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0xF8])

type family IfC (cond :: Bool) (t :: Constraint) (f :: Constraint) :: Constraint where
  IfC 'True t _f = t
  IfC 'False _t f = f

type family Slot5040 (fano7 :: Nat) (role3 :: Nat) (local240 :: Nat) :: Nat where
  Slot5040 fano7 role3 local240 = (fano7 * 720) + (role3 * 240) + local240

type family RequireFano7 (fano7 :: Nat) :: Constraint where
  RequireFano7 fano7 =
    IfC
      (fano7 <=? 6)
      (() :: Constraint)
      (TypeError (Text "Fano selector out of range: " :<>: ShowType fano7))

type family RequireRole3 (role3 :: Nat) :: Constraint where
  RequireRole3 role3 =
    IfC
      (role3 <=? 2)
      (() :: Constraint)
      (TypeError (Text "Role selector out of range: " :<>: ShowType role3))

type family RequireLocal240 (local240 :: Nat) :: Constraint where
  RequireLocal240 local240 =
    IfC
      (local240 <=? 239)
      (() :: Constraint)
      (TypeError (Text "Local240 selector out of range: " :<>: ShowType local240))

type family RequireSlot5040 (slot :: Nat) :: Constraint where
  RequireSlot5040 slot =
    IfC
      (slot <=? 5039)
      (() :: Constraint)
      (TypeError (Text "Slot5040 out of range: " :<>: ShowType slot))

type family RequireAscii7 (token :: Nat) :: Constraint where
  RequireAscii7 token =
    IfC
      (token <=? 127)
      (() :: Constraint)
      (TypeError (Text "Character token exceeds 7-bit assembler surface: " :<>: ShowType token))

data VerifiedSlot (fano7 :: Nat) (role3 :: Nat) (local240 :: Nat) where
  VerifiedSlot ::
    ( RequireFano7 fano7,
      RequireRole3 role3,
      RequireLocal240 local240,
      RequireSlot5040 (Slot5040 fano7 role3 local240)
    ) =>
    VerifiedSlot fano7 role3 local240

data MachineInstruction (opcode :: Nat) (slot :: Nat) (token :: Nat) where
  MachineInstruction ::
    (RequireSlot5040 slot, RequireAscii7 token) =>
    MachineInstruction opcode slot token

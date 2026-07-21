{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE NoStarIsType #-}

module Omino.ConformanceGuardrail where

import Data.Kind (Constraint)
import GHC.TypeLits

type family MirrorAxis (selector :: Nat) :: Nat where
  MirrorAxis selector = selector + 128

type family ComputeSlot (fano :: Nat) (role3 :: Nat) (local :: Nat) :: Nat where
  ComputeSlot fano role3 local = (fano * 720) + (role3 * 240) + local

type family IfC (cond :: Bool) (t :: Constraint) (f :: Constraint) :: Constraint where
  IfC 'True t _f = t
  IfC 'False _t f = f

type family AssertFanoBounds (fano :: Nat) :: Constraint where
  AssertFanoBounds fano =
    IfC
      (fano <=? 6)
      (() :: Constraint)
      (TypeError (Text "Conformance failure: fano7 selector out of range: " :<>: ShowType fano))

type family AssertRoleBounds (role3 :: Nat) :: Constraint where
  AssertRoleBounds role3 =
    IfC
      (role3 <=? 2)
      (() :: Constraint)
      (TypeError (Text "Conformance failure: role3 selector out of range: " :<>: ShowType role3))

type family AssertLocal240Bounds (local :: Nat) :: Constraint where
  AssertLocal240Bounds local =
    IfC
      (local <=? 239)
      (() :: Constraint)
      (TypeError (Text "Conformance failure: local240 selector out of range: " :<>: ShowType local))

type family AssertSlotBounds (slot :: Nat) :: Constraint where
  AssertSlotBounds slot =
    IfC
      (slot <=? 5039)
      (() :: Constraint)
      (TypeError (Text "Conformance failure: slot5040 out of range: " :<>: ShowType slot))

type family AssertAscii7 (token :: Nat) :: Constraint where
  AssertAscii7 token =
    IfC
      (token <=? 127)
      (() :: Constraint)
      (TypeError (Text "Conformance failure: token exceeds 7-bit declaration surface: " :<>: ShowType token))

data MirrorToken (local :: Nat) (remote :: Nat) where
  MirrorToken :: (remote ~ MirrorAxis local) => MirrorToken local remote

data ConformanceToken (fano :: Nat) (role3 :: Nat) (local :: Nat) where
  LockToken ::
    ( AssertFanoBounds fano,
      AssertRoleBounds role3,
      AssertLocal240Bounds local,
      AssertSlotBounds (ComputeSlot fano role3 local)
    ) =>
    ConformanceToken fano role3 local

data AssemblerToken (slot :: Nat) (token :: Nat) where
  AssemblerToken ::
    (AssertSlotBounds slot, AssertAscii7 token) =>
    AssemblerToken slot token

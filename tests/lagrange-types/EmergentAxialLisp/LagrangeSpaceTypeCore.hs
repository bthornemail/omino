{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE NoStarIsType #-}

module EmergentAxialLisp.LagrangeSpaceTypeCore where

import Data.Kind (Constraint)
import Data.Proxy (Proxy)
import GHC.TypeLits

type family IfC (cond :: Bool) (t :: Constraint) (f :: Constraint) :: Constraint where
  IfC 'True t _f = t
  IfC 'False _t f = f

type family AssertByteBounds (byte :: Nat) :: Constraint where
  AssertByteBounds byte =
    IfC
      (byte <=? 127)
      (() :: Constraint)
      (TypeError (Text "Lagrange space byte exceeds 7-bit range: " :<>: ShowType byte))

type family AssertBandBounds (band :: Nat) :: Constraint where
  AssertBandBounds band =
    IfC
      (band <=? 3)
      (() :: Constraint)
      (TypeError (Text "Lagrange fold band out of range: " :<>: ShowType band))

type family AssertSlotBounds (slot :: Nat) :: Constraint where
  AssertSlotBounds slot =
    IfC
      (slot <=? 31)
      (() :: Constraint)
      (TypeError (Text "Lagrange fold slot out of range: " :<>: ShowType slot))

type family UnfoldBand (byte :: Nat) :: Nat where
  UnfoldBand byte = (byte `Div` 32) `Mod` 4

type family UnfoldSlot (byte :: Nat) :: Nat where
  UnfoldSlot byte = byte `Mod` 32

type family FoldByte (band :: Nat) (slot :: Nat) :: Nat where
  FoldByte band slot = (band * 32) + slot

data LagrangeSpaceCell (byte :: Nat) (band :: Nat) (slot :: Nat) where
  LockSpaceCell ::
    (AssertByteBounds byte, band ~ UnfoldBand byte, slot ~ UnfoldSlot byte) =>
    Proxy byte ->
    Proxy band ->
    Proxy slot ->
    LagrangeSpaceCell byte band slot

data FoldedByte (band :: Nat) (slot :: Nat) (byte :: Nat) where
  LockFoldedByte ::
    (AssertBandBounds band, AssertSlotBounds slot, byte ~ FoldByte band slot) =>
    Proxy band ->
    Proxy slot ->
    Proxy byte ->
    FoldedByte band slot byte

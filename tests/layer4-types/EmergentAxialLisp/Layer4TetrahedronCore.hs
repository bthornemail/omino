{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE NoStarIsType #-}

module EmergentAxialLisp.Layer4TetrahedronCore where

import Data.Kind (Constraint, Type)
import Data.Proxy (Proxy)
import GHC.TypeLits

data Compact743
data Extended844

type family IfC (cond :: Bool) (t :: Constraint) (f :: Constraint) :: Constraint where
  IfC 'True t _f = t
  IfC 'False _t f = f

type family AssertNibbleBounds (nibble :: Nat) :: Constraint where
  AssertNibbleBounds nibble =
    IfC
      (nibble <=? 15)
      (() :: Constraint)
      (TypeError (Text "Layer-4 nibble out of four-bit range: " :<>: ShowType nibble))

type family ResolvePascalWeight (nibble :: Nat) :: Nat where
  ResolvePascalWeight 0 = 0
  ResolvePascalWeight 1 = 1
  ResolvePascalWeight 7 = 1
  ResolvePascalWeight 15 = 1
  ResolvePascalWeight 4 = 6
  ResolvePascalWeight 10 = 6
  ResolvePascalWeight 14 = 6
  ResolvePascalWeight 11 = 12
  ResolvePascalWeight _n = 4

type family ResolveLayer4Branch (nibble :: Nat) :: Type where
  ResolveLayer4Branch nibble = IfT (nibble <=? 7) Compact743 Extended844

type family IfT (cond :: Bool) (t :: Type) (f :: Type) :: Type where
  IfT 'True t _f = t
  IfT 'False _t f = f

data EntrainmentToken (nibble :: Nat) (weight :: Nat) where
  LockWavefront ::
    (AssertNibbleBounds nibble, weight ~ ResolvePascalWeight nibble) =>
    Proxy nibble ->
    Proxy weight ->
    EntrainmentToken nibble weight

data BranchToken (nibble :: Nat) (branch :: Type) where
  BranchToken ::
    (AssertNibbleBounds nibble, branch ~ ResolveLayer4Branch nibble) =>
    Proxy nibble ->
    Proxy branch ->
    BranchToken nibble branch

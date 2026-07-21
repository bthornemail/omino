{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE NoStarIsType #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

module EmergentAxialLisp.OctahedralTypeCore
  ( Face0
  , Face1
  , Face2
  , Face3
  , Face4
  , Face5
  , Face6
  , Face7
  , Local64
  , Remote83
  , RowNibble
  , ColNibble
  , FaceIndex
  , ResolveFace
  , InterfaceOf
  , InterfaceKind
  , OctahedralCell(..)
  , InterfaceCell(..)
  ) where

import Data.Kind (Type)
import Data.Proxy (Proxy)
import GHC.TypeLits

data Face0 -- Local 6:4 / LOGOS head
data Face1 -- Local 6:4 / NOMOS path
data Face2 -- Local 6:4 / PATHOS body
data Face3 -- Local 6:4 / HINGE limit
data Face4 -- Remote 8:3 / LOGOS mirror
data Face5 -- Remote 8:3 / NOMOS mirror
data Face6 -- Remote 8:3 / PATHOS mirror
data Face7 -- Remote 8:3 / HINGE mirror

data Local64
data Remote83

type family RowNibble (addr :: Nat) :: Nat where
  RowNibble addr = (addr `Div` 4096) `Mod` 16

type family ColNibble (addr :: Nat) :: Nat where
  ColNibble addr = (addr `Div` 16) `Mod` 16

type family FaceIndex (addr :: Nat) :: Nat where
  FaceIndex addr = ((RowNibble addr `Div` 4) * 2) + (ColNibble addr `Div` 8)

type family FaceByIndex (idx :: Nat) :: Type where
  FaceByIndex 0 = Face0
  FaceByIndex 1 = Face1
  FaceByIndex 2 = Face2
  FaceByIndex 3 = Face3
  FaceByIndex 4 = Face4
  FaceByIndex 5 = Face5
  FaceByIndex 6 = Face6
  FaceByIndex 7 = Face7
  FaceByIndex idx =
    TypeError
      ( 'Text "Octahedral face index out of range: "
        ':<>: 'ShowType idx
      )

type family ResolveFace (addr :: Nat) :: Type where
  ResolveFace addr = FaceByIndex (FaceIndex addr)

type family InterfaceOf (face :: Type) :: Type where
  InterfaceOf Face0 = Local64
  InterfaceOf Face1 = Local64
  InterfaceOf Face2 = Local64
  InterfaceOf Face3 = Local64
  InterfaceOf Face4 = Remote83
  InterfaceOf Face5 = Remote83
  InterfaceOf Face6 = Remote83
  InterfaceOf Face7 = Remote83

type family InterfaceKind (face :: Type) :: Symbol where
  InterfaceKind Face0 = "User-Local 6:4 Concentric Interface"
  InterfaceKind Face1 = "User-Local 6:4 Concentric Interface"
  InterfaceKind Face2 = "User-Local 6:4 Concentric Interface"
  InterfaceKind Face3 = "User-Local 6:4 Concentric Interface"
  InterfaceKind Face4 = "User-Remote 8:3 Triple Interface"
  InterfaceKind Face5 = "User-Remote 8:3 Triple Interface"
  InterfaceKind Face6 = "User-Remote 8:3 Triple Interface"
  InterfaceKind Face7 = "User-Remote 8:3 Triple Interface"

data OctahedralCell (addr :: Nat) (face :: Type) where
  OctahedralCell
    :: (KnownNat addr, face ~ ResolveFace addr)
    => Proxy addr
    -> Proxy face
    -> OctahedralCell addr face

data InterfaceCell (addr :: Nat) (iface :: Type) where
  InterfaceCell
    :: (KnownNat addr, iface ~ InterfaceOf (ResolveFace addr))
    => Proxy addr
    -> Proxy iface
    -> InterfaceCell addr iface

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE NoStarIsType #-}

module EmergentAxialLisp.MetamorphicCompilerCore where

import Data.Kind (Constraint)
import Data.Proxy (Proxy)
import GHC.TypeLits

data TargetForm = EmergentAxialLispForm | FirstFormVoidCore

type family CompileSignature (form :: TargetForm) (x :: Nat) (y :: Nat) :: Nat where
  CompileSignature 'EmergentAxialLispForm x y = (4 * x) + (2 * y)
  CompileSignature 'FirstFormVoidCore _x _y = 0

type family SameNat (a :: Nat) (b :: Nat) :: Bool where
  SameNat a a = 'True
  SameNat _a _b = 'False

type family IfC (cond :: Bool) (t :: Constraint) (f :: Constraint) :: Constraint where
  IfC 'True t _f = t
  IfC 'False _t f = f

type family AssertExportIdentity (x :: Nat) (y :: Nat) :: Constraint where
  AssertExportIdentity x y =
    IfC
      (SameNat (CompileSignature 'EmergentAxialLispForm x y) (CompileSignature 'FirstFormVoidCore x y))
      (() :: Constraint)
      (TypeError (Text "Metamorphic export identity only holds at the centroid signature."))

data MetamorphicToken (x :: Nat) (y :: Nat) where
  LockExportInvariance ::
    AssertExportIdentity x y =>
    Proxy x ->
    Proxy y ->
    MetamorphicToken x y

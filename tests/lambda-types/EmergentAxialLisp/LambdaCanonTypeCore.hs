{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE NoStarIsType #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

module EmergentAxialLisp.LambdaCanonTypeCore
  ( LinearRoot
  , EvaluateQ
  , LevelM1
  , Level0
  , Level1
  , Level2
  , Level3
  , LambdaBlockPair(..)
  , LambdaCanonBlock(..)
  , ClassifyMuxBand
  , RequireAscii7
  , requireAscii7
  , IsObserverBoundary
  , requireObserverBoundary
  , VerifiedLambdaBlock(..)
  , CentroidProof(..)
  ) where

import Data.Kind (Constraint, Type)
import Data.Proxy (Proxy)
import GHC.TypeLits

type family LinearRoot (x :: Nat) (y :: Nat) :: Nat where
  LinearRoot x y = (4 * x) + (2 * y)

type family EvaluateQ (x :: Nat) (y :: Nat) :: Nat where
  EvaluateQ x y = LinearRoot x y * LinearRoot x y

data LevelM1 -- subject / notation
data Level0  -- predicate / citation
data Level1  -- object / attestation
data Level2  -- ontology / annotation
data Level3  -- epistemology / interpretation

data LambdaBlockPair (level :: Type) (notation :: Symbol) where
  BindPair :: KnownSymbol notation => Proxy level -> Proxy notation -> LambdaBlockPair level notation

data LambdaCanonBlock
  (subject :: Symbol)
  (predicate :: Symbol)
  (object :: Symbol)
  (ontology :: Symbol)
  (epistemology :: Symbol) where
  AssembleBlock
    :: LambdaBlockPair LevelM1 subject
    -> LambdaBlockPair Level0 predicate
    -> LambdaBlockPair Level1 object
    -> LambdaBlockPair Level2 ontology
    -> LambdaBlockPair Level3 epistemology
    -> LambdaCanonBlock subject predicate object ontology epistemology

type family If (cond :: Bool) (trueBranch :: k) (falseBranch :: k) :: k where
  If 'True trueBranch _ = trueBranch
  If 'False _ falseBranch = falseBranch

type family ClassifyMuxBand (token :: Nat) :: Symbol where
  ClassifyMuxBand token =
    If (token <=? 32)
      "Band 0: Pre-Language Control through SP Hinge"
      (If (token <=? 64)
        "Band 1: Control + Structure + Predicate Surface (@)"
        (If (token <=? 96)
          "Band 2: Control + Structure + Upper Meta Surface (`)"
          (If (token <=? 127)
            "Band 3: Full 7-Bit Declaration Surface (DEL)"
            (TypeError
              ( 'Text "Token exceeds valid 7-bit ASCII threshold: "
                ':<>: 'ShowType token
              )))))

type family RequireAscii7 (token :: Nat) :: Constraint where
  RequireAscii7 token =
    If (token <=? 127)
      (() :: Constraint)
      (TypeError
        ( 'Text "Token exceeds valid 7-bit ASCII threshold: "
          ':<>: 'ShowType token
        ))

type family IsObserverBoundary (token :: Nat) :: Constraint where
  IsObserverBoundary 128 = ()
  IsObserverBoundary token =
    TypeError
      ( 'Text "Observer position violation: expected shifted 0x80 boundary, got "
        ':<>: 'ShowType token
      )

requireAscii7 :: RequireAscii7 token => Proxy token -> ()
requireAscii7 _ = ()

requireObserverBoundary :: IsObserverBoundary token => Proxy token -> ()
requireObserverBoundary _ = ()

data VerifiedLambdaBlock (x :: Nat) (y :: Nat) where
  OmiPortGate
    :: KnownNat (EvaluateQ x y)
    => Proxy x
    -> Proxy y
    -> VerifiedLambdaBlock x y

data CentroidProof (x :: Nat) (y :: Nat) where
  ProveVoidCore :: (EvaluateQ x y ~ 0) => CentroidProof x y

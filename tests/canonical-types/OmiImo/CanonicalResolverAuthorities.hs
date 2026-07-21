{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE NoStarIsType #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

module OmiImo.CanonicalResolverAuthorities
  ( TetragrammatronGovernor
  , MetatronScribe
  , GnomonicAzimuth
  , OmicronGauge
  , OmnicronResolver
  , IsTetragrammatronWitness
  , IsMetatronWitness
  , IsGnomonicWitness
  , ClassifyAddressPlane
  , AuthorityEnvelope(..)
  , PlaneWitness(..)
  ) where

import Data.Kind (Constraint, Type)
import Data.Proxy (Proxy)
import GHC.TypeLits

data TetragrammatronGovernor
data MetatronScribe
data GnomonicAzimuth
data OmicronGauge
data OmnicronResolver

type family IsTetragrammatronWitness (w :: Nat) :: Constraint where
  IsTetragrammatronWitness 30 = ()
  IsTetragrammatronWitness 60 = ()
  IsTetragrammatronWitness 120 = ()
  IsTetragrammatronWitness w =
    TypeError
      ( 'Text "Witness violation: Tetragrammatron only owns 0x1E, 0x3C, or 0x78; got "
        ':<>: 'ShowType w
      )

type family IsMetatronWitness (w :: Nat) :: Constraint where
  IsMetatronWitness 24 = ()
  IsMetatronWitness 1 = ()
  IsMetatronWitness 16 = ()
  IsMetatronWitness 256 = ()
  IsMetatronWitness 4096 = ()
  IsMetatronWitness 65536 = ()
  IsMetatronWitness w =
    TypeError
      ( 'Text "Witness violation: Metatron only owns 0x18 or hexadecimal place steps; got "
        ':<>: 'ShowType w
      )

type family IsGnomonicWitness (w :: Nat) :: Constraint where
  IsGnomonicWitness 43605 = ()
  IsGnomonicWitness 21930 = ()
  IsGnomonicWitness w =
    TypeError
      ( 'Text "Witness violation: Gnomonic Azimuth only owns 0xAA55 or 0x55AA; got "
        ':<>: 'ShowType w
      )

type family If (cond :: Bool) (trueBranch :: k) (falseBranch :: k) :: k where
  If 'True trueBranch _ = trueBranch
  If 'False _ falseBranch = falseBranch

type family ClassifyAddressPlane (addr :: Nat) :: Symbol where
  ClassifyAddressPlane addr =
    If (addr <=? 31)
      "Omnicron Low Control Plane (0x00..0x1F)"
      (If (addr <=? 127)
        "Omicron Bounded Low Affine Gauge Space (0x20..0x7F)"
        (If (addr <=? 159)
          "Omnicron High Projective Control Plane (0x80..0x9F)"
          (If (addr <=? 255)
            "Omnicron High Projective Space Surface (0xA0..0xFF)"
            (TypeError
              ( 'Text "Address out of valid 8-bit byte plane: "
                ':<>: 'ShowType addr
              )))))

data AuthorityEnvelope (authority :: Type) (witness :: Nat) where
  TetragrammatronToken
    :: IsTetragrammatronWitness witness
    => Proxy witness
    -> AuthorityEnvelope TetragrammatronGovernor witness
  MetatronToken
    :: IsMetatronWitness witness
    => Proxy witness
    -> AuthorityEnvelope MetatronScribe witness
  GnomonicToken
    :: IsGnomonicWitness witness
    => Proxy witness
    -> AuthorityEnvelope GnomonicAzimuth witness

data PlaneWitness (addr :: Nat) where
  PlaneWitness
    :: (KnownNat addr, KnownSymbol (ClassifyAddressPlane addr))
    => Proxy addr
    -> Proxy (ClassifyAddressPlane addr)
    -> PlaneWitness addr

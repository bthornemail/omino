{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.LagrangeSpaceTypeCore
import GHC.TypeLits (KnownNat, natVal)

verifyOrigin :: LagrangeSpaceCell 0 0 0
verifyOrigin = LockSpaceCell (Proxy @0) (Proxy @0) (Proxy @0)

verifyCeiling :: LagrangeSpaceCell 127 3 31
verifyCeiling = LockSpaceCell (Proxy @127) (Proxy @3) (Proxy @31)

verifyFold :: FoldedByte 3 21 117
verifyFold = LockFoldedByte (Proxy @3) (Proxy @21) (Proxy @117)

foldedValue :: KnownNat (FoldByte 3 21) => Integer
foldedValue = natVal (Proxy @(FoldByte 3 21))

main :: IO ()
main = do
  let _ = verifyOrigin
  let _ = verifyCeiling
  let _ = verifyFold
  putStrLn "Lagrange space type invariants verified."
  putStrLn ("FoldByte(3,21): " ++ show foldedValue)

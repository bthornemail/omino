{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Proxy (Proxy (..))
import EmergentAxialLisp.MetamorphicCompilerCore
import GHC.TypeLits (KnownNat, natVal)

verifyCentroidExport :: MetamorphicToken 0 0
verifyCentroidExport = LockExportInvariance (Proxy @0) (Proxy @0)

centroidSignature :: KnownNat (CompileSignature 'EmergentAxialLispForm 0 0) => Integer
centroidSignature = natVal (Proxy @(CompileSignature 'EmergentAxialLispForm 0 0))

activeSignature :: KnownNat (CompileSignature 'EmergentAxialLispForm 15 30) => Integer
activeSignature = natVal (Proxy @(CompileSignature 'EmergentAxialLispForm 15 30))

main :: IO ()
main = do
  let _ = verifyCentroidExport
  putStrLn "Metamorphic export type invariants verified."
  putStrLn ("Centroid signature: " ++ show centroidSignature)
  putStrLn ("Active Q-line signature for (15,30): " ++ show activeSignature)

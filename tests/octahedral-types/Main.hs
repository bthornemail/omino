{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Proxy (Proxy(..))
import EmergentAxialLisp.OctahedralTypeCore
import GHC.TypeLits (KnownNat, natVal, symbolVal)

verifyCentroidCore :: OctahedralCell 0 Face0
verifyCentroidCore = OctahedralCell (Proxy @0) (Proxy @Face0)

verifyRemoteGate :: OctahedralCell 41088 Face5
verifyRemoteGate = OctahedralCell (Proxy @41088) (Proxy @Face5)

verifyRemoteInterface :: InterfaceCell 41088 Remote83
verifyRemoteInterface = InterfaceCell (Proxy @41088) (Proxy @Remote83)

verifyLocalInterface :: InterfaceCell 0 Local64
verifyLocalInterface = InterfaceCell (Proxy @0) (Proxy @Local64)

faceIndexA080 :: KnownNat (FaceIndex 41088) => Integer
faceIndexA080 = natVal (Proxy @(FaceIndex 41088))

rowNibbleA080 :: KnownNat (RowNibble 41088) => Integer
rowNibbleA080 = natVal (Proxy @(RowNibble 41088))

colNibbleA080 :: KnownNat (ColNibble 41088) => Integer
colNibbleA080 = natVal (Proxy @(ColNibble 41088))

interfaceA080 :: String
interfaceA080 = symbolVal (Proxy @(InterfaceKind (ResolveFace 41088)))

main :: IO ()
main = do
  let _ = verifyCentroidCore
  let _ = verifyRemoteGate
  let _ = verifyRemoteInterface
  let _ = verifyLocalInterface
  putStrLn "Octahedral type-level face invariants verified."
  putStrLn ("Address 0xA080 row nibble: " ++ show rowNibbleA080)
  putStrLn ("Address 0xA080 column nibble: " ++ show colNibbleA080)
  putStrLn ("Address 0xA080 face index: " ++ show faceIndexA080)
  putStrLn ("Address 0xA080 interface: " ++ interfaceA080)

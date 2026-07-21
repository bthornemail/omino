{-# LANGUAGE DataKinds #-}

module InvalidFano where

import Omino.ConformanceGuardrail

invalidFano :: ConformanceToken 7 0 0
invalidFano = LockToken

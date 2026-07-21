{-# LANGUAGE DataKinds #-}

module InvalidMirror where

import Omino.ConformanceGuardrail

invalidMirror :: MirrorToken 0 127
invalidMirror = MirrorToken

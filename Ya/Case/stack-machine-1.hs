import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import Ya.Expo.Instances

import "base" GHC.Num (Integer, (+))
import "base" System.IO (IO)

type Immediate v = v

type Operation v = v `LM` v `AR_` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v
pattern Operation x = That x :: Command v

load v = enter @(State `WR` List _ `JNT` Halts)
 `yuk_` New `ha` State `ha` Transition `he` push @List v

eval op = enter @(State `WR` List _ `JNT` Halts)
 `yuk_` New `ha` State `ha` Transition `he` pop @List
 `lu'yp` New `ha` State `ha` Transition `he` pop @List
 `yok_` Try `ha` Maybe `ha` (`yip'yo` op)
 `yok_` New `ha` State `ha` Transition `ha` push @List

initial = Construct
 `ha_` Next `he` Immediate 1
 `ha_` Next `he` Immediate 2
 `ha_` Next `he` Operation ((+) `hj`)
 `ha_` Next `he` Immediate 4
 `he_` Last `he` Operation ((+) `hj`)

main = (initial `yokl` Forth `ha` Run `ha__` load `la` eval) `he'he` Empty @List Unit
 `yi__` is `hu` "[ERR] No operands!" `ho_'yokl` Forth `ha` Raw `ha` output `la_` this `he'ho` trace where

 trace x = is @(Nonempty List ASCII) "[OK] Trace: " `yokl` Forth `ha` Raw `ha` output
  `yuk___` Raw `he____` x `yokl` Forth `ha`Run `ha__` integer `ho_'yokl` Forth `ha` Raw `ha` output
  `ho_'yuk` Raw `ha` output `he` Caret Space

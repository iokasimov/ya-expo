import Ya
import Ya.ASCII
import Ya.Expo.ASCII
import Ya.Expo.Instances
import Ya.Expo.Terminal

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

main = (initial `yokl` Forth `ha__` load `la` eval) `he'he` Empty @List Unit
 `yi__` is `hu` "[ERR] No operands!" `ho_'yokl` Forth `ha` output `la_` this `he'ho` trace where

 trace x = is @(Nonempty List ASCII) "[OK] Trace: " `yokl` Forth `ha` output
  `yuk___` New `he____` x `yokl` Forth `ha__` integer `ho_'yokl` Forth `ha` output
  `ho_'yuk` New `ha` output `he` Caret Space

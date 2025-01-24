import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import "base" GHC.Num (Integer, (+))

type Immediate v = v

type Operation v = v `LM` v `AR_` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x
pattern Operation x = That x

load value = enter @(State `WR` List _ `JNT` Halts)
 `yuk_` New `ha` State `ha` Transition `hv` push @List value

eval binop = enter @(State `WR` List _ `JNT` Halts)
 `yuk_` New `ha` State `ha` Transition `hv` pop @List
 `lu'yp` New `ha` State `ha` Transition `hv` pop @List
 `yok_` Try `ha` Maybe `ha` (`yip'yo` binop)
 `yok_` New `ha` State `ha` Transition `ha` push @List

initial = Construct
 `ha` (Item `hv` Immediate 1) `ha` Maybe `ha` Next
 `ha` (Item `hv` Immediate 2) `ha` Maybe `ha` Next
 `ha` (Item `hv` Operation ((+) `hj`)) `ha` Maybe `ha` Next
 `ha` (Item `hv` Immediate 4) `ha` Maybe `ha` Next
 `ha` (Item `hv` Operation ((+) `hj`)) `ha` Maybe `hv` Last

main = error `la` this `he'ho` trace
 `hv_______` initial `yokl` Forth `ha` Run `ha__` load `la` eval
 `he'he'hv___` Empty @List Unit where

 error _ = "[ERR] No operands!" `yokl` Forth `ha` Raw `ha` output

 trace x = is @(Nonempty List ASCII) "[OK] Trace: " `yokl` Forth `ha` Raw `ha` output
  `yuk___` Raw `hv____` x `yokl` Forth `ha` Run `ha__` integer
  `ho_'yokl` Forth `ha` Raw `ha` output `ha` Glyph `ha` Digit
  `ho_'yuk` Raw `ha` output `ha` Caret `hv` by Space

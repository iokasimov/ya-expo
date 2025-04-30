import Ya
import Ya.World
import Ya.ASCII
import Ya.Literal
import Ya.Console

import "base" GHC.Num (Integer, (+))

type Immediate v = v

type Operation v = v `P` v `AR` v

type Command v = Immediate v `S` Operation v

pattern Immediate x = This x
pattern Operation x = That x

load value = enter @(State `WR` List _ `JNT` Halts)
 `yuk_` New `ha` State `ha` Event `hv` push @List value

-- last = -- enter @(State `WR` List _ `JNT` Halts)
 -- `yuk_` New `ha` State `ha` Event `hv` pop @List

-- item = State `ha` Event `hv` pop @List

eval binop = enter @(State `WR` List Integer `JNT` Halts)
 `yuk_` New `ha` State `ha` Event `hv` pop @List @Integer
 `lu'yp` New `ha` State `ha` Event `hv` pop @List @Integer
 `yok_` Try `ha` (`yp'yo` binop) `ha'ho` Check
 `yok_` New `ha` State `ha` Event `ha` push @List @Integer

type Machine item = State `WR` List item `JNT` Halts

initial = Construct
 `ha` (Item `hv` Immediate 1) `ha` Next
 `ha` (Item `hv` Immediate 2) `ha` Next
 `ha` (Item `hv` Operation (is `ho'hd` (+))) `ha` Next
 `ha` (Item `hv` Immediate 4) `ha` Next
 `ha` (Item `hv` Operation (is `ho'hd` (+))) `ha` Last

main = error `la` this `he'ho` trace
 `hv_______` by `hv` initial
 `yokl` Forth `ha` Run
 `ha__` load `la` eval
 `he'he'hv___` Empty @List Unit where

 error _ = "[ERR] No operands!" `yokl` Forth `ha` Raw `ha` output

 trace x = is @(Nonempty List ASCII) "[OK] Trace: " `yokl` Forth `ha` Raw `ha` output
  `yuk___` Raw `hv____` x `yokl` Forth `ha` Run `ha__` integer
  `ho_'yokl` Forth `ha` Raw `ha` output `ha` Glyph `ha` Digit
  `ho_'yuk` Raw `ha` output `ha` Caret `hv` by Space

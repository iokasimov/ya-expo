import Ya
import Ya.ASCII
import Ya.Expo.ASCII
import Ya.Expo.Instances
import Ya.Expo.Terminal

import "base" GHC.Num (Integer, (+))
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (Show (show))
import "base" System.IO (IO, putStr)

type Immediate v = v

type Operation v = v `LM` v `AR_` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v
pattern Operation x = That x :: Command v

load v = is
 `he__` enter @(State `WR` List _ `JNT` Halts)
 `yuk_` State `ha` Transition `he` push @List v

eval op = is
 `he__` enter @(State `WR` List _ `JNT` Halts)
 `yuk_` State `ha` Transition `he` pop @List
 `lu'yp` State `ha` Transition `he` pop @List
 `yok_` Maybe `ha` (`yip'yo` op)
 `yok_` State `ha` Transition `ha` push @List

trace x = Forward @List "[OK] Trace: " `yokl` output
 `yuk__` x `yokl` integer `ho` Forward `ho'yokl` output `ho'yuk` output (Caret Space) `ho'yu` ()

print' = is `hu` Forward "[ERROR] No operands!" `ho'yokl` output -- `ho'yu` ()
 `la` this `he'ho` trace
 -- `heeee'la` that `he'ho`is `hoo'yokl` integer `ho` Forward @(Nonempty List) `ho'yokl` output `ho'yuk` output (Signal Space) `hoo'yu` ()
 -- `heeee'la` this `he'ho`pop `ho` this `ho`(is `hu`Forward "[ERROR] Impossible happened!" `hee'la`)

example = as @(Nonempty List) @(Command Integer) `he__` is
 `li` Immediate 1
 `lu` Immediate 2
 `lu` Operation ((+) `hj`)
 `lu` Immediate 4
 `lu` Operation ((+) `hj`)

main = print'
 `he____` Forward @(Nonempty List) example
   `yokl` load `ha` is @(Immediate Integer)
     `la` eval `ha` is @(Operation Integer)
  `he___'he` Empty @List ()

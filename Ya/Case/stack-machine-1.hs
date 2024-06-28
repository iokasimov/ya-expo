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

type Operation v = v `LM` v `ARR` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v
pattern Operation x = That x :: Command v

type Processing v = State `TI` List v `JT` Halts

load v = enter @(Processing _)
 `yukl` push @List v `u` State

eval op = enter @(Processing _)
 `yukl` pop @List `u` State `u` try
 `lm_dp` pop @List `u` State `u` try
 `yokl` op `u` is @(Operation _)
 `o` push @List `o` State

print = unwrap @Arrow @(Optional _)
 `oooooo` (pass `aaa` but @(List ASCII) "[ERROR] No operands!" `oo_yoklKL` Fore `a` output
 `yi_yi_rf` unwrap @Arrow
  `oooo` pass `aaa` but @(List ASCII) "[OK] Traced output: " `oo_yoklKL` Fore `a` output
   `cn_dp` (`yoklKL` Fore `aaa` show `o` putStr `oo_yukl` Space `u` Signal `u` output))

main = is @(Command Integer)
     `yi` Immediate 1
     `lm` Immediate 2
     `lm` Operation ((+) `j'`)
     `lm` Immediate 4
     `lm` Operation ((+) `j'`)
 `uuuuu` as @(Nonempty List) @(Command Integer)
 `yoklKL` Fore @(Processing Integer)
 `aaaaa` load `a` is @(Immediate Integer)
     `rf` eval `a` is @(Operation Integer)
 `yiii'_yi'` Empty @List ()
 `uuuuuu` print

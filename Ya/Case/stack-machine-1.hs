import Ya
import Ya.ASCII
import Ya.Expo.ASCII
import Ya.Expo.Instances
import Ya.Expo.Terminal

import "base" Data.Int (Int)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (Show (show))
import "base" System.IO (IO, putStr)
import Prelude ((+))

type Immediate v = v

type Operation v = v `LM` v `ARR` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v

pattern Operation x = That x :: Command v

type Processing v = State `TI` List v `JT` Halts

load :: Immediate v `ARR` Processing v v
load v = enter @(Processing _)
 `yukl` push @List v `u` State

eval :: Operation v `ARR` Processing v v
eval op = enter @(Processing _)
 `yukl` pop @List `u` State `u` try
 `lm_dp` pop @List `u` State `u` try
 `yokl` op `o` push @List `o` State

print = pass `aaa` is @(List ASCII) "[ERROR] No operands!" `oo_yoklKL` Forwards `a` output
 `yi_yi_rf` pass `aaa` is @(List ASCII) "[OK] Traced output: " `oo_yoklKL` Forwards `a` output
   `cn_dp` (`yoklKL` Forwards `aaa` show `o` putStr `oo_yukl` Space `u` Signal `u` output)

main = Construct
 `o` Nonempty @List
 `a` Next (Immediate 1)
 `a` Next (Immediate 2)
 `a` Next (Operation ((+) `j_`))
 `a` Next (Immediate 4)
 `i` Last (Operation ((+) `j_`))
 `yoklKL` Forwards @(Processing Int)
   `aaaa` Immediate `v` load
     `rf` Operation `v` eval
 `rwwwww_rw` Empty @List ()
 `u_u_u_u_u_u` print

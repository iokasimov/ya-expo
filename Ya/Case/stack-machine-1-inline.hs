import Ya
import Ya.ASCII
import Ya.Expo.ASCII
import Ya.Expo.Instances
import Ya.Expo.Terminal

import "base" Data.Int (Int)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (Show (show))
import "base" System.IO (IO, print, putChar, putStr)
import Prelude ((+))

type Immediate v = v

type Operation v = v `LM` v `ARR` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v

pattern Operation x = That x :: Command v

type Processing v = State `TI` List v `JT` Halts `TI` v

main = (Nonempty @List `a` Construct
 `a` Next (Immediate 1)
 `a` Next (Immediate 2)
 `a` Next (Operation ((+) `j'`))
 `a` Next (Immediate 4)
 `i` Last (Operation ((+) `j'`))
 `yi_yoklKL` Fore @(State `TI` List Int `JT` Halts)
  `aaaaaaa` intro @Int `oo_yokl` push @List `o` State @(List Int)
   `yi_yi_rf` pop @List `u` State `u` try
     `lm_dp` pop @List `u` State `u` try
     `yokl_a` push @List `o` State @(List Int)
  ) `yiii'_yi'` Empty @List ()
  `uuuuuu` (unwrap @Arrow `oooo`
    but "[ERROR] No operands!" `o` putStr
    `yi_rf` pass `aaa` but "[OK] Traced: " `o` putStr)
    `cn_dp` (`yoklKL` Fore `aaa` show `o` putStr `o_yukl` putChar ' ')

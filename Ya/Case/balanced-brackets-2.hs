import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" System.IO (print)

type Mismatch = Shape `LM` Shape

type Imbalance = Mismatch `ML` Bracket

pattern Mismatch x = This x :: Imbalance
pattern Missing x = That x :: Imbalance

remember bracket = enter
 @(State (List Shape) `JT` Error Imbalance)
 `yukl` push @List bracket `u` State

analyze bracket = enter
 @(State `TI` List Shape `JT` Error Imbalance)
 `yi_yukl` pop @List `u` State
 `yi_yokl` Error `a` Missing `a` Closed `aaa` but bracket
   `yi_rf` Error `a` Mismatch `rf` Valid `aaa` (`e` bracket)

remnant = Ok
 `rf` Error `a` Missing `a` Opened
 `a` inspect top `a` on @(Nonempty List)

main = is @Bracket
     `yi` Opened Angle
     `lm` Opened Curly
     `lm` Closed Curly
     `lm` Opened Angle
     `lm` Closed Square
 `uuuuu` as @(Nonempty List) @Bracket
 `yoklKL` Fore @(State `TI` List Shape `JT` Error Imbalance)
 `aaaaa` is @Shape `o` remember
     `rf` is @Shape `o` analyze
 `yiii'_yi'` Empty @List ()
 `yi_yokl` remnant `a'` this @(List Shape)
 `uuuuuu` on @List @ASCII
 `aaaaa` but "[ERROR] Lonely bracket"
     `rf` but "[ERROR] Mismatching brackets"
     `rf` but "[OKAY] Brackets are balanced"
 `yoklKL` Fore `a` output

import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" System.IO (print)

type Enclosed = Shape `LM` Shape

type Imbalance = Enclosed `ML` Bracket

pattern Mismatch x = This x :: Imbalance
pattern Missing x = That x :: Imbalance

remember bracket = enter
 @(State (List Shape) `JT` Error Imbalance)
 `yukl` push @List bracket `u` State

analyze bracket = enter
 @(State `TI` List Shape `JT` Error Imbalance)
 `yi_yukl` pop @List `u` State
 `yi_yokl` is bracket `oooo` Error `a` Missing `a` Closed
   `yi_rf` (`e` bracket) `ooo` Error `a` Mismatch `rf` Valid

main = literal
 `o` as @(Nonempty List `TI` Bracket)
 `yiiiii` Opened Angle
     `lm` Opened Curly
     `lm` Closed Curly
     `lm` Opened Angle
     `lm` Closed Square
 `yoklKL` Fore `aaa` remember `rf` analyze
 `rwwwww_rw` Empty @List ()
 `yi_yokl` Ok `rf` Error `a` Missing `a` Opened `a` inspect top `cn_dp` Ok
 `uuuuuu` print `a` is "[ERROR] Lonely bracket"
   `yi_rf` print `a` is "[ERROR] Mismatching brackets"
   `yi_rf` print `a` is "[OKAY] Brackets are balanced"

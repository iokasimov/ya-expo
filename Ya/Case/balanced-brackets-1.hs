import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" System.IO (print)

type Curved = ()

type Parenthesis = Curved `ML` Curved

remember p = enter
 @(State `TI` List Curved `JT` Error Parenthesis)
 `yukl` push @List p `u` State

analyze _ = enter
 @(State `TI` List Curved `JT` Error Parenthesis)
 `yi_yukl` pop @List `u` State
 `yi_yokl` Error `a` Closed `rf'` Valid

example =
 is @Parenthesis
 `yi` Opened ()
 -- `lm` Opened ()
 `lm` Closed ()
 -- `lm` Opened ()
 -- `lm` Closed ()

main = print `a` but "[ERROR] Lonely bracket"
  `yi_rf` print `a` but "[ERROR] Mismatching brackets"
  `yi_rf'` print `a` but "[OKAY] Brackets are balanced"
 `yi_yi_yi_yi` example `u` as @(Nonempty List) @Parenthesis
 `yoklKL` Fore `aaa` remember `rf` analyze
 `yiii'_yi'` Empty @List ()
 `yi_yokl` Ok `yi'_rf'` Error `a` Opened `a` inspect top `yi_cn'_dp` Ok

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
 `yi_yokl` unwrap @Arrow `ooo` Error `a` Closed
    `rf` Valid

example =
 is @Parenthesis
 `yi` Opened ()
 -- `lm` Opened ()
 `lm` Closed ()
 -- `lm` Opened ()
 -- `lm` Closed ()

main = example `u` as @(Nonempty List) @Parenthesis
 `yoklKL` Fore `aaa` remember `rf` analyze
 `yiii'_yi'` Empty @List ()
 `yi_yokl` ((Ok `rf` Error `a` Opened `a` inspect top `aaa` unwrap @Arrow `a` unwrap @Arrow) `cn_dp` Ok) `aaaa` unwrap @Arrow
 `uuuuuu` (print `a` but "[ERROR] Lonely bracket"
   `yi_rf` print `a` but "[ERROR] Mismatching brackets")
   `yi_rf` print `a` but "[OKAY] Brackets are balanced"
   `aaaa` unwrap @Arrow -- `a` unwrap @Arrow

import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" System.IO (print)

type Curved = ()

type Parenthesis = Curved `ML` Curved

-- remember p = enter
 -- @(State `TI` List Curved `JT` Error Parenthesis)
 -- `yuk` push @List p `hu` State

-- analyze _ = enter
 -- @(State `TI` List Curved `JT` Error Parenthesis)
 -- `yi'yuk` pop @List `hu` State
 -- `yi'yok` Error `ha` Closed `rfz` Valid

example =
 is @Parenthesis
 `li` Opened ()
 -- `lu` Opened ()
 `lu` Closed ()
 -- `lu` Opened ()
 -- `lu` Closed ()

main = print "typechecked"

-- main = (print `ha` but "[ERROR] Lonely bracket"
 -- `yi'rf` print `ha` but "[ERROR] Mismatching brackets"
 -- `yi'rfz` print `ha` but "[OKAY] Brackets are balanced")
 -- `yi'yi'yi'yi` (example `hu` as @(Nonempty List) @Parenthesis
 -- `yokl` way @Fore `haaa` remember `rf` analyze
 -- `_yiiiii` Empty @List ()
 -- `yi'yokl` Ok `_yi'rfz` Error `ha` Opened `ha` this `ha` unwrap top `yi'cnz'yp` Ok)

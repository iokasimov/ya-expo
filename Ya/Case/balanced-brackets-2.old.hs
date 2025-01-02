import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

type Mismatch = Shape `LM` Shape

type Imbalance = Mismatch `ML` Bracket

pattern Mismatch x = This x :: Imbalance
pattern Missing x = That x :: Imbalance

-- remember bracket = enter
 -- @(State (List Shape) `JT` Error Imbalance)
 -- `yuk` push @List bracket `hu` State

-- analyze bracket = enter
 -- @(State `TI` List Shape `JT` Error Imbalance)
 -- `yi'yuk` pop @List `hu` State
 -- `yi'yok` Error `ha` Missing `ha` Closed `haaa` but bracket
   -- `yi'rfz` Error `ha` Mismatch `rf` Valid `haaa` (`e` bracket)

-- remnant = Ok
 -- `_yi'rfz` Error `ha` Missing `ha` Opened
 -- `ha` this @Shape `ha` unwrap top `ha` on @(Nonempty List) @Shape

-- main = "typechecked"
-- main = is @Bracket
     -- `yi` Opened Angle
     -- `lm` Opened Curly
     -- `lm` Closed Curly
     -- `lm` Opened Angle
     -- `lm` Closed Square
 -- `huuuuu` as @(Nonempty List) @Bracket
 -- `yokl` way @Fore @(State `TI` List Shape `JT` Error Imbalance)
 -- `haaa` is @Shape `ho` remember
   -- `rf` is @Shape `ho` analyze
 -- `__yiiiii` Empty @List ()
 -- `yi'yok` remnant `ha_` this @(List Shape)
 -- `huuuuuu` on @List @ASCII
 -- `haaaaa` but "[ERROR] Lonely bracket"
     -- `rf` but "[ERROR] Mismatching brackets"
     -- `rfz` but "[OKAY] Brackets are balanced"
 -- `yokl` way @Fore `ha` output

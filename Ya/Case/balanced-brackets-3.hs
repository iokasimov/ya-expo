import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (show)
import "base" Data.Eq (Eq ((==), (/=)))
import "base" System.IO (print)

type Imbalanced = Shape `LM` Shape `ML` Bracket

pattern Mismatch x = This x :: Imbalanced
pattern Missing x = That x :: Imbalanced

-- remember shape = enter
  -- @(State (List Shape) `JT` Error Imbalanced)
  -- `yuk` push @List shape `hu` State

-- consider shape = enter
  -- @(State `TI` List Shape `JT` Error Imbalanced)
  -- `yi'yuk` pop @List `hu` State
  -- `yi'yok` Error `ha` Missing `ha` Closed `ha` but shape
    -- `yi'rfz` (`e` shape) `hooo` Error `ha` Mismatch `rf` Ok

-- remnants = Empty @List `v` Ok
     -- `rf` Nonempty @List `v` inspect top `ho` Opened `ho` Missing `ho` Error
-- remnants = Ok
  -- `_yi'rfz` unwrap top `ho`this @Shape `ho` Opened `ho` Missing `ho` Error
  -- `haaaaz` this @(List Shape)

-- TODO: our main task here but to accept full ASCII on input
-- handler :: ASCII `ARR` State `TI` List Shape `JT` Error Imbalanced `TI` ASCII
-- handler = intro `ha` Signal
 -- `yi'yi'yi'rf` intro `ha` Symbol `ha` Slashes
   -- `yi'yi'rf` remember `ho'yo` (Symbol `ha` Bracket `ha` Opened)
     -- `yi'rf` consider `ho'yo` (Symbol `ha` Bracket `ha` Closed)
   -- `yi'yi'rf` intro `ha` Symbol `ha` Punctuation
   -- `yi'yi'rf` intro `ha` Symbol `ha` Miscellanneous
 -- `yi'yi'yi'rf` intro `ha` Letter
 -- `yi'yi'yi'rf` intro `ha` Number

-- main = on @List "fn main() { println('hello, world!') }"
 -- `yokl` way @Fore @(State `TI` List Shape `JT` Error Imbalanced)
 -- `haaaaa` match @Symbol `ha'ha` match @Bracket
   -- `yi'yi` remember `ho'yo` (Symbol `ha` Bracket `ha` Opened)
     -- `rf` consider `ho'yo` (Symbol `ha` Bracket `ha` Closed)
   -- `yi'yi` intro `ha` Symbol
   -- `yi'yi` intro @ASCII
 -- `yiiiz'_yi` Empty @List ()
 -- `yi'yokl` remnants
 -- `huuuuuu` (but "[ERROR] Mismatching brackets" `ho` print
   -- `yi'rf` but "[ERROR] Lonely bracket" `ho` print)
   -- `yi'rfz` but "[OKAY] Brackets are balanced" `ho` print

main = print "typechecked"

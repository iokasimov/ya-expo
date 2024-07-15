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

remember shape = enter
  @(State (List Shape) `JT` Error Imbalanced)
  `yukl` push @List shape `u` State

consider shape = enter
  @(State `TI` List Shape `JT` Error Imbalanced)
  `yi_yukl` pop @List `u` State
  `yi_yokl` Error `a` Missing `a` Closed `a` but shape
    `yi_rf'` (`e` shape) `ooo` Error `a` Mismatch `rf` Ok

-- remnants = Empty @List `v` Ok
     -- `rf` Nonempty @List `v` inspect top `o` Opened `o` Missing `o` Error
remnants = Ok
  `yi'_rf'` inspect top `o` Opened `o` Missing `o` Error
  `aaaa'` this @(List Shape)

-- TODO: our main task here but to accept full ASCII on input
-- handler :: ASCII `ARR` State `TI` List Shape `JT` Error Imbalanced `TI` ASCII
-- handler = intro `a` Signal
 -- `yi_yi_yi_rf` intro `a` Symbol `a` Slashes
   -- `yi_yi_rf` remember `o_yo` (Symbol `a` Bracket `a` Opened)
     -- `yi_rf` consider `o_yo` (Symbol `a` Bracket `a` Closed)
   -- `yi_yi_rf` intro `a` Symbol `a` Punctuation
   -- `yi_yi_rf` intro `a` Symbol `a` Miscellanneous
 -- `yi_yi_yi_rf` intro `a` Letter
 -- `yi_yi_yi_rf` intro `a` Number

main = on @List "fn main() { println('hello, world!') }"
 `yoklKL` Fore @(State `TI` List Shape `JT` Error Imbalanced)
 `aaaaa` match @Symbol `a_a` match @Bracket
   `yi_yi` remember `o_yo` (Symbol `a` Bracket `a` Opened)
     `rf` consider `o_yo` (Symbol `a` Bracket `a` Closed)
   `yi_yi` intro `a` Symbol
   `yi_yi` intro @ASCII
 `yiii'_yi'` Empty @List ()
 `yi_yokl` remnants
 `uuuuuu` (but "[ERROR] Mismatching brackets" `o` print
   `yi_rf` but "[ERROR] Lonely bracket" `o` print)
   `yi_rf'` but "[OKAY] Brackets are balanced" `o` print

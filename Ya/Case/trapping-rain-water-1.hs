import Ya

import "base" GHC.Num (Integer, (-), (+))
import "base" Data.Ord (max, min)
import "base" System.IO (print)

trap x l r = min l r - x

peak ward xs = xs
 `yoklKL` ward `a` State
 `aaaaa` modify `a` max
 `yi'_yi'_yi'` 0

totals items = items
 `yoklKL` (trap `j'_j'`) `o` (+)
 `o` modify `o` State `o` Fore
 `yi'_yi'_yi'` 0

levels = as @(Nonempty List)
 (2 `lm` 5 `lm` 1 `lm` 2 `lm` 3 `lm` 4 `lm` 7 `lm` 7 `lm` 6)

main = levels
 `lm_dp` peak Fore levels `u` that @Integer
 `lm_dp` peak Back levels `u` that @Integer
 `uuu` print `aa` totals `o` this @Integer

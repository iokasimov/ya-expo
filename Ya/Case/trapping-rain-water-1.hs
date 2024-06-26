import Ya

import "base" GHC.Num (Integer, (-), (+))
import "base" Data.Ord (max, min)
import "base" System.IO (print)

gap x l r = min l r - x

walls = as (2 `lm` 5 `lm` 1 `lm` 2 `lm` 3 `lm` 4 `lm` 7 `lm` 7 `lm` 6)

main = (walls `u` on @(Nonempty List)
 `yi_lm_dp` (walls `yoklKL` max `o` modify `o` State `o` Fore) `yi'_yi'_yi'_o` 0 `yi` that
 `yi_lm_dp` (walls `yoklKL` max `o` modify `o` State `o` Back) `yi'_yi'_yi'_o` 0 `yi` that
 `yoklKL` (gap `j'_j'`) `o` (+) `o` modify `o` State `o` Fore) `yi'_yi'_yi'_o` 0 `yi` this
 `o` print

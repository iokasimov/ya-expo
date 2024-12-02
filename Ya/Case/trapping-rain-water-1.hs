import Ya
import "ya-expo" Ya.Expo.Instances ()
import "ya-console" Ya.Console

import "base" GHC.Num (Integer, (-), (+))
import "base" Data.Ord (max, min)
import "base" System.IO (print)

totals :: Nonempty List (Integer `LM` Integer `LM` Integer) -> State Integer (Nonempty List Integer)
totals items = items `yokl` (trap `hj'hj`) `ho'ho` auto `ho` Transition `ho` State `ho` Forth

peak xs = xs `yokl` Prior `ha` State `ha` Transition `ha_` max `ho'ho` auto

gap = (trap `hj'hj`)

trap left right origin all = min left right - origin + all

main = is `ho_'yokl` gap `ho'ho` auto `ho` Event `ho` State `ho` Forth `ho_'he'he` (0 `yi`) `ho` this
 `ha___` is `ho_'yokl` max `ho'ho` auto `ho` Event `ho` State `ho` Forth `ho_'he'he` (0 `yi`) `ho` this
 `lo_'yp` is `ho_'yokl` max `ho'ho` auto `ho` Event `ho` State `ho` Prior `ho_'he'he` (0 `yi`) `ho` this
 `lo_'yp` is @(Nonempty List Integer)
 `he___` Construct `ha` Next 2 `ha` Next 5 `ha` Next 1 `ha` Next 2 `ha` Next 3 `ha` Next 4 `ha` Next 7 `ha` Next 7 `he` Last 6
 `yokl_` Forth `ha` print

-- main = peak
 -- `li` Construct `ha` Next 2 `ha` Next 5 `ha` Next 1 `ha` Next 2 `ha` Next 3 `ha` Next 4 `ha` Next 7 `ha` Next 7 `he` Last 6
 -- `he__'he` 0
 -- `yi_` this
 -- `yokl` Forth `ha` print

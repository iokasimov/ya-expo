import Ya
import "ya-console" Ya.Console

import "ya-expo" Ya.Expo.Instances ()

import "base" GHC.Num (Integer, (-), (+))
import "base" Data.Ord (max, min)
import "base" System.IO (print)

gap = (trap `hj'hj`)

trap left right origin all = min left right - origin + all

tap = is `ho'yokl` (gap `ho'ho` auto `ho` Event `ho` State `ho` New `ho` Forth) `ho'he'he'hv` 0 `ho` this
 `ha__` is `ho'yokl` (max `ho'ho` auto `ho` Event `ho` State `ho` New `ho` Forth) `ho'he'he'hv` 0 `ho` this
 `lo'yp` is `ho'yokl` (max `ho'ho` auto `ho` Event `ho` State `ho` New `ho` Prior) `ho'he'he'hv` 0 `ho` this
 `lo'yp` is @(Nonempty List Integer)

main = tap `ha` Nonempty @List
 `ha` Item 2 `ha` Next
 `ha` Item 5 `ha` Next
 `ha` Item 1 `ha` Next
 `ha` Item 2 `ha` Next
 `ha` Item 3 `ha` Next
 `ha` Item 4 `ha` Next
 `ha` Item 7 `ha` Next
 `ha` Item 7 `ha` Next
 `ha` Item 6 `ha` Last `hv` Unit
 `yokl_` Forth `ha` Run `ha` print

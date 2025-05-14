import Ya
import "ya-console" Ya.Console

import "ya-tutorials" Ya.Expo.Instances ()

import "base" GHC.Num (Integer, (-), (+))
import "base" Data.Ord (max, min)
import "base" System.IO (print)

trap left right origin all =
 min left right - origin + all

gap = is `ho'hd'hd` trap

tap = is `ho'yokl` (Forth `ha` New `ha` State `ha` Event `ha_` gap `ho'ho` auto) `ho'he'he'hv` 0 `ho` this
 `ha__` is `ho'yokl` (Forth `ha` New `ha` State `ha` Event `ha_` max `ho'ho` auto) `ho'he'he'hv` 0 `ho` this
 `lo'yp` is `ho'yokl` (Prior `ha` New `ha` State `ha` Event `ha_` max `ho'ho` auto) `ho'he'he'hv` 0 `ho` this `ho` Align
 `lo'yp` Align `ha` is @(Nonempty List Integer)

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

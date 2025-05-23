import Ya
import Ya.World
import Ya.ASCII
import Ya.Literal
import Ya.Console

import "base" GHC.Num (Integer, (-), (+))

type Tile = Unit `S` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Nail = Unit `S` Unit

pattern Bang i = This i
pattern Sunk i = That i

type Shot = Nail `S` Unit

pattern Nail i = This i
pattern Miss i = That i

type Mark = Shot `S` Integer

pattern Shot e = This e
pattern Mist e = That e

type Board = Sliding List

type Ship = Nonempty List Unit

type Personal = Board Tile
type Opponent = Board Mark

fleet = Nonempty @List @Ship
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Next
  `ha` Item Unit `ha` Next
  `ha` Item Unit `ha` Last `hv` Unit
 `ha_` Next
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Next
  `ha` Item Unit `ha` Last `hv` Unit
 `ha_` Last `hv_` Unit

window' ship = ship `yukl` Forth
 `ha` New `ha` State `ha` Event
 `ha` adjust `hv` (by Expand `lu` by Fore)

match = intro @(State Opponent `JNT` Halts) Unit
 `yuk____` State `ho` Old `hv__` Event `hv` pop @List `ha_` Scope `ha` shaft `hv` by Passed
 `yok____` Check `ha` out
 `yuk____` State `ho` Old `hv__` Event `hv` pop @List `ha_` Scope `ha` shaft `hv` by Future
 `yok____` Check `ha` out
 `yuk____` State `ho` Old `hv__` Event `hv` get `ha_` Scope `hv` focus
 `yok____` Check `ha` inner
 `yok____` State `ho` New `ha__` Event `ha` put `ho_'ha` Scope `hv` focus

out = None `hu` by Continue
 `la__` Nail `hu` by Interrupt
   `la` Miss `hu` by Continue
   `la` Mist `hu` by Continue

inner ship = ship
 `yokl` Run `ho` Forth
 `ha__` Bang `ho` Nail `ho` Shot `ho` Valid
   `la` Sunk `ho` Nail `hu` Error Unit
   `la` Miss `ho` Shot `hu` Error Unit
   `la` (+1) `ho` Mist `ho` Valid

mount board = Same `hu` board
 `la` is `ho'he` that @Opponent
 `li` match `he'he'hv` board

chance = intro @(State `T'I` Sliding List Mark) Unit
 `yuk___` State `ho` New `hv____` Event `hv_` auto `ho'ho` mount
 `yuk___` State `ho` New `hv____` Event `ha` shift `hv` by Future
 `yok___` Retry `ha` Perhaps `ha'he` not

distribute fleet = fleet
 `yokl` Forth `ha` Run
 `ha__` intro @(State _) @(AR)
  `ho_'yok` New `ha` window'
  `ho_'yuk` New `hv` chance
  `ho_'yuk` New `ha` State `ha` Event `ha` rewind `hv` by Back

known = Nonempty @List
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Shot `ha` Nail `hv` by Bang) `ha` Next
 `ha` Item (Shot `ha` Nail `hv` by Bang) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Last `hv` Unit

main = print `ha` that `hv_` distribute fleet `he'he'hv` to known where

 print = this `ha'he` at @(Shafted List Mark)
      `ho_` (unwrap @AR `ha` this `ha'he` at @(Reverse List Mark))
      `ho_'yokl` Prior `ha` Run `ha` render
  `lo_'yp` this `ha'he` at @(List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render
      `ho_` Await
  `lo_'yp` this `ha'he` at @(Shafted List Mark)
      `ho_` unwrap @AR `ha` this `ha'he` at @(Forward List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render
      `ho_` Await

 render = Bang `hu` Plus `hv` Unit
  `la__` Sunk `hu` Hash `hv` Unit
  `la__` Miss `hu` Hyphen `hv` Unit
  `ho___` intro @_ @(AR) `ha` Glyph `ha` Symbol `ha` Punctuate
  `la__` integer `ho_'yo` Glyph `ha` Digit
  `ho___'yokl` Forth `ha` Run `ha` output
  `ho___'yuk` World `ha` output `ha` Caret `hv` by Space

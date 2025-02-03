import Ya
import Ya.World
import Ya.ASCII
import Ya.Console

import "base" GHC.Num (Integer, (-), (+))

type Tile = Unit `ML` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Nail = Unit `ML` Unit

pattern Bang i = This i
pattern Sunk i = That i

type Shot = Nail `ML` Unit

pattern Nail i = This i
pattern Miss i = That i

type Mark = Shot `ML` Integer

pattern Shot e = This e
pattern Mist e = That e

type Board = Nonempty List

type Personal = Board Tile
type Opponent = Board Shot

type Ship = Nonempty List Unit

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

window ship = ship `yukl` Forth
 `ha` New `ha` State `ha` Event
 `ha` extend @List `hv` by Fore

match ship = ship
 `yokl` Run `ho` Forth
 `ha__` Bang `ho` Nail `ho` Shot `ho` Valid
   `la` Sunk `ho` Nail `ho` Shot `ho` Error
   `la` Miss `ho` Shot `ho` Error
   `la` (+1) `ho` Mist `ho` Valid

mount ship = Same `hu` ship `la` is `li` match ship

chance = enter @(State `WR` Sliding List Mark)
 `yuk___` State `ho` New `hv__` Event `hv_` mount `ho` auto `ha_'he` Scope `hv` at @(List Mark)
 `yuk___` State `ho` New `hv__` Event `hv_` slide `hv` by Future
 `yok___` Retry `ha` Perhaps `ha` not

rewind = State `ha` Event `hv_` auto `ho'ho` to @(Sliding List) `ha` to @List

distribute fleet = fleet
 `yokl` Forth `ha` Run
 `ha__` intro @(State _)
  `ho_'yok` New `ha` window
  `ho_'yuk` New `hv` chance
  `ho_'yuk` New `hv` rewind

known = Nonempty @List
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Next
 `ha` Item (Mist 0) `ha` Last `hv` Unit

main = print `ha` that `hv_` distribute fleet `he'he'hv` to known where

 print = this `ha'he` at @(Shafted List Mark)
      `ho_` (unwrap @AR `ha` this `ha'he` at @(Reverse List Mark))
      `ho_'yokl` Prior `ha` Run `ha` render
  `lo_'yp` this `ha'he` at @(List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render
  `lo_'yp` this `ha'he` at @(Shafted List Mark)
      `ho_` unwrap @AR `ha` this `ha'he` at @(Forward List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render

 render = Bang `hu` Plus `hv` Unit
  `la__` Sunk `hu` Hash `hv` Unit
  `la__` Miss `hu` Hyphen `hv` Unit
  `ho___` intro `ha` Glyph `ha` Symbol `ha` Punctuate
  `la__` integer `ho_'yo` Glyph `ha` Digit
  `ho___'yokl` Forth `ha` Run `ha` output
  `ho___'yuk` World `ha` output `ha` Caret `hv` by Space

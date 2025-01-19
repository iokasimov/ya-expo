import Ya
import Ya.World
import Ya.ASCII
import Ya.Console

import "base" GHC.Num (Integer, (-), (+))

type Tile = Unit `ML` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Shot = Unit `ML` Unit `ML` Unit

pattern Miss i = This (This i)
pattern Bang i = This (That i)
pattern Sunk i = That i

type Ship = Nonempty List Unit

type Mark = Shot `ML` Integer

pattern Shot e = This e
pattern Mist e = That e

fleet = Nonempty @List @Ship
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Maybe `ha` Next
  `ha` Item Unit `ha` Maybe `ha` Next
  `ha` Item Unit `ha` Maybe `hv` Last
 `ha_` Maybe `ha_` Next
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Maybe `ha` Next
  `ha` Item Unit `ha` Maybe `hv` Last
 `ha_` Maybe `hv_` Last

window ship = ship `yukl` Forth
 `ha` New `ha` State `ha` Event
 `ha` extend @List `hv` by Fore

match ship = Interrupt `hu_` auto `hv` ship `la` auto `li` check `hv` ship

check tile = tile
 `yokl` Run `ho` Forth
 `ha__` Miss `ho` Shot `ho` Error
   `la` Bang `ho` Shot `ho` Valid
   `la` Sunk `ho` Shot `ho` Error
   `la` (+1) `ho` Mist `ho` Valid

chance = enter @(State `WR` Sliding List Mark)
 `yuk___` State `ho` New `hv__` Event `hv` match `ha_'he` Scope `hv` at @(List Mark)
 `yuk___` State `ho` New `hv__` Event `ha` slide `hv` by Future
 `yok___` Retry `ha` Perhaps `ha` not

rewind = State `ha` Event `hv_` auto `ho'ho` to @(Sliding List) `ha` to @List

distribute fleet = fleet
 `yokl` Forth `ha` Run
 `ha__` intro @(State _)
  `ho_'yok` New `ha` window
  `ho_'yuk` New `hv` chance
  `ho_'yuk` New `hv` rewind

known = Nonempty @List
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `ha` Next
 `ha` Item (Mist 0) `ha` Maybe `hv` Last

main = print `ha` that `hv_` distribute fleet `he'he'hv` to known where

 print = this `ha'he` at @(Shafted List Mark)
      `ho_` (unwrap @AR `ha` this `ha'he` at @(Reverse List Mark))
      `ho_'yokl` Prior `ha` Run `ha` render
  `lo_'yp` this `ha'he` at @(List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render
  `lo_'yp` this `ha'he` at @(Shafted List Mark)
      `ho_` unwrap @AR `ha` this `ha'he` at @(Forward List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render

 render = Miss `hu` Hyphen `hv` Unit
  `la__` Bang `hu` Plus `hv` Unit
  `la__` Sunk `hu` Hash `hv` Unit
  `ho___` intro `ha` Glyph `ha` Symbol `ha` Punctuate
  `la__` integer
  `ho___'yokl` Forth `ha` Run `ha` output
  `ho___'yuk` World `ha` output `ha` Caret `hv` by Space

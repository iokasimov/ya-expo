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

type Board = Sliding List

type Ship = Nonempty List Unit
 
type Personal = Board Tile
type Opponent = Board Mark

submarine = Nonempty @List
 `ha` Item Unit `ha` Maybe `ha` Next
 `ha` Item Unit `ha` Maybe `ha` Next
 `ha` Item Unit `ha` Maybe `hv` Last

destroyer = Nonempty @List
 `ha` Item Unit `ha` Maybe `ha` Next
 `ha` Item Unit `ha` Maybe `hv` Last

fleet = Nonempty @List @Ship
 `ha_` Item `hv` submarine `ha_` Maybe `ha_` Next
 `ha_` Item `hv` destroyer `ha_` Maybe `hv_` Last

window ship = ship `yukl` Forth
 `ha` New `ha` State `ha` Event
 `ha` extend @List `hv` by Fore

match = enter @(State Opponent `JNT` Halts)
 `yuk____` State `ho` Old
 `hv_____` Event `hv` pop @List
 `ha___'he` Scope `hv` at @(Shafted List Mark)
   `ho_'he` Scope `hv` at @(Reverse List Mark)
   `ho_'he` Scope `hv` it @(List Mark)
 `yok____` Check `ha` out
 `yuk____` State `ho` Old
 `hv_____` Event `hv` pop @List
 `ha___'he` Scope `hv` at @(Shafted List Mark)
   `ho_'he` Scope `hv` at @(Forward List Mark)
   `ho_'he` Scope `hv` it @(List Mark)
 `yok____` Check `ha` out
 `yuk____` State `ho` Old
 `hv_____` Event `hv` auto
 `ha___'he` Scope `hv` at @(List Mark)
 `yok____` Check `ha` inner
 `yok____` State `ho` New
 `ha_____` Event `ha` switch
 `ho_'ha'he` Scope `hv` at @(List Mark)

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

chance = enter @(State `WR` Sliding List Mark)
 `yuk___` State `ho` New `hv____` Event `hv_` auto `ho'ho` mount
 `yuk___` State `ho` New `hv____` Event `ha` slide `hv` by Future
 `yok___` Retry `ha` Perhaps `ha` not

rewind = State `ha` Event `hv_` auto `ho'ho` to @(Sliding List) `ha` to @List

distribute fleet = fleet
 `yokl` Forth `ha` Run
 `ha__` intro @(State _)
  `ho_'yok` New `ha` window
  `ho_'yuk` New `hv` chance
  `ho_'yuk` New `hv` rewind

enemy = Nonempty @List
 `ha` Item Idle `ha` Maybe `ha` Next
 `ha` Item Ship `ha` Maybe `ha` Next
 `ha` Item Ship `ha` Maybe `ha` Next
 `ha` Item Ship `ha` Maybe `ha` Next
 `ha` Item Idle `ha` Maybe `ha` Next
 `ha` Item Ship `ha` Maybe `ha` Next
 `ha` Item Ship `ha` Maybe `ha` Next
 `ha` Item Idle `ha` Maybe `ha` Next
 `ha` Item Idle `ha` Maybe `ha` Next
 `ha` Item Idle `ha` Maybe `hv` Last

known = enemy `yu` Mist 0

type Cell = Tile `LM` Mark

guess = that `hv_` distribute fleet `he'he'hv` to known

main = to @List enemy `lu'yp` to @List guess
 `yokl` Forth `ha` World `ha` render where

 mark = intro `ha` Glyph `ha` Symbol `ha` Punctuate
  `ha__` Bang `hu` by Plus `la` Sunk `hu` by Hash `la` Miss `hu` by Hyphen
  `la__` integer `ho_'yo` Glyph `ha` Digit

 tile = Glyph `ha` Symbol `ha` Punctuate
  `ha___` by Hyphen `lv` by Plus

 cell (These him me) = enter @(State _)
  `yuk_` New `ha` State `ha` Event `ha` push
    `ha` Glyph `ha` Symbol `ha` Punctuate `hv` by Bar
  `yuk_` New `ha` State `ha` Event `ha` push `hv` tile him
  `he'he'hv___` mark me

 render info = that `hv` cell info
  `yokl` Forth `ha` World `ha` output
  `yuk_` World `ha` output `ha` Caret `hv` by Space
  `yuk_` World `ha` output `ha` Caret `hv` by Space

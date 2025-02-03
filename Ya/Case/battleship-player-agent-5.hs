import Ya
import Ya.World
import Ya.ASCII
import Ya.Console

import "base" GHC.Num (Integer, (-), (+))

type Tile = Unit `ML` Unit

pattern Idle e = This e
pattern Ship e = That e

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
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Maybe `hv` Last

destroyer = Nonempty @List
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Maybe `hv` Last

fleet = Nonempty @List @Ship
 `ha_` Item `hv` submarine `ha_` Next
 `ha_` Item `hv` destroyer `ha_` Maybe `hv_` Last

type Cell = Tile `LM` Mark

type Fleet = Nonempty List Ship

type Target = Maybe Ship

shoot' = by Miss `lv` Nail `hv` by Bang `ho_` Shot `ha__` this @Tile

type Playing = State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result

-- + None: If there is `Some Ship` - we need to remove it from `Fleet`, stop

-- + Some: If there is `Ship` tile
 -- , if there is `None Ship` - start collecting a new ship
 -- , if there is `Some Ship` - add a current tile to this

-- . Some: If there is `Idle` tile
 -- , if there is `None Ship` - do nothing
 -- , if there is `Some Ship` - we need to remove it from `Fleet`

hunt = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk__` State `ho` New `hv__` Event `ha` extend @List `hv` by Fore `ha_` Scope `hv` at @(Board Cell)
 `yok__` Run `ha__` None `hu` sink `ho'yu` (Interrupt `hv` by Smash) `la` intro `ha` Continue @Cell
 `yok__` Check @Result `ha'yo` this @Tile
 `yok__` Run `ha__` None `hu` sink `la` Some `hu` bomb

type Result = Ship `ML` Unit

pattern Fault e = This e
pattern Smash e = That e

sink = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk__` Old `ha` State `hv__` Event `hv` auto `ha_` Scope `hv` at @Target
 `yok__` Try `ha` is @(Reach Result Ship) `ha__` Interrupt `ha` Smash `la` Valid
 `yok__` Old `ha` State `ha__` Event `ha` defeat `ho_'ha` Scope `hv` at @Fleet
 `yok__` Try `ha` is @(Reach Result Fleet)
 `yok__` New `ha` State `ha__` Event `ha` switch `ho_'ha` Scope `hv` at @Fleet

defeat ship fleet = Interrupt `ha` Smash `la` Continue @Fleet
  `la` is `ho'he` this @Ship `ho` Fault `ho` Interrupt
  `li` wreck ship `he'he'hv`  to @(Scrolling List) fleet
  `lu` fleet

wreck ship = enter @(State `WR` Scrolling List Ship `JNT` Reach `WR` List Ship)
 `yuk____` New `ha` State `hv___` Event `hv__` auto `ho'yoi` (`hd'q` Same ship) `ha__'he` Scope `hv` at @(Focused Ship)
 `yok____` New `ha` State `hv___` Event `hv__` scroll `hv` by Fore `ho'yoi` Continue
  `lv____` New `ha` State `hv___` Event `hv__` auto `ho_'yoi` Reach `ha` to @List `ha__'he` Scope `hv` at @(Shafted List Ship)
 -- TODO: can we replace it with `Retry`?
 `yok____` Try `ha` is @(Progress `WR` List Ship `WR` _)
 `yuk____` Again `hv` Once ship

bomb = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk___` State `ho` New `hv___` Event `hv_` hit `ha_` Scope `hv` at @Target
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `hv` at @Fleet

hit = auto `ha` Some
 `ha__` None @Ship `hu` enter
   `la` push `hv` Unit `ho` that

window ship = ship `yukl` Forth
 `ha` New `ha` State `ha` Event
 `ha` extend @List `hv` by Fore

match = enter @(State Opponent `JNT` Reach Unit)
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
 `yuk___` State `ho` New `hv__` Event `hv_` auto `ho'ho` mount
 `yuk___` State `ho` New `hv__` Event `ha` slide `hv` by Fore
 `yok___` Retry `ha` Perhaps `ha` not

rewind = State `ha` Event `hv_` auto `ho'ho` to @(Sliding List) `ha` to @List

distribute fleet = fleet
 `yokl` Forth `ha` Run
 `ha__` intro @(State _)
  `ho_'yok` New `ha` window
  `ho_'yuk` New `hv` chance
  `ho_'yuk` New `hv` rewind

-- TODO: modify `Next`/`Last` patterns
enemy = Nonempty @List
 `ha` Item (by Idle) `ha` Next
 `ha` Item (by Ship) `ha` Next
 `ha` Item (by Ship) `ha` Next
 `ha` Item (by Ship) `ha` Next
 `ha` Item (by Idle) `ha` Next
 `ha` Item (by Ship) `ha` Next
 `ha` Item (by Ship) `ha` Next
 `ha` Item (by Idle) `ha` Next
 `ha` Item (by Idle) `ha` Next
 `ha` Item (by Idle) `ha` Maybe `hv` Last

known = enemy `yu` Mist 0

guess = that `hv_` distribute fleet `he'he'hv` to known

shoot (These x _) = x `lu_` by Miss `lv` Nail `hv` by Bang `ho_` Shot `li` x

fresh = to @List `hv` enemy
 `lu'yp` to @List `hv` guess
 `yi` to @(Sliding List)

main = hunt `he'he'hv__` by `hv` None @Ship `lu` fleet `lu` fresh
 `yi__` "Ship has not been found!" `lv` "You won!"
  `ho_'yokl` Forth `ha` Run `ha` output
  `la_` is @(Equipped _ _) `ho'he` that `ho` that @(Board Cell) `ho` to @List
  `ho_'yokl` Forth `ha` Run `ha` render where

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


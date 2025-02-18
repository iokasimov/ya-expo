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
 `ha` Item Unit `ha` Last `hv` Unit

destroyer = Nonempty @List
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Last `hv` Unit

boat = Nonempty @List
 `ha` Item Unit `ha` Last `hv` Unit

fleet = Nonempty @List @Ship
 `ha_` Item `hv` submarine `ha_` Next
 `ha_` Item `hv` destroyer `ha_` Last `hv_` Unit

type Cell = Tile `LM` Mark

type Fleet = Nonempty List Ship

type Target = Maybe Ship

shoot' = by Miss `lv` Nail `hv` by Bang `ho_` Shot `ha__` this @Tile

type Playing = State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result

-- + None: If there is `Some Ship` - we need to remove it from `Fleet`, stop

-- . Some: If there is `Idle` tile
 -- , if there is `None Ship` - do nothing
 -- , if there is `Some Ship` - we need to remove it from `Fleet`

-- + Some: If there is `Ship` tile
 -- , if there is `None Ship` - start collecting a new ship
 -- , if there is `Some Ship` - add a current tile to this

type Result = Unit `ML` Unit `ML` Ship

pattern Verge e = This (This e)
pattern Smash e = This (That e)
pattern Fault e = That e

process = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk__` New `ha` State `hv__` Event `ha` extend @List `hv` by Fore `ha_` Scope `hv` at @(Board Cell)
 `yok__` Try `ha__` Interrupt @Result `ha` Verge `la` Continue `ha` this @Tile
 `yok__` Run `ha__` Idle `hu` review `la` Ship `hu` pursuit

-- It there is `Ship`
pursuit = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk___` State `ho` New `hv___` Event `hv_` hit `ha_` Scope `hv` at @Target
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `hv` at @Fleet

hit = auto `ha` Some `ha__` None @Ship `hu` enter `la` push `hv` Unit `ho` that

-- If there is `Idle` tile
review = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk___` Old `ha` State `hv__` Event `hv` auto `ha_` Scope `hv` at @Target
 `yok___` Run `ha__` None `hu_`intro `ha` is @Fleet `ha` intro @(Nonempty List) `ha` intro @(Nonempty List) `hv` Unit  `la` unstock

-- 1. Try to find the same ship
-- 2. If ship is found - remove from `Fleet`
-- 3. If ship isn't found - `Interrupt` with an `Fault`
-- 4. If after removing ship fleet is empty - terminate with `Smash`
-- 5. If fleet is not empty - update `Fleet` and continue
unstock ship = enter @(State `WR_` Target `LM` Fleet `LM` Board Cell `JNT_` Reach Result)
 `yuk__` New `ha__` State `hv__` Event `ha` locate `ha` Predicate `ha` exact `hv` ship `ha_` Scope `hv` at @Fleet `ho` as @(Scrolling List)
 `yok__` Try `ha__` Error `hu_` Reach @Result `ha` Fault `hv` ship `la` Ok
 `yok__` Try `ha__` Empty @List `hu_` Reach @Result `hv` by Smash `la` Ok `ha__` at @(Shafted List Ship) `he'ho` this `ho` to @List
 `yok__` New `ha__` State `ha__` Event `ha` switch `ho_'ha` Scope `hv` at @Fleet

-- Update | Review?

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
 `ha` Item (by Idle) `ha` Last

known = by enemy `yu` Mist 0

guess = that @(Board Mark) `hv_` distribute fleet `he'he'hv` to known

shoot (These x _) = x `lu_` by Miss `lv` Nail `hv` by Bang `ho_` Shot `li` x

fresh = to @List `hv` by enemy
 `lu'yp` to @List `hv` guess
 `yi` to @(Sliding List)

-- win fleet = enter @World
 -- `yuk__` World `hv_` (is @(List ASCII) `hv` "You won, you defeated all ships!" `yokl` Forth `ha` Run `ha` output)
 -- `yuk__` World `hv_` (fleet `yokl'yokl` Forth `ha` Forth `ha` Run `ha` output `ha` (is `hu_`by (Glyph `ha` Symbol `ha` Punctuate `ha` Dollar)))
 -- `yuk__` World `hv` enter @World

title x = is @(List ASCII) x `yokl` Forth `ha` World `ha` output

print x = x `yokl_` Forth `ha` World `ha___` is @Ship
 `ho__'yukl` Forth `ha` World `ha` output `ha` Glyph `ha` Symbol `ha` Punctuate `hv` by Hash
 `ho__'yuk` World `ha` output `ha` Caret `hv` by Space

exact sample item = is
 `li` Wrong `hu` by False
 `la` Valid `hu` by True
 `li` sample `hd'q` item

main = this `ha_` locate `ha` Predicate `ha` exact `hv` destroyer `ha_` to @(Scrolling List) `hv_` fleet
 `yi_____` Error `hu__` title `hv` "The ship hasn't been found!" `yu` Unit
  -- `la____` to @(Nonempty List) @_ @Ship `ho_'yokl'yukl` Forth `ha` Forth `ha` Run `ha` output `ha` Glyph `ha` Symbol `ha` Punctuate `ha` Dollar `hv` Unit `ho_'yu` Unit
  `la____` is `ho'he` at @(Shafted List Ship) `ho` this `ho` to @List `ho` print `ho'yu` Unit
  -- `la____` is `ho`  to @(Nonempty List) `ho` print `ho'yu` Unit

 -- `yi_____` is @(List Ship) `ho_'yokl'yukl` Forth `ha` Forth `ha` Run `ha` output `ha` Glyph `ha` Symbol `ha` Punctuate `ha` Dollar `hv` Unit `ho_'yu` Unit
  -- `la____` Error `hu____` is @(List ASCII) `hv` "The ship hasn't been found!" `yokl` Forth `ha` Run `ha` output `yu__` Unit

{-
main = hunt `he'he'hv__` by `hv` None @Ship `lu` fleet `lu` fresh
 `yi__` Fault `hu` ((is @(List ASCII) `hv` "One ship has not been found..." `yokl` Forth `ha` Run `ha` output) `yu` Unit)
   `la` win
  `la_` is @(Equipped _ _) `ho'he` that `ho` that @(Board Cell) `ho` to @List
  -- `la_` is @(Equipped _ _) `ho'he` that `ho` this `ho` that @Fleet
  -- `ho_'yokl'yokl` Forth `ha` Forth `ha` Run
   -- `ha` (is `hu_`output `hv` by (Glyph `ha` Symbol `ha` Punctuate `ha` Dollar))
  -- `ho_'yu` Unit where
  `ho_'yokl` Forth `ha` Run `ha` render `ho_'yu` Unit where

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
-}

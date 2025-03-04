import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import "ya-expo" Ya.Expo.Instances

import "base" GHC.Num (Integer, (-), (+))
-- import "base" System.IO (print)

type Tile = Unit `S` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Ship = Nonempty List Unit

type Fleet = Nonempty List Ship

fleet = Nonempty @List @Ship
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Next
  `ha` Item Unit `ha` Next
  `ha` Item Unit `ha` Maybe `hv` Last
 `ha_` Maybe `ha_` Next
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Next
  `ha` Item Unit `ha` Maybe `hv` Last
 `ha_` Maybe `hv_` Last

enemy = Nonempty @List
 `ha` Item Idle `ha` Next
 `ha` Item Ship `ha` Next
 `ha` Item Ship `ha` Next
 `ha` Item Ship `ha` Next
 `ha` Item Idle `ha` Next
 `ha` Item Ship `ha` Next
 `ha` Item Ship `ha` Next
 `ha` Item Idle `ha` Next
 `ha` Item Idle `ha` Next
 `ha` Item Idle `ha` Maybe `hv` Last

type Shot = Unit `S` Unit `S` Unit

pattern Miss i = This (This i)
pattern Bang i = This (That i)
pattern Sunk i = That i

type Mark = Shot `S` Integer

pattern Shot e = This e :: Mark
pattern Mist e = That e :: Mark

type Board = Nonempty List `WR_` Mark `P` Tile

sunk x = enter @(State `WR` Scrolling List Ship `JNT` Progress `WR` Shafted List Ship)
 `yuk____` New `ha` State `hv__` Event `hv_` auto `ho'yoi` (`hd'q` Same x) `ha_'he` Scope `hv` at @(Focused Ship)
 `yok____` New `ha` State `hv__` Event `hv_` scroll `hv` by Next `ho'yoi` Continue
  `lv____` New `ha` State `hv__` Event `hv_` auto `ho'yoi` Interrupt `ha_'he` Scope `hv` at @(Shafted List Ship)
 -- TODO: can we replace it with `Retry`?
 `yok____` Try `ha` is @(Progress `WR` Shafted List Ship `WR` _)
 `yok____` Again `ha` Once

known = enemy `yu` Mist 0

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

main = print `ha` that `hv_` distribute fleet `he'he'hv` to known

-- TODO: replace this expression with a `Mapping` instance
print = this `ha'he` at @(Shafted List Mark)
      `ho_` (unwrap @AR `ha` this `ha'he` at @(Reverse List Mark))
      `ho_'yokl` Prior `ha` Run `ha` render
 -- `lo_'yp` is `hu_` output `ha` Glyph `ha` Symbol `ha` Bracket `hv` Opened Square
 `lo_'yp` this `ha'he` at @(List Mark)
      `ho_'yokl` Forth `ha` Run `ha` render
 -- `lo_'yp` is `hu_` output `ha` Glyph `ha` Symbol `ha` Bracket `hv` Closed Square
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

-- title x = output `ha` Caret `hv` Newline
 -- `yuk_____` World `hv_____` is @(List ASCII) x
    -- `yokl_` Forth `ha` Run `ha` output

-- main = fleet
 -- `yokl_` is -- intro @(State `WR` Sliding List Mark `JNT` World)
 -- `ho__'yukl` Forth `ha` New `ha` State `ha` Event `ha` extend @List `hv` it Fore
  -- `ho__'yok` New `ha` extent
  -- `ho__'yuk` (State `ho` New `hv__` Event `hv` fits `ha_'he` Scope `hv` at @(List Mark))
  -- `ho__'yuk` Run `ha` title `hv` "Probs: "
  -- `ho__'yuk` Run `hv` frame
  -- `ho__'yuk` New `hv` rewind
  -- `ho__'yuk` Run `ha` title `hv` "Reset: "
  -- `ho__'yuk` Run `hv` frame
 -- `ho__` Forth `ha` Run
 -- `he'he'hv_____` to @(Sliding List) `hv` known where

 -- `yuk_____` World (is @(List _) "Enemy: " `yokl` Forth `ha` Run `ha` output)
 -- `yuk_____` World (enemy `yokl_` Forth `ha` Run -- `ha` output
   -- `ha___` (output `ha` Glyph `ha` Symbol `ha` Punctuate `ha__` Hyphen `la` Hash
    -- `ho__'yuk` Run `ha` output `ha` Caret `hv` Space))
 -- `yuk_____` World (output `ha` Caret `hv` Newline)
 -- `yuk_____` World (is @(List _) "Known: " `yokl` Forth `ha` Run `ha` output)
 -- `yuk_____` World (known `yokl` Forth `ha` Run `ha` render)
 -- `yuk_____` World (output `ha` Caret `hv` Newline)
 
 -- `ho___'yuk` New `hv` probs
 -- `ho___'yuk` Run `ha` title `hv` "Gauge: "
 -- `ho___'yuk` Run `hv` frame
 -- `ho___'yuk` New `ha` State `ha` Event `ha` slide `hv` it Fore
 -- `ho___'yok` enter `lv` Again `ha` Once `hv` Unit

 -- `ho___'yuk` New `ha` State `ha` Event `ha` slide `hv` it Fore
 -- `ho___'yok` World `hv` print "The end!" `lv` World `hv` print "Continue..."
 -- `ho___'yuk` Run `ha` title `hv` "Slide: "
 -- `ho___'yuk` Run `hv` frame

-- I spend the whole day on a relatively simple question: how to implement `remove` function
-- without left it tied to exact specified meaning?
-- * Should I remove all occurencies of a copy of the same item?
-- * Should I stop after removing first occurrencies?
-- * What if I would like to apply some another predicate on filtering out an element instead of total equivalence relation?

-- main = print known

-- main = print `ha` this `ha`at @(List Mark) `ha` unwrap @AR `ha`that `ha` extend (Fore Unit) `ha` to @(Sliding List) `hv` known

-- main = enemy `yokl` Forth `ha` Run `ha` print `ha_` These `he` Capacity 0

-- main = enemy `yokl__` Forth `ha` Run
 -- `ha___` output `ha` Glyph `ha` Symbol `ha` Punctuate `ha__` Hyphen `la` Hash
  -- `ho__'yuk` Run `ha` output `ha` Caret `hv` Space

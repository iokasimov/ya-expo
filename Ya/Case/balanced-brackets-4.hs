import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Mismatch = Shape `LM` Shape

type Missing = Shape `ML` Shape

type Imbalance = Mismatch `ML` Missing

pattern Mismatch x = This x :: Imbalance
pattern Missing x = That x :: Imbalance

deposit bracket = enter @(State `WR` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `hv` push @List bracket

analyze bracket = enter @(State `WR` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `hv` pop @List
 `yok__` Try `ha__` None `hu_` Error `ha` Missing `ha` Opened `hv` bracket `la` Valid
 `yok__` Try `ha__` Error `ha` Mismatch `la` Valid `ha_` compare bracket

compare closed opened = opened `hd'q` closed

remnant = Empty @List `hu` by Valid
  `la` Error `ha` Missing `ha` Closed `ha` this @Shape `ha` top @(Nonempty List)

main = is @(Nonempty List ASCII)
 `hv__` "fn main() { println('hello, <world>!') ]"
 `yokl` Forth `ha` Run @(State `WR` List Shape `JNT` Error Imbalance)
 `ha__` is `hu` enter `la` (deposit `la` analyze) `ho'yu` Unit
 `ha__` on @Glyph `ho'ho` on @Symbol `ho` row `ho'ho` on @Bracket `ho` row
 `he'he'hv___`by `hv` Empty @List
 `yok_` Try `ha` remnant `ha'he` that @(List Shape)
 `yi__` that @(List ASCII) `ha__` mismatch `la` missing `la` balance
 `yokl` Forth `ha` Run `ha` output where

 mismatch (These opened closed) =
  "[ERROR] Mismatched bracket shapes - "
  `yokl` Prior `ha` New `ha` State `ha` Event `ha` push `he'he'hv___` List
  `ha__` Item `ha` Glyph `ha` Symbol `ha` Bracket `ha` Opened `hv` opened `ha` Next
  `ha__` Item `ha` Caret `hv` by Space `ha` Next
  `hv__` Item `ha` Glyph `ha` Symbol `ha` Bracket `ha` Closed `hv` closed `ha` Maybe `hv` Last

 missing bracket =
  "[ERROR] Missing bracket - "
  `yokl` Prior `ha` New `ha` State `ha` Event `ha` push
  `he'he'hv___` intro @List `ha` Glyph `ha`Symbol `ha` Bracket `hv` bracket

 balance _ = by `hv` Empty @List
  `lu` "[VALID] Everything is seem to be good!"

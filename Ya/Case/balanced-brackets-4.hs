import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Mismatch = Shape `P` Shape

type Missing = Shape `S` Shape

type Imbalance = Mismatch `S` Missing

pattern Mismatch x = This x
pattern Missing x = That x

deposit bracket = enter @(State `WR` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `hv` push @List bracket

analyze bracket = enter @(State `WR` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `hv` pop @List
 `yok__` Try @Imbalance `ha__` None `hu_` Error `ha` Missing `ha` Opened `hv` bracket `la` Valid
 `yok__` Try @Imbalance `ha__` Error `ha` Mismatch `la` Valid `ha_` compare bracket

compare closed opened = opened `hd'q` closed

remnant = Empty @List `hu` by Valid
  `la` Error @Imbalance `ha` Missing `ha` Closed `ha` this @Shape `ha` top @(Nonempty List)

inspect code = code
 `yokl_` Forth `ha` Run @(State `WR` List Shape `JNT` Error Imbalance)
 `ha___` Some `hu` enter `la_` is @Bracket `ho_` (deposit `la` analyze) `ho'yu` Unit
 `ha___` on @Glyph `ho'ho` on @Symbol `ho` row `ho'ho` on @Bracket `ho` row
 `he'he'hv____`by `hv` Empty @List
 `yok__` Try @Imbalance `ha` remnant `ha'he` that @(List Shape)

main = that @(List ASCII) `ha__` mismatch `la` missing `la` balance
 `li___` inspect `ha` is @(Nonempty List ASCII) `hv` "fn main() { println('hello, <world>!') }"
 `yokl_` Forth `ha` Run `ha` output where

 mismatch (These opened closed) =
  "[ERROR] Mismatched bracket shapes - "
  `yokl` Prior `ha` New `ha` State `ha` Event `ha` push `he'he'hv___` List
  `ha__` Item `ha` Glyph `ha` Symbol `ha` Bracket `ha` Opened `hv` opened `ha` Next
  `ha__` Item `ha` Caret `hv` by Space `ha` Next
  `hv__` Item `ha` Glyph `ha` Symbol `ha` Bracket `ha` Closed `hv` closed `ha` Last `hv` Unit

 missing bracket =
  "[ERROR] Missing bracket - "
  `yokl` Prior `ha` New `ha` State `ha` Event `ha` push
  `he'he'hv___` intro @List `ha` Glyph `ha`Symbol `ha` Bracket `hv` bracket

 balance _ = by `hv` Empty @List
  `lu` "[VALID] Everything is seem to be good!"

import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console
import "ya-expo" Ya.Expo.Instances

import "base" System.IO (print)

type Mismatch = Shape `LM` Shape

type Missing = Shape `ML` Shape

type Imbalance = Mismatch `ML` Missing

pattern Mismatch x = This x :: Imbalance
pattern Missing x = That x :: Imbalance

deposit bracket = enter @(State `WR` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `he` push @List bracket

analyze bracket = enter @(State `WR` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `he` pop @List
 `yok__` Try `ha__` None `hu_` Error `ha` Missing `ha` Opened `he` bracket `la` Valid
 `yok__` Try `ha__` Error `ha` Mismatch `la` Valid `ha_` compare bracket

compare closed opened = opened `hd'q` closed

remnant = Valid `hv` Empty @List
  `la` Error `ha` Missing `ha` Closed `ha` this @Shape `ha` top @(Nonempty List)

main = is @(Nonempty List ASCII)
 `he__` "fn main() { println('hello, <world>!') ]"
 `yokl` Forth `ha` Run @(State `WR` List Shape `JNT` Error Imbalance)
 `ha__` is `hu` enter `la` (deposit `la` analyze) `ho'yu` Unit
 `ha__` on @Glyph `ho'ho` on @Symbol `ho` row `ho'ho` on @Bracket `ho` row
 `he___'he` Empty @List Unit
 `yok_` Try `ha` remnant `ha'he` that @(List Shape)
 `yi__` that @(List ASCII) `ha__` mismatch `la` missing `la` balance
 `yokl` Forth `ha` Run `ha` output where

 mismatch (These opened closed) =
  "[ERROR] Mismatched bracket shapes - "
  `yokl` Prior `ha` New `ha` State `ha` Event `ha` push `he___'he` List
  `ha__` Next `ha` Glyph `ha` Symbol `ha` Bracket `ha` Opened `he` opened
  `ha__` Next `ha` Caret `he` Space
  `he__` Last `ha` Glyph `ha` Symbol `ha` Bracket `ha` Closed `he` closed

 missing bracket =
  "[ERROR] Missing bracket - "
  `yokl` Prior `ha` New `ha` State `ha` Event `ha` push
  `he___'he` intro @_ @List `ha` Glyph `ha`Symbol `ha` Bracket `he` bracket

 balance _ = Empty @List Unit
  `lu` "[VALID] Everything is seem to be good!"

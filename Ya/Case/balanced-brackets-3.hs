import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console
import "ya-expo" Ya.Expo.Instances

type Imbalance = (Shape `LM` Shape) `ML` (Shape `ML` Shape)

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
 `he__` "fn main() { println('hello, <world>!') }"
 `yokl` Forth `ha` Run @(State `WR` List Shape `JNT` Error Imbalance)
 `ha__` is `hu` enter `la` (deposit `la` analyze) `ho'yu` Unit
 `ha__` on @Glyph `ho'ho` on @Symbol `ho` row `ho'ho` on @Bracket `ho` row
 `he___'he` Empty @List Unit
 `yok_` Try `ha` remnant `ha'he` that @(List Shape)
 `yi__` is @(List ASCII)
 `ha__` is `hu` "[ERROR] Missing or mismatching bracket!"
   `la` is `hu` "[VALID] Everything is seem to be good!"
 `yokl` Forth `ha` Run `ha` output

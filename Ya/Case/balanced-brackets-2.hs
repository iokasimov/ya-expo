import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Imbalance = (Shape `P` Shape) `S_` (Shape `S` Shape)

pattern Mismatch x = This x
pattern Missing x = That x

deposit bracket = enter @(State `T'I` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `hv` push @List bracket

analyze bracket = enter @(State `T'I` List Shape `JNT` Error Imbalance)
 `yuk__` New `ha` State `ha` Event `hv` pop @List
 `yok__` Try `ha__` None `hu_` Error @Imbalance `ha` Missing `ha` Opened `hv` bracket `la` Valid
 `yok__` Try `ha__` Error @Imbalance `ha` Mismatch `la` Valid `ha_` compare bracket

compare closed opened = opened `hd'q` closed

remnant = Empty @List `hu` by Valid
  `la` Error @Imbalance `ha` Missing `ha` Closed `ha` this @Shape `ha` top @(Nonempty List)

example = Nonempty @List
 `ha` Item (Opened Round) `ha` Next
 `ha` Item (Closed Angle) `ha` Last

main = by example
 `yokl` Forth `ha` Run `ha__` deposit `la` analyze `he'he'hv___` by `hv` Empty @List
 `yok_` Check `ha` remnant `ha'he` that @(List Shape)
 `yi__` Error `hu` "[ERROR] Missing or mismatching bracket!" `ho` is @(List ASCII)
   `la` Valid `hu` "[VALID] Everything is seem to be good."
 `yokl` Forth `ha` Run `ha` output


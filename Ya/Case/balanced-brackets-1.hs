import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Parenthesis = Unit `S` Unit

deposit bracket = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `hv` push @List bracket

analyze _______ = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `hv` pop @List
 `yok__` Try `ha__` None `hu` by Error `la` Some `hu` by Valid

remnant = Empty @List `hu` by Valid
 `la` Nonempty @List `he'hu` by Error

example = Nonempty @List @Parenthesis
 `ha` Item (Opened Unit) `ha` Next
 `ha` Item (Closed Unit) `ha` Last

main = by example
 `yokl` Forth `ha` Run `ha__` deposit `la` analyze `he'he'hv___` by `hv` Empty @List
 `yok_` Check `ha` remnant `ha'he` that @(List Unit)
 `yi__` Error `hu` "[ERROR] We missed some bracket, oh my!" `ho` is @(List ASCII)
   `la` Valid `hu` "[VALID] Everything is seem to be good."
 `yokl` Forth `ha` Run `ha` output
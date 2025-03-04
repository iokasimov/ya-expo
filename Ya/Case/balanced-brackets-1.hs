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

main = Nonempty @List @Parenthesis
 `ha` Item (Opened Unit) `ha` Next
 `ha` Item (Closed Unit) `ha` Last `hv` Unit
 `yokl` Run `ho` Forth `ha__` deposit `la` analyze
 `he'he'hv___` Empty @List Unit
 `yok_` Try `ha` remnant `ha'he` that @(List Unit)
 `yi__` is @(List ASCII)
   `hv` "[ERROR] We missed some bracket, oh my!"
   `lv` "[VALID] Everything is seem to be good."
 `yokl` Run `ho` Forth `ha` output

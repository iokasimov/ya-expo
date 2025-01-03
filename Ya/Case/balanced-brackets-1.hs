import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Parenthesis = Unit `ML` Unit

deposit bracket = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `hv` push @List bracket

analyze _______ = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `hv` pop @List
 `yok__` Try `ha__` None `hu` it Error `la` Some `hu` it Valid

remnant = Empty @List `hu` it Valid
 `la` Nonempty @List `he'hu` it Error

main = Nonempty @List @Parenthesis
 `ha` Item (Opened Unit) `ha` Maybe `ha` Next
 `ha` Item (Closed Unit) `ha` Maybe `hv` Last
 `yokl` Run `ho` Forth `ha__` deposit `la` analyze
 `he'he'hv___` Empty @List Unit
 `yok_` Try `ha` remnant `ha'he` that @(List Unit)
 `yi__` is @(List ASCII)
   `hv` "[ERROR] We missed some bracket, oh my!"
   `lv` "[VALID] Everything is seem to be good."
 `yokl` Run `ho` Forth `ha` output

import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console
import "ya-expo" Ya.Expo.Instances

import "base" System.IO (print)

type Parenthesis = Unit `ML` Unit

deposit bracket = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `he` push @List bracket

analyze _______ = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `he` pop @List
 `yok__` Try `ha__` Error `hv` None `la` Valid `hv` Some

remnant = Valid `hv` Empty @List
 `la` Error `hv'he` Nonempty @List

main = Nonempty @List @Parenthesis `ha` Next (Opened Unit) `he` Last (Closed Unit)
 `yokl` Forth `ha` Usual `ha__` deposit `la` analyze `he___'he` Empty @List Unit
 `yok_` Try `ha` remnant `ha'he` that @(List Unit)
 `yi__` is @(List ASCII)
 `ha__` is `hu` "[ERROR] We missed some bracket, oh my!"
   `la` is `hu` "[VALID] Everything is seem to be good!"
 `yokl` Forth `ha` Raw `ha` output

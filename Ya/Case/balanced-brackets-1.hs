import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import "ya-expo" Ya.Expo.Instances

import "base" System.IO (print)

type Parenthesis = Unit `ML` Unit

deposit p = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `he` push @List p

analyze _ = enter @(State `WR` List _ `JNT` Halts)
 `yuk__` New `ha` State `ha` Event `he` pop @List
 `yok__` Try `ha__` Error `hv` None `la` Valid `hv` Some

remnant = is `ho'he` that @(List Unit)
 `ho__` Valid `hv` Empty @List
   `la` Error `hv'he` Nonempty @List

main = Nonempty @List @Parenthesis
 `ha` Next (Opened ()) `he` Last (Closed ())
 `yokl` Forth `ha__` deposit `la` analyze
 `he___'he` Empty @List ()
 `yok_` Try `ha` remnant
 `yi__` is @(List ASCII)
 `ha__` is `hu` "[ERROR] A lonery or a missing bracket!"
   `la` is `hu` "[VALID] Everything is seem to be good!"
 `yokl` Forth `ha` output

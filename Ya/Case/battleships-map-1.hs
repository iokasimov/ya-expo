import "ya" Ya
import "ya-expo" Ya.Expo.Instances ()
import "ya-ascii" Ya.ASCII (ASCII)
import "ya-console" Ya.Console (output)

import "base" GHC.Num (Integer, (-), (+))

type Tile = Unit `ML` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Grid = Scrolling List `WR` Scrolling List Tile

fleet = Nonempty @List @Integer `ha` Next 2 `ha` Next 3  `ha` Next 3  `ha` Next 4  `he` Last 5

grid = is @Grid `ha` to `ha` Nonempty @List
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Ship `ha` Next Ship `ha` Next Idle `ha` Next Idle `he` Last Idle
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Ship `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Idle
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Ship `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Idle
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Ship `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Ship
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Ship `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Ship
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Ship
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Idle
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Idle
 `ha__` Next `he_` to `ha` Nonempty @List `ha` Next Ship `ha` Next Ship `ha` Next Ship `ha` Next Ship `ha` Next Ship `ha` Next Idle `ha` Next Ship `ha` Next Ship `ha` Next Ship `he` Last Idle
 `he__` Last `he_` to `ha` Nonempty @List `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `ha` Next Idle `he` Last Idle

main = enter

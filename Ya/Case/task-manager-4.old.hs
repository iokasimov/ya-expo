import Ya

import "base" System.IO (IO, print)
import "ya-ascii" Ya.ASCII
import "ya-tutorials" Ya.Expo.ASCII
import "ya-tutorials" Ya.Expo.Instances

import qualified "ya-tutorials" Ya.Expo.Terminal as Console

type Title = List ASCII

type Mark = Unit `ML` Unit

pattern TODO e = This e :: Mark
pattern DONE e = That e :: Mark

type Move = Unit `ML` Unit

pattern Down x = This x :: Move
pattern Lift x = That x :: Move

type Quit = Unit

type Task = Mark `LM` Title

pattern Task m t = These m t :: Task

type Command = Move `ML` Mark `ML` Quit

pattern Move x = This (This x) :: Command
pattern Mark x = This (That x) :: Command
pattern Quit x = That x :: Command

pattern Bullet = This Unit
pattern Cursor = That Unit

type Shifted = Shafted List

string cursor (These status title) = enter @IO
 `yuk__` Forward `he` hand cursor `yokl` output
 `yuk__` Forward `he` mark status `yokl` output
 `yuk__` Forward @List `he` title `yokl` output
 `yuk__` Once `he_` Caret Newline `yokl` output

hand = is @Title `ha__` is `hu` "   * " `la` is `hu` "   > "
mark = is @Title `ha__` is `hu` "TODO " `la` is `hu` "DONE "

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

type Project = Scrolling List Task

type Application = State Project `JNT` Halts `JNT` IO

process = enter @Application
 `yuk_____` prepare `lu'yp` Await `hv` clear
 `yuk_____` State `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Reverse List Task) at
 `yok_____'yokl` string Bullet
 `yuk_____` State `he__` Transition `he` auto
  `ha_'he` Scope @(Focused Task) at
 `yok_____'yokl` string Cursor
 `yuk_____` State `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Forward List Task) at
 `yok_____'yokl` string Bullet
 `yuk_____` input `yok__` Retry
  `ha___` match @Letter @ASCII
   `ho__` press `he` Lower K `he` (Move `ha` Down)
 `lo'ys'la` press `he` Lower J `he` (Move `ha` Lift)
 `lo'ys'la` press `he` Lower Q `he` (Quit)
 `lo'ys'la` press `he` Upper T `he` (Mark `ha` TODO)
 `lo'ys'la` press `he` Upper D `he` (Mark `ha` DONE)
     `la` Wrong `hv` is @(Number `ML` Symbol `ML` Caret)
 `yok_____` State `ho` to `ha__` Transition `ha_` scroll `ho'ho` (`yui` Unit)
  `la___` State `ho` to `ha__` Transition `ha_` switch `ho'ho` (`yui` Unit)
  `ho_'ha'he` Scope @(Focused Task) at `ho'he` Scope @Mark at
  `la___` Close `ho` to @Application
 `yok_____` Again `ha` Once

start = to @(Scrolling List) `ha` as @(Nonempty List) @Task `he__` is
 `li` Task `he` TODO () `he` "Apply to that new position"
 `lu` Task `he` DONE () `he` "Find a way to fix ligatures"
 `lu` Task `he` TODO () `he` "Organize a boardgame session"
 `lu` Task `he` DONE () `he` "Buy a water gun for Songkran"

main = unwrap (process `he'he` start)

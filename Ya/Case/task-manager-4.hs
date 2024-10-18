import Ya

import "base" System.IO (IO, print)
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII
import "ya-expo" Ya.Expo.Instances

import qualified "ya-expo" Ya.Expo.Terminal as Console

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
 `yukkk` Forward `he` hand cursor `yokl` Console.output
 `yukkk` Forward `he` mark status `yokl` Console.output
 `yukkk` Forward @List `he` title `yokl` Console.output
 `yukkk` Once `hee` Caret Newline `yokl` Console.output

hand = is @Title `haaa` is `hu` "  -  " `la` is `hu` "  -> "
mark = is @Title `haaa` is `hu` "TODO " `la` is `hu` "DONE "

press k f p = Maybe `heeee` k `hd'q` p `yui` Unit `yiu` f Unit

type Application = State `WR` Scrolling List Task `JNT` Halts `JNT` IO

draft = enter @Application
 `yukkkk` Console.prepare `lu'yp` Console.clear
 `yukkkk` State `heee` Transition `he` auto
  `haa'he` at @(Shafted List Task)
   `ho'he` at @(Reverse List Task)
 `yokkkk'yokl` string Bullet
 `yukkkk` State `heee` Transition `he` auto
  `haa'he` at @(Focused Task)
 `yokkkk'yokl` string Cursor
 `yukkkk` State `heee` Transition `he` auto
  `haa'he` at @(Shafted List Task)
   `ho'he` at @(Forward List Task)
 `yokkkk'yokl` string Bullet
 `yukkkk` Console.input `yokkkk` Retry
 `haaaaa` press `he` Lower K `he` (Move `ha` Down)
 `lo'ys'la` press `he` Lower J `he` (Move `ha` Lift)
 `lo'ys'la` press `he` Lower Q `he` (Quit)
 `lo'ys'la` press `he` Upper T `he` (Mark `ha` TODO)
 `lo'ys'la` press `he` Upper D `he` (Mark `ha` DONE)
     `la` Wrong
 `haaaaa` match @Letter @ASCII
 `yokkkk` State `ho` to `haaa` Transition `haa` scroll `ho'ho` (`yui` Unit)
  `laaaa` State `ho` to `haaa` Transition `haa` switch `ho'ho` (`yui` Unit)
  `hoo'ha'he` at @(Focused Task) `ho'he` at @Mark
  `laaaa` Close `ho` to @Application
 `yokkkk` Again `ha` Once

main = unwrap (draft `heeee'he` to @(Scrolling List)
 `ha` as @(Nonempty List) @Task `heee` is
 `li` Task `he` TODO () `he` "Apply to that new position"
 `lu` Task `he` DONE () `he` "Find a way to fix ligatures"
 `lu` Task `he` TODO () `he` "Organize a boardgame session"
 `lu` Task `he` DONE () `he` "Buy a water gun for Songkran")

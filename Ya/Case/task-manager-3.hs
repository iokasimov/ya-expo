import Ya

import "base" System.IO (IO)
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.Instances ()

import qualified "ya-expo" Ya.Expo.Terminal as Console
import "ya-expo" Ya.Expo.ASCII

type Title = List ASCII

type Mark = Unit `ML` Unit

pattern TODO e = This e :: Mark
pattern DONE e = That e :: Mark

type Move = Unit `ML` Unit

type Task = Mark `LM` Title

pattern Task m t = These m t :: Task

type Command = Move `ML` Mark

pattern Move x = This x :: Command
pattern Mark x = That x :: Command

-- TODO: try to use this operator here! `yo'ha` 

pattern Bullet = This Unit
pattern Cursor = That Unit

string cursor status title = enter @IO
 `yukkk` Forward `he` hand cursor `yokl` Console.output
 `yukkk` Forward `he` mark status `yokl` Console.output
 `yukkk` Forward @List `he` title `yokl` Console.output
 `yukkk` Once `hee` Caret Newline `yokl` Console.output

hand = is @Title `haaa` is `hu` "  -  " `la` is `hu` "  -> "
mark = is @Title `haaa` is `hu` "TODO " `la` is `hu` "DONE "

press k f p = Maybe `heeee` k `hd'q` p `yui` Unit `yiu` f Unit

type Shifted = Shafted List

draft = enter @(State `T_I` Scrolling List Task `JNT` IO)
 `yukkkk` Console.prepare `lu'yp` Console.clear
 `yukkkk` State `heee` Transition `he` auto
  `haa'he` at @(Shifted Task)
   `ho'he` at @(Reverse List Task)
 `yokkkk'yokl` (string Bullet `hj`)
 `yukkkk` State `heee` Transition `he` auto
  `haa'he` at @(Focused Task)
 `yokkkk'yokl` (string Cursor `hj`)
 `yukkkk` State `heee` Transition `he` auto
  `haa'he` at @(Shifted Task)
   `ho'he` at @(Forward List Task)
 `yokkkk'yokl` (string Bullet `hj`)
 `yukkkk` Console.input `yokkkk` Retry
 `haaaaa` press K (Move `ha` Down)
 `lo'ys'la` press J (Move `ha` Lift)
   `laaa` press T (Mark `ha` TODO)
 `lo'ys'la` press D (Mark `ha` DONE)
   `laaa` is @Number `hu` None ()
   `laaa` is @Symbol `hu` None ()
   `laaa` is @Signal `hu` None ()
 `yokkkk` State `haaa` Transition `haa` scroll `ho'ho` (`yui` Unit)
  `laaaa` State `haaa` Transition `haa` switch `ho'ho` (`yui` Unit)
 `hoo'ha'he` at @(Focused Task) `ho'he` at @Mark
 `yokkkk` Again `ha` Once

main = draft `heeee'he` to @(Scrolling List)
 `ha` as @(Nonempty List) @Task `heee` is
 `li` Task `he` TODO () `he` "Apply to that new position"
 `lu` Task `he` DONE () `he` "Find a way to fix ligatures"
 `lu` Task `he` TODO () `he` "Organize a boardgame session"
 `lu` Task `he` DONE () `he` "Buy a water gun for Songkran"

-- TODO: `q` to exit the loop

import Ya

import "base" System.IO (IO)
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

type Task = Mark `P` Title

pattern Task m t = These m t :: Task

type Command = Move `ML` Mark

pattern Move x = This x :: Command
pattern Mark x = That x :: Command

pattern Bullet = This Unit
pattern Cursor = That Unit

string cursor (These status title) = enter @IO
 `yuk__` Forward `he` hand cursor `yokl` output
 `yuk__` Forward `he` mark status `yokl` output
 `yuk__` Forward @List `he` title `yokl` output
 `yuk__` Once `he_` Caret Newline `yokl` output

hand = is @Title `ha__` is `hu` "  -  " `la` is `hu` "  -> "
mark = is @Title `ha__` is `hu` "TODO " `la` is `hu` "DONE "

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

draft = enter @(State `T'I` Scrolling List Task `JNT` IO)
 `yuk___` prepare `lu'yp` Await `hv` clear
 `yuk___` State `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Reverse List Task) at
 `yok___'yokl` string Bullet
 `yuk___` State `he__` Transition `he` auto
  `ha_'he` Scope @(Focused Task) at
 `yok___'yokl` string Cursor
 `yuk___` State `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Forward List Task) at
 `yok___'yokl` string Bullet
 `yuk___` input `yok___` Retry
 `ha____` match @(Cased Latin) @ASCII
  `ho___` press K (Move `ha` Down) `lo'ys'la` press J (Move `ha` Lift)
    `la_` press T (Mark `ha` TODO) `lo'ys'la` press D (Mark `ha` DONE)
    `la_` is @(Number `ML` Symbol `ML` Caret) `hu` Wrong ()
 `yok___` State `ha__` Transition `ha_` scroll `ho'ho` (`yui` ())
  `la___` State `ha__` Transition `ha_` switch `ho'ho` (`yui` ())
    `ho_'ha'he` Scope @(Focused Task) at `ho'he` Scope @Mark at
 `yok___` Again `ha` Once

main = draft `he___'he` to @(Scrolling List)
 `ha` as @(Nonempty List) @Task `he__` is
 `li` Task `he` TODO () `he` "Apply to that new position"
 `lu` Task `he` DONE () `he` "Find a way to fix ligatures"
 `lu` Task `he` TODO () `he` "Organize a boardgame session"
 `lu` Task `he` DONE () `he` "Buy a water gun for Songkran"

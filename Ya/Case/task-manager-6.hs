import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console
import "ya-expo" Ya.Expo.Instances
import "base" System.IO (IO)

type Title = List ASCII

type Mark = Unit `ML` Unit

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `LM` Title

pattern Task m t = These m t :: Task

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor (These status task) = enter @IO
 `yuk___` Run (hand `yokl` Forth `ha` Run `ha` output)
 `yuk___` Run (mark `yokl` Forth `ha` Run `ha` output)
 `yuk___` Run (task `yokl` Forth `ha` Run `ha` output)
 `yuk___` Run (output `he` Caret Newline) where

 hand = is @Title `he__` is `hu` "  -  " `la` is `hu` "  -> " `li` cursor
 mark = is @Title `he__` is `hu` "TODO " `la` is `hu` "DONE " `li` status

type Move = Scroller List

pattern Lift x = This x :: Move
pattern Down x = That x :: Move

type Command = Move `ML` Mark

pattern Move x = This x :: Command
pattern Mark x = That x :: Command

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `MN` Glyph `ML_` Glyph `MN` Letter) `hu` Wrong Unit
 `la____` press `hv` Lower J `hv` (Move `ha` Down)
 `lo'ys'la` press `hv` Lower K `hv` (Move `ha` Lift)
 `lo'ys'la` press `hv` Upper T `hv` (Mark `ha` TODO)
 `lo'ys'la` press `hv` Upper D `hv` (Mark `ha` DONE)

start = to @(Scrolling List) `ha` Nonempty @List @Task
 `ha` Item (by TODO `lu` "Apply to that new position") `ha` Next
 `ha` Item (by TODO `lu` "Find a way to fix ligatures") `ha` Next
 `ha` Item (by TODO `lu` "Organize a boardgame session") `ha` Next
 `ha` Item (by DONE `lu` "Buy a water gun for Songkran") `ha` Maybe `hv` Unit

type Project = Scrolling Tree Task

type Outline = Scrolling List Project

type Application = State Outline `JNT` Halts `JNT` IO

-- type Application = State `WR` Scrolling List Task `JNT` IO

draft = enter @Application
 `yuk___` Run (prepare `lu'yp` clear)
 `yuk___` State `ho` New
  `he___` Event `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Reverse List Task) at
   `ho'he` Scope @(List Task) it
 `yok___` Run `ha_'yokl` Prior `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Focused Task) at
 `yok___` Run `ha_'yokl` Forth `ha` Run `ha` print Cursor
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Forward List Task) at
   `ho'he` Scope @(List Task) it
 `yok___` Run `ha_'yokl` Forth `ha` Run `ha` print Bullet
 `yuk___` Run `he___` input
    `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha__` Event `ha_` scroll `ho'ho` (`yui` Unit)
  `la___` State `ho` New `ha__` Event `ha_` switch `ho'ho` (`yui` Unit)
 `ho_'ha'he` Scope @(Focused Task) at `ho'he` Scope @Mark at
 `yok___` Again `ha` Once

main = draft `he'he` start

import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console
import "ya-tutorials" Ya.Expo.Instances
import "base" System.IO (IO)

type Title = List ASCII

type Mark = Unit `S` Unit

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `P` Title

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

type Command = Move `S` Mark

pattern Move x = This x :: Command
pattern Mark x = That x :: Command

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `MN` Glyph `S_` Glyph `MN` Letter) `hu` Wrong Unit
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

draft = enter @(State `T'I` Scrolling List Task `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Passed `yok___` World `ha_'yokl` Prior `ha` Run `ha` print (by Bullet)
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `hv` focus `ho` Scope it `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Cursor)
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Future `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Bullet)
 `yuk___` World `hv___` input `yok` Retry @Command `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha___` Event `ha` (scroll `ho'ho'yui` Unit)
  `la___` State `ho` New `ha___` Event `ha` (switch `ho'ho'yui` Unit) `ho__'ha` Scope `hv` focus `ho_'he` Scope `hv` at @Mark
 `yok___` Again `ha` Once

main = draft `he'he'hv` by start

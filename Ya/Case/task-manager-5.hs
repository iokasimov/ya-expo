import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Title = List ASCII

type Mark = Scroller List

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `LM` Title

pattern Bullet = This Unit
pattern Cursor = That Unit

type Move = Scroller List

pattern Lift x = This x
pattern Down x = That x

type Command = Move `ML` Mark

pattern Move x = This x
pattern Mark x = That x

print cursor (These status task) = enter @World
 `yuk___` Run `hv____` hand `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` mark `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` task `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline where

 hand = is @Title `hv__` "  -  " `lv` "  -> " `li` cursor
 mark = is @Title `hv__` "TODO " `lv` "DONE " `li` status

press k f p = Maybe `hv___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `MN` Glyph `ML_` Glyph `MN` Letter) `hu` by Wrong
 `la____` press `hv` Lower J `hv` (Move `ha` Down)
 `lo'ys'la` press `hv` Lower K `hv` (Move `ha` Lift)
 `lo'ys'la` press `hv` Upper T `hv` (Mark `ha` TODO)
 `lo'ys'la` press `hv` Upper D `hv` (Mark `ha` DONE)

start = to @(Scrolling List) `ha` Nonempty @List @Task
 `ha` Item (by TODO `lu` "Apply to that new position") `ha` Next
 `ha` Item (by TODO `lu` "Find a way to fix ligatures") `ha` Next
 `ha` Item (by TODO `lu` "Organize a boardgame session") `ha` Next
 `ha` Item (by DONE `lu` "Buy a water gun for Songkran") `ha` Maybe `hv` Last

draft = enter @(State `WR` Scrolling List Task `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` New `hv___` Event `hv` auto
 `ha__'he` Scope `hv` at @(Shafted List Task)
  `ho_'he` Scope `hv` at @(Reverse List Task)
  `ho_'he` Scope `hv` it @(List Task)
 `yok___` World `ha_'yokl` Prior `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `hv___` Event `hv` auto
 `ha__'he` Scope `hv` at @(Focused Task)
 `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Cursor
 `yuk___` State `ho` New `hv___` Event `hv` auto
 `ha__'he` Scope `hv` at @(Shafted List Task)
  `ho_'he` Scope `hv` at @(Forward List Task)
  `ho_'he` Scope `hv` it @(List Task)
 `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Bullet
 `yuk___` World `hv___` input
    `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha__` Event `ha` (scroll `ho'ho'yui` Unit)
  `la___` State `ho` New `ha__` Event `ha` (switch `ho'ho'yui` Unit)
 `ho_'ha'he` Scope `hv` at @(Focused Task) `ho'he` (Scope `hv` at @Mark)
 `yok___` Again `ha` Once

main = draft `he'he'hv` start

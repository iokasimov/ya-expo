import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Title = List ASCII

type Mark = Unit `S` Unit

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `P` Title

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor (These status task) = enter @World
 `yuk___` Run `hv____` hand `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` mark `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` task `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline where

 hand = is @Title `hv__` "  -  " `lv` "  -> " `li` cursor
 mark = is @Title `hv__` "TODO " `lv` "DONE " `li` status

type Move = Scroller List

pattern Lift x = This x
pattern Down x = That x

press k f p = Maybe `hv___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `MN` Glyph `S_` Glyph `MN` Letter) `hu` Wrong Unit
 `la____` press `hv` Lower J `hv` Down
 `lo'ys'la` press `hv` Lower K `hv` Lift

start = to @(Scrolling List) `ha` Nonempty @List @Task
 `ha` Item (by TODO `lu` "Apply to that new position") `ha` Next
 `ha` Item (by TODO `lu` "Find a way to fix ligatures") `ha` Next
 `ha` Item (by TODO `lu` "Organize a boardgame session") `ha` Next
 `ha` Item (by DONE `lu` "Buy a water gun for Songkran") `ha` Last

draft = enter @(State `WR` Scrolling List Task `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` New `hv__` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Passed `yok___` World `ha_'yokl` Prior `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `hv__` Event `hv` auto `ha_` Scope `hv` focus `ho` Scope it `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Cursor
 `yuk___` State `ho` New `hv__` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Future `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Bullet
 `yuk___` World `hv___` input `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha` Event `ha` scroll
 `yok___` Again `ha` Once

main = draft `he'he'hv` by start

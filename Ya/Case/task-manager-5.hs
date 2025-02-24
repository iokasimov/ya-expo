import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Title = List ASCII

type Mark = Scroller List

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `LM` Title

pattern Bullet e = This e
pattern Cursor e = That e

type Move = Scroller List

pattern Lift x = This x
pattern Down x = That x

type Command = Move `ML` Mark

pattern Move x = This x
pattern Mark x = That x

print cursor (These status task) = enter @World
 `yuk___` Run `hv____` hand cursor `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` mark status `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` task `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline

hand cursor = is @Title `hv__` Bullet `hu` "  -  " `la` Cursor `hu` "  -> " `li` cursor

mark status = is @Title `hv__` TODO `hu` "TODO " `la` DONE `hu` "DONE " `li` status

press k f p = Maybe `hv___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `MN` Glyph `ML_` Glyph `MN` Letter) `hu` by Wrong
 `la____` press `hv` Lower J `hv` (Move `ha` Down)
 `lo'ys'la` press `hv` Lower K `hv` (Move `ha` Lift)
 `lo'ys'la` press `hv` Upper T `hv` (Mark `ha` TODO)
 `lo'ys'la` press `hv` Upper D `hv` (Mark `ha` DONE)

start = to @(Scrolling List) `ha` Nonempty @List @Task
 `ha_` Next `ho` Item (by TODO `lu` "Apply to that new position")
 `ha_` Next `ho` Item (by TODO `lu` "Find a way to fix ligatures")
 `ha_` Next `ho` Item (by TODO `lu` "Organize a boardgame session")
 `ha_` Last `ho` Item (by DONE `lu` "Buy a water gun for Songkran")

draft = enter @(State `WR` Scrolling List Task `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Passed `yok___` World `ha_'yokl` Prior `ha` Run `ha` print (by Bullet)
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `hv` focus `ho` Scope it `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Cursor)
 `yuk___` State `ho` Old `hv___` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Future `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Bullet)
 `yuk___` World `hv___` input `yok` Retry @Command `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha___` Event `ha` (scroll `ho'ho'yui` Unit)
  `la___` State `ho` New `ha___` Event `ha` (switch `ho'ho'yui` Unit) `ho__'ha` Scope `hv` focus `ho_'he` Scope `hv` at @Mark
 `yok___` Again `ha` Once

main = draft `he'he'hv` by start

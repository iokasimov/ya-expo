import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Title = List ASCII

pattern Bullet e = This e
pattern Cursor e = That e

print cursor title = enter @World
 `yuk___` Run `hv____` point `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` title `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline where

 point = is @Title `hv__` Bullet `hu` "  -  " `la` Cursor `hu` "  -> " `hv_` cursor

type Move = Shifter List

pattern Lift x = This x :: Move
pattern Down x = That x :: Move

press k f p = Maybe `hv___` k `hv` Unit `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `M` Glyph `S_` Glyph `M` Letter) `hu` by Wrong
 `la____` press `hv` (Lower `ha` J) `hv` Down
 `lo'ys'la` press `hv` (Lower `ha` K) `hv` Lift

start = to @(Scrolling List) `ha` Nonempty @List @Title
 `ha` Item "Apply to that new position" `ha` Next
 `ha` Item "Find a way to fix ligatures" `ha` Next
 `ha` Item "Organize a boardgame session" `ha` Next
 `ha` Item "Buy a water gun for Songkran" `ha` Last

draft = enter @(State `WR` Scrolling List Title `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` New `hv__` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Passed `yok___` World `ha_'yokl` Prior `ha` Run `ha` print (by Bullet)
 `yuk___` State `ho` New `hv__` Event `hv` auto `ha_` Scope `hv` focus `ho` Scope it `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Cursor)
 `yuk___` State `ho` New `hv__` Event `hv` auto `ha_` Scope `ha` shaft `hv` by Future `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Bullet)
 `yuk___` World `hv___` input `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha` Event `ha` shift
 `yok___` Again `ha` Once

main = draft `he'he'hv` by start

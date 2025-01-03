import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Title = List ASCII

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor title = enter @World
 `yuk___` Run `hv____` point `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` title `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `hv` Caret Newline where

 point = is @Title `hv__` "  -  " `lv` "  -> " `hv_` cursor

type Move = Scroller List

pattern Lift x = This x :: Move
pattern Down x = That x :: Move

press k f p = Maybe `hv___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = is @(ASCII `MN` Glyph `ML_` Glyph `MN` Letter) `hu` it Wrong
 `la____` press `hv` Lower J `hv` Down
 `lo'ys'la` press `hv` Lower K `hv` Lift

start = to @(Scrolling List) `ha` Nonempty @List @Title
 `ha` Item "Apply to that new position" `ha` Maybe `ha` Next
 `ha` Item "Find a way to fix ligatures" `ha` Maybe `ha` Next
 `ha` Item "Organize a boardgame session" `ha` Maybe `ha` Next
 `ha` Item "Buy a water gun for Songkran" `ha` Maybe `hv` Last

draft = enter @(State `WR` Scrolling List Title `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` New `hv___` Transition `hv` auto
 `ha__'he` Scope `hv` at @(Shafted List Title)
  `ho_'he` Scope `hv` at @(Reverse List Title)
  `ho_'he` Scope `hv` self @(List Title)
 `yok___` World `ha_'yokl` Prior `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `hv___` Transition `hv` auto
 `ha__'he` Scope `hv` at @(Focused Title)
 `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Cursor
 `yuk___` State `ho` New `hv___` Transition `hv` auto
 `ha__'he` Scope `hv` at @(Shafted List Title)
  `ho_'he` Scope `hv` at @(Forward List Title)
  `ho_'he` Scope `hv` self @(List Title)
 `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Bullet
 `yuk___` World `hv___` input
    `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha` Event `ha` scroll
 `yok___` Again `ha` Once

main = draft `he'he'hv` start

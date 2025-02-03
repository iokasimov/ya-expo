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
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline where

 point = is @Title `hv__` "  -  " `lv` "  -> " `hv_` cursor

initial = to @(Scrolling List) `ha` Nonempty @List @Title
 `ha` Item "Apply to that new position" `ha` Next
 `ha` Item "Find a way to fix ligatures" `ha` Next
 `ha` Item "Organize a boardgame session" `ha` Next
 `ha` Item "Buy a water gun for Songkran" `ha` Last `hv` Unit

draft = enter @(State `WR` Scrolling List Title `JNT` World)
 `yuk___` World `hv__` prepare `lu'yp` clear
 `yuk___` State `ho` New `hv___` Event `hv` auto
 `ha__'he` Scope `hv` at @(Shafted List Title)
  `ho_'he` Scope `hv` at @(Reverse List Title)
  `ho_'he` Scope `hv` it @(List Title)
 `yok___` World `ha_'yokl` Prior `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `hv___` Event `hv` auto
 `ha__'he` Scope `hv` at @(Focused Title)
 `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Cursor
 `yuk___` State `ho` New `hv___` Event `hv` auto
 `ha__'he` Scope `hv` at @(Shafted List Title)
  `ho_'he` Scope `hv` at @(Forward List Title)
  `ho_'he` Scope `hv` it @(List Title)
 `yok___` World `ha_'yokl` Forth `ha` Run `ha` print Bullet

main = draft `he'he'hv` initial

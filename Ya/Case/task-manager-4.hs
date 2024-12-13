import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console
import "ya-expo" Ya.Expo.Instances
import "base" System.IO (IO)

type Title = List ASCII

type Mark = Unit `ML` Unit

pattern TODO = This Unit
pattern DONE = That Unit

type Task = Mark `LM` Title

pattern Task m t = These m t :: Task

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor (These status task) = enter @IO
 `yuk___` Raw (hand `yokl` Forth `ha` output)
 `yuk___` Raw (mark `yokl` Forth `ha` output)
 `yuk___` Raw (task `yokl` Forth `ha` output)
 `yuk___` Raw (output `he` Caret Newline) where

 hand = is @Title `he__` is `hu` "  -  " `la` is `hu` "  -> " `li` cursor
 mark = is @Title `he__` is `hu` "TODO " `la` is `hu` "DONE " `li` status

type Move = Scroller List

pattern Lift x = This x :: Move
pattern Down x = That x :: Move

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = Wrong `hv` is @(ASCII `MN` Glyph `ML_` Glyph `MN` Letter)
 `la____` press `he` Lower J `he` Down
 `lo'ys'la` press `he` Lower K `he` Lift

start = to @(Scrolling List) `ha` Construct
 `ha_` Next `he` Task TODO "Apply to that new position"
 `ha_` Next `he` Task TODO "Find a way to fix ligatures"
 `ha_` Next `he` Task TODO "Organize a boardgame session"
 `he_` Last `he` Task DONE "Buy a water gun for Songkran"

draft = enter @(State `WR` Scrolling List Task `JNT` IO)
 `yuk___` Raw (prepare `lu'yp` clear)
 `yuk___` State `ho` New
  `he___` Event `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Reverse List Task) at
   `ho'he` Scope @(List Task) self
 `yok___` Raw `ha_'yokl` Prior `ha` print Bullet
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Focused Task) at
 `yok___` Raw `ha_'yokl` Forth `ha` print Cursor
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Forward List Task) at
   `ho'he` Scope @(List Task) self
 `yok___` Raw `ha_'yokl` Forth `ha` print Bullet
 `yuk___` Raw `he___` input
    `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha` Event `ha` scroll
 `yok___` Again `ha` Once

main = draft `he'he` start

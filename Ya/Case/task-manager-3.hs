import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import "ya-expo" Ya.Expo.Instances ()

import "base" System.IO (IO)

type Title = List ASCII

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor title = enter @IO
 `yuk___` Run (point `yokl` Forth `ha` Usual `ha` output)
 `yuk___` Run (title `yokl` Forth `ha` Usual `ha` output)
 `yuk___` Run (output `he` Caret Newline) where

 point = is @Title `he__` is `hu` "  -  " `la` is `hu` "  -> " `li` cursor

type Move = Scroller List

pattern Lift x = This x :: Move
pattern Down x = That x :: Move

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = Wrong `hv` is @(ASCII `MN` Glyph `ML_` Glyph `MN` Letter)
 `la____` press `he` Lower J `he` Down
 `lo'ys'la` press `he` Lower K `he` Lift

start = to @(Scrolling List) `ha` Construct
 `ha_` Next `he` "Apply to that new position"
 `ha_` Next `he` "Find a way to fix ligatures"
 `ha_` Next `he` "Organize a boardgame session"
 `he_` Last `he` "Buy a water gun for Songkran"

draft = enter @(State `WR` Scrolling List Title `JNT` IO)
 `yuk___` Run (prepare `lu'yp` clear)
 `yuk___` State `ho` New
  `he___` Event `he` auto
  `ha_'he` Scope @(Shafted List Title) at
   `ho'he` Scope @(Reverse List Title) at
   `ho'he` Scope @(List Title) self
 `yok___` Run `ha_'yokl` Prior `ha` Usual `ha` print Bullet
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Focused Title) at
 `yok___` Run `ha_'yokl` Forth `ha` Usual `ha` print Cursor
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Shafted List Title) at
   `ho'he` Scope @(Forward List Title) at
   `ho'he` Scope @(List Title) self
 `yok___` Run `ha_'yokl` Forth `ha` Usual `ha` print Bullet
 `yuk___` Run `he___` input
    `yok` Retry `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 `yok___` State `ho` New `ha` Event `ha` scroll
 `yok___` Again `ha` Once

main = draft `he'he` start

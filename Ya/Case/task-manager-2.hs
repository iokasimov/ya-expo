import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import "ya-expo" Ya.Expo.Instances ()

import "base" System.IO (IO)

type Title = List ASCII

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor title = enter @IO
 `yuk___` Run (point `yokl` Forth `ha` Run `ha` output)
 `yuk___` Run (title `yokl` Forth `ha` Run `ha` output)
 `yuk___` Run (output `he` Caret Newline) where

 point = is @Title `he__` is `hu` "  -  " `la` is `hu` "  -> " `li` cursor

initial = to @(Scrolling List) `ha` Construct
 `ha_` Next `he` "Apply to that new position"
 `ha_` Next `he` "Find a way to fix ligatures"
 `ha_` Next `he` "Organize a boardgame session"
 `he_` Last `he` "Buy a water gun for Songkran"

draft = enter @(State `WR` Scrolling List Title `JNT` IO)
 `yuk___` Run (prepare `lu'yp` clear)
 `yuk___` State `ho` New `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Title) at
   `ho'he` Scope @(Reverse List Title) at
   `ho'he` Scope @(List Title) self
 -- `yok___'yokl` Default `ha` Prior `ha` print Bullet
 `yok___` Run `ha_'yokl` Prior `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `he__` Transition `he` auto
  `ha_'he` Scope @(Focused Title) at
 -- `yok___` Run `ha_'yokl` Forth `ha` Run `ha` print Cursor
 `yok___'yokl` Forth `ha` Run `ha` print Bullet
 `yuk___` State `ho` New `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Title) at
   `ho'he` Scope @(Forward List Title) at
   `ho'he` Scope @(List Title) self
 `yok___'yokl` Forth `ha` Run `ha` print Bullet
 -- `yok___` Run `ha_'yokl` Forth `ha` Run `ha` print Bullet

main = draft `he'he` initial

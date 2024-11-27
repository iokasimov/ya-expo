import Ya

import "base" System.IO (IO)
import "ya-expo" Ya.Expo.Instances
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII

import "ya-expo" Ya.Expo.Terminal as Console

type Title = List ASCII

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor title = enter @IO
 `yuk___` IO (point `yokl` Forth `ha` Console.output)
 `yuk___` IO (title `yokl` Forth `ha` Console.output)
 `yuk___` IO (Console.output `he` Signal Newline) where

 point = is @Title `he__` is `hu` "  -  " `la` is `hu` "  -> " `li` cursor

initial = to @(Scrolling List) `ha` Construct
 `ha_` Next `he` "Apply to that new position"
 `ha_` Next `he` "Find a way to fix ligatures"
 `ha_` Next `he` "Organize a boardgame session"
 `he_` Last `he` "Buy a water gun for Songkran"

draft = enter @(State `WR` Scrolling List Title `JNT` IO)
 `yuk___` IO (Console.prepare `lu'yp` Console.clear)
 `yuk___` State `ho` New `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Title) at
   `ho'he` Scope @(Reverse List Title) at
   `ho'he` Scope @(List Title) self
 -- `yok___'yokl` Default `ha` Prior `ha` print Bullet
 `yok___` IO `ha_'yokl` Prior `ha` print Bullet
 `yuk___` State `ho` New `he__` Transition `he` auto
  `ha_'he` Scope @(Focused Title) at
 `yok___` IO `ha_'yokl` Forth `ha` print Cursor
 `yuk___` State `ho` New `he__` Transition `he` auto
  `ha_'he` Scope @(Shafted List Title) at
   `ho'he` Scope @(Forward List Title) at
   `ho'he` Scope @(List Title) self
 `yok___` IO `ha_'yokl` Forth `ha` print Bullet

main = draft `he'he` initial

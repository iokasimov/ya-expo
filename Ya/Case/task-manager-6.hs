import Ya

import "base" System.IO (IO)
import "ya-expo" Ya.Expo.Instances
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII

import "ya-expo" Ya.Expo.Terminal as Console

type Title = List ASCII

type Mark = Unit `ML` Unit

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `LM` Title

pattern Task m t = These m t :: Task

pattern Bullet = This Unit
pattern Cursor = That Unit

print cursor (These status task) = enter @IO
 `yuk___` IO (hand `yokl` Forth `ha` Console.output)
 `yuk___` IO (mark `yokl` Forth `ha` Console.output)
 `yuk___` IO (task `yokl` Forth `ha` Console.output)
 `yuk___` IO (Console.output `he` Signal Newline) where

 hand = is @Title `he__` is `hu` "  -  " `la` is `hu` "  -> " `li` cursor
 mark = is @Title `he__` is `hu` "TODO " `la` is `hu` "DONE " `li` status

type Move = Scroller List

pattern Lift x = This x :: Move
pattern Down x = That x :: Move

type Command = Move `ML` Mark

pattern Move x = This x :: Command
pattern Mark x = That x :: Command

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

apply = press `he` Lower J `he` (Move `ha` Down)
 `lo'ys'la` press `he` Lower K `he` (Move `ha` Lift)
 `lo'ys'la` press `he` Upper T `he` (Mark `ha` TODO)
 `lo'ys'la` press `he` Upper D `he` (Mark `ha` DONE)
 `la____` Wrong `hv` is @(Number `ML` Symbol `ML` Caret)

start = to @(Scrolling List) `ha` Construct
 `ha_` Next `he` Task (TODO ()) "Apply to that new position"
 `ha_` Next `he` Task (TODO ()) "Find a way to fix ligatures"
 `ha_` Next `he` Task (TODO ()) "Organize a boardgame session"
 `he_` Last `he` Task (DONE ()) "Buy a water gun for Songkran"

type Application = State `WR` Scrolling List Task `JNT` IO

draft = enter @Application
 `yuk___` Usual (Console.prepare `lu'yp` Console.clear)
 `yuk___` State `ho` New
  `he___` Event `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Reverse List Task) at
   `ho'he` Scope @(List Task) self
 `yok___` Usual `ha_'yokl` Prior `ha` print Bullet
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Focused Task) at
 `yok___` Usual `ha_'yokl` Forth `ha` print Cursor
 `yuk___` State `ho` New `he__` Event `he` auto
  `ha_'he` Scope @(Shafted List Task) at
   `ho'he` Scope @(Forward List Task) at
   `ho'he` Scope @(List Task) self
 `yok___` Usual `ha_'yokl` Forth `ha` print Bullet
 `yuk___` Usual `he___` Console.input
    `yok` Retry `ha` apply `ha` match @Letter @ASCII
 `yok___` State `ho` New `ha__` Event `ha_` scroll `ho'ho` (`yui` Unit)
  `la___` State `ho` New `ha__` Event `ha_` switch `ho'ho` (`yui` Unit)
 `ho_'ha'he` Scope @(Focused Task) at `ho'he` Scope @Mark at
 `yok___` Again `ha` Once

main = draft `he'he` start

import Ya

import "base" System.IO (IO, print)
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII
import "ya-expo" Ya.Expo.Instances

import qualified "ya-expo" Ya.Expo.Terminal as Console

type Title = List ASCII

type Mark = Unit `ML` Unit

pattern TODO e = This e :: Mark
pattern DONE e = That e :: Mark

type Move = Unit `ML` Unit

pattern Down x = This x :: Move
pattern Lift x = That x :: Move

type Quit = Unit

type Task = Mark `LM` Title

pattern Task m t = These m t :: Task

type Command = Scroller List `ML` Mark `ML` Quit

pattern Move x = This (This x) :: Command
pattern Mark x = This (That x) :: Command
pattern Quit x = That x :: Command

pattern Bullet = This Unit
pattern Cursor = That Unit

type Shifted = Shafted List

string prefix cursor (These status title) = enter @IO
 `yuk__` Forward `he` prefix `yokl` Console.output
 `yuk__` Forward `he` hand cursor `yokl` Console.output
 `yuk__` Forward `he` mark status `yokl` Console.output
 `yuk__` Forward @List `he` title `yokl` Console.output
 `yuk__` Once `he_` Caret Newline `yokl` Console.output

block_tree prefix cursor tree =
      this `ho` is @Task `ho` string prefix cursor
 `lo'yp` (that `ho` Forward `ho_'yokl` Construct `ho` block_tree (tab `ha` tab `he` prefix) Bullet) `ho'yu` Unit
 `li` unwrap (unwrap (unwrap tree))

tab = that `ha` push @List (Caret Space)

block_scrolling_list_tree prefix cursor (U_T_I_TT_I (These focus (U_T_I_TT_I (These left right)))) = enter @IO
 `yuk__`  left `yokl` block_tree prefix Bullet
 `yuk__` focus `yokl` block_tree prefix cursor
 `yuk__` right `yokl` block_tree prefix Bullet

block_project :: Title -> (Unit `ML` Unit) -> Project -> IO Unit
block_project prefix cursor project = enter @IO
 `yuk__` Console.output `he` Caret Newline
 `yuk__` block_scrolling_list_tree prefix cursor `ha` unwrap @AR
    `ha` to @(Scrolling List `T'TT'I` Tree) `he` project
 `yuk__` enter @IO where

hand = is @Title `ha__` is `hu` "   * " `la` is `hu` "  -> "
mark = is @Title `ha__` is `hu` "TODO " `la` is `hu` "DONE "

press k f p = Maybe `he___` k `hd'q` p `yui` Unit `yiu` f Unit

type Project = Scrolling Tree Task

type Outline = Scrolling List Project

type Application = State Outline `JNT` Halts `JNT` IO

draft = enter @Application
 `yuk___` Console.prepare `lu'yp` Console.clear
 `yuk___` State `he___` Transition `he` auto
 `ha__'he` Scope @(Shafted List Project) at
   `ho'he` Scope @(Reverse List Project) at
 `yok___'yokl` block_project (Empty @List Unit) Bullet
 `yuk___` State `he___` Transition `he` auto
 `ha__'he` Scope @(Focused Project) at
 `yok___'yokl` block_project (Empty @List Unit) Cursor
 `yuk___` State `he___` Transition `he` auto
 `ha__'he` Scope @(Shafted List Project) at
   `ho'he` Scope @(Forward List Project) at
 `yok___'yokl` block_project (Empty @List Unit) Bullet
 `yuk___` Console.input `yok__` Retry
  `ha___` match @Letter @ASCII
   `ho__` press `he` Lower K `he` (Move `ha` Down)
 `lo'ys'la` press `he` Lower J `he` (Move `ha` Lift)
 `lo'ys'la` press `he` Lower Q `he` (Quit)
 `lo'ys'la` press `he` Upper T `he` (Mark `ha` TODO)
 `lo'ys'la` press `he` Upper D `he` (Mark `ha` DONE)
     `la` Wrong `hv` is @(Number `ML` Symbol `ML` Caret)
 `yok___` State `ho` to `ha__` Transition `ha_` scroll `ho'ho` (`yui` Unit)
  `la___` State `ho` to `ha__` Transition `ha_` switch `ho'ho` (`yui` Unit)
  `ho_'ha'he` Scope @(Focused Project) at
   `ho'he'he` Scope @((Scrolling List `T'TT'I` Tree) Task) at
   `ho'he'he` Scope @(Focused `T'I` Tree Task) at
   `ho'he'he'he'he` Scope @Mark at
  `la___` Close `ho` to @Application
 `yok___` Again `ha` Once

start = Construct `ho` to @(Scrolling List)
 `ha____` Next `ha_` Tree `he` Task (TODO Unit) "Get ready for a Bangkok hackaton" `ho` to @(Scrolling Tree)
  `ha___` Next `he_` Node `he` Task (TODO Unit) "Purchase good round trip tickets" `he` Empty @List Unit
  `ha___` Next `he_` Node `he` Task (TODO Unit) "Book some room nearby Klong Toei" `he` Empty @List Unit
  `ha___` Next `he_` Node `he` Task (DONE Unit) "Can I take my longboard with me?" `he` Empty @List Unit
  `he___` Last `he_` Node `he` Task (DONE Unit) "Try to team up with ex coworkers" `he` Empty @List Unit
 `he____` Last `ha_` Tree `he` Task (TODO Unit) "Hang out with guys this Saturday" `ho` to @(Scrolling Tree)
  `ha___` Next `he_` Node `he` Task (TODO Unit) "Invite him, her, them and others" `he` Empty @List Unit
  `ha___` Next `he_` Node `he` Task (TODO Unit) "Clean the room, pick a boardgame" `he` Empty @List Unit
  `he___` Last `he_` Node `he` Task (DONE Unit) "Download Switch couch coop games" `he` Empty @List Unit

main = unwrap (draft `he'he` start)

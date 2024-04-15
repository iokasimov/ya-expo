import Ya

import "base" Data.Char (Char)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (IO, getChar, putStrLn, print)

import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII
import "ya-expo" Ya.Expo.Instances ()

import "ya-expo" Ya.Expo.Terminal as Terminal

type Status = () `ML` ()

pattern TODO = This () :: Status
pattern DONE = That () :: Status

type Task = Status `LM` List ASCII

pattern Task mark title = These mark title :: Task

type Bullet = () `ML` ()

pattern Bullet = This () :: Bullet
pattern Cursor = That () :: Bullet

line :: List ASCII -> Task -> IO ()
line prefix (Task status title) =
 prefix `yoklKL` output `o` Forwards
 `yi_yi_yukl` as @(List ASCII)
   `yiiiii` is "TODO " `rf` is "DONE " `yi` status
   `yoklKL` output `o` Forwards
 `yi_yi_yukl` title `yoklKL` output `o` Forwards
 `yi_yi_yukl` Newline `u` Signal `u` output

refresh = Terminal.prepare
     `yukl` Terminal.clear
     `yukl` Newline `u` Signal `u` output

render = as @(Scrolling List Task)
 `oooo` (`yoklKL` line "    " `o` Backwards)
 `cn_dp` (`yoklKL` line " -> ")
 `cn_dp` (`yoklKL` line "    " `o` Forwards)

handle :: Command -> State `TI` Scrolling List Task `TI` ()
handle = pass `a` State `aaa` scroll @List @Task
    `yi_rf` pass `a` State `aaa` switch
     `oo_a` part @Focused `o` has @Task `o` has @Status

type Command = Vertical `ML` Status

pattern Move v = This v :: Command
pattern Mark s = That s :: Command

keypress :: Char `ARR` Optional Command
keypress 'j' = Some `i` Move Up
keypress 'k' = Some `i` Move Down
keypress 'T' = Some `i` Mark TODO
keypress 'D' = Some `i` Mark DONE
keypress _ = None ()

main = forever `o` unwrap `o` unwrap
 `yi_yi_yi_yi` enter @(State `TI` Scrolling List Task `JT` IO)
   `yi_yukl` refresh
   `yi_yukl` review `u` State
   `yi_yokl` render
   `yi_yukl` until `yii` getChar `yo` keypress
   `yi_yokl` handle
 `yi_yi_yi_yi` transform `aaa` Construct `o` Nonempty @List
   `aaaaaa` Next `yi` Task TODO "Apply to that new position"
   `aaaaaa` Next `yi` Task TODO "Find a way to fix ligatures"
   `aaaaaa` Next `yi` Task TODO "Organize a boardgame session"
   `yiiiii` Last `yi` Task DONE "Buy a water gun for Songkran"

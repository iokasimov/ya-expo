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

line prefix (Task status title) =
 prefix `u` is @(List ASCII)
   `yoklKL` output `o` Fore
 `yi_yi_yukl` is @(List ASCII)
   `yiiiii` but "TODO " `rf` but "DONE " `yi` status
   `yoklKL` output `o` Fore
 `yi_yi_yukl` title `yoklKL` output `o` Fore
 `yi_yi_yukl` Newline `u` Signal `u` output

refresh = Terminal.prepare
     `yukl` Terminal.clear
     `yukl` Newline `u` Signal `u` output

render = is @(Scrolling List Task)
 `oooo` (`yoklKL` line " -> ")
 `cn_dp` ((`yoklKL` line "    " `o` Back)
 `cn_dp` (`yoklKL` line "    " `o` Fore))

handle :: Command -> State `TI` Scrolling List Task `TI` ()
handle = pass `a` State `aaa` scroll @List @Task
    `yi_rf` pass `a` State `aaa` switch `oo_a` sub @Focused `o'` has @Status

type Command = Vertical `ML` Status

pattern Move v = This v :: Command
pattern Mark s = That s :: Command

command :: ASCII `ARR` Optional Command
command (Letter (Lowercase J)) = Some `i` Move Up
command (Letter (Lowercase K)) = Some `i` Move Down
command (Letter (Uppercase T)) = Some `i` Mark TODO
command (Letter (Uppercase D)) = Some `i` Mark DONE
command _ = None ()

-- command :: ASCII `ARR` Optional Command
-- command = match @Letter `a_a` match @

main = forever `o` unwrap @Arrow `o` unwrap @Arrow
 `yi_yi_yi_yi` enter @(State `TI` Scrolling List Task `JT` IO)
   `yi_yukl` refresh
   `yi_yukl` review `u` State
   `yi_yokl` render
   `yi_yukl` input `yo` command `uuu` until
   `yi_yokl` handle
 `yi_yi_yi_yi` transform `aaa` Construct `o` Nonempty @List
   `aaaaa` Next `yi` Task TODO "Apply to that new position"
   `aaaaa` Next `yi` Task TODO "Find a way to fix ligatures"
   `aaaaa` Next `yi` Task TODO "Organize a boardgame session"
   `yiiiii` Last `yi` Task DONE "Buy a water gun for Songkran"

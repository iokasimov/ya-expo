import Ya

import "base" System.IO (IO)
import "ya-expo" Ya.Expo.Instances ()
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII

import "ya-expo" Ya.Expo.Terminal as Terminal

type Status = () `ML` ()

type Title = List ASCII

pattern TODO = This () :: Status
pattern DONE = That () :: Status

type Task = Status `LM` Title

type Command = Vertical `ML` Status

pattern Move v = This v :: Command
pattern Mark s = That s :: Command

line point status title =
 on @List point `yoklKL` Fore `a` output
 `yi_yi_yukl` but "TODO " `rf` but "DONE " `yi` status `uu` on @List
   `yoklKL` Fore `a` output
 `yi_yi_yukl` title `yoklKL` Fore `a` output
 `yi_yi_yukl` Newline `u` Signal `u` output

pressed k p =
 k `e` p `yui` () `yiu` ()

key x = on @Optional
 `yi_yi_yi` J `u` Lowercase `u` Letter `u` pressed x `u` Maybe
   `lm_ds` K `u` Lowercase `u` Letter `u` pressed x `u` Maybe
 `yi_lm_ds` T `u` Uppercase `u` Letter `u` pressed x `u` Maybe
   `lm_ds` D `u` Uppercase `u` Letter `u` pressed x `u` Maybe

initial = is @Task
 `yi_yi` TODO `lm` is @Title `i` "Apply to that new position"
 `yi_lm` DONE `lm` is @Title `i` "Find a way to fix ligatures"
 `yi_lm` TODO `lm` is @Title `i` "Organize a boardgame session"
 `yi_lm` DONE `lm` is @Title `i` "Buy a water gun for Songkran"

main = forever
 `yi_yi_yi` enter @(State `TI` Scrolling List Task `JT` IO)
   `yukl` Terminal.prepare `yukl` Terminal.clear
   `yukl` State `yii` review `aa` sub @(Situation List) `o'` rep Backwards
     `yokl_yoklKL` (line "  - " `j'`) `o` Back
   `yukl` State `yii` review `aa` sub @Focused
     `yokl_yoklKL` (line " -> " `j'`)
   `yukl` State `yii` review `aa` sub @(Situation List) `o'` rep Forwards
     `yokl_yoklKL` (line "  - " `j'`) `o` Fore
   `yukl` until `yii` input `yo` key
     `yokl` (pass `a` State `aaa` scroll @List @Task `aaa` Up `rf` Down)
       `rf` (pass `a` State `aaa` switch @Status `oo_a` sub @Only `o'` has)
 `yi_yi'_yi'` initial `u` as @(Nonempty List) `u` transform @(Scrolling List)

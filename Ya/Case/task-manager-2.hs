import Ya

import "base" System.IO (IO)
import "ya-expo" Ya.Expo.Instances ()
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII

import "ya-expo" Ya.Expo.Terminal as Terminal

type Task = List ASCII

line point title =
 on @List point `yoklKL` Fore `a` output
 `yi_yi_yukl` title `yoklKL` Fore `a` output
 `yi_yi_yukl` Newline `u` Signal `u` output

pressed k p =
 k `e` p `yui` () `yiu` ()

key x = on @Optional
 `yi_yi_yi` J `u` Lowercase `u` Letter `u` pressed x `u` Maybe
 `yi_lm_ds` K `u` Lowercase `u` Letter `u` pressed x `u` Maybe

initial = as @(Nonempty List) @Task
 `yii` is @Task "Apply to that new position"
  `lm` is @Task "Find a way to fix ligatures"
  `lm` is @Task "Organize a boardgame session"
  `lm` is @Task "Buy a water gun for Songkran"

main = forever
 `yi_yi_yi` enter @(State `TI` Scrolling List Task `JT` IO)
   `yukl` Terminal.prepare `yukl` Terminal.clear
   `yukl` State `yii` review `aa` sub @(Situation List) `o'` rep Backwards
     `yokl_yoklKL` line "  - " `o` Back
   `yukl` State `yii` review `aa` sub @Focused
     `yokl_yoklKL` line " -> "
   `yukl` State `yii` review `aa` sub @(Situation List) `o'` rep Forwards
     `yokl_yoklKL` line "  - " `o` Fore
   `yukl` until `yii` input `yo` key
     `yokl` State `a` scroll @List @Task `aaa` Up `rf` Down
 `yi_yi'_yi'` transform @(Scrolling List) initial

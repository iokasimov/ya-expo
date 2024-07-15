import Ya

import "base" System.IO (IO)
import "ya-expo" Ya.Expo.Instances ()
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.Terminal

type Task = List ASCII

initial = as @(Nonempty List) @Task
 `yii` is @Task "Apply to that new position"
  `lm` is @Task "Find a way to fix ligatures"
  `lm` is @Task "Organize a boardgame session"
  `lm` is @Task "Buy a water gun for Songkran"

main = initial
 `yoklKL` Fore @IO
 `aaaaa` (`yoklKL` Fore `a` output)
 `o_yukl` output (Signal Newline)

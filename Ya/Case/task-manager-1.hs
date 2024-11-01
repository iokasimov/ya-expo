import Ya

import "ya-expo" Ya.Expo.Instances ()
import "ya-ascii" Ya.ASCII

import qualified "ya-expo" Ya.Expo.Terminal as Terminal

import "base" System.IO (print)

type Task = List ASCII

-- example = is
 -- `li` is @Task "Apply to that new position"
 -- `lu` is @Task "Find a way to fix ligatures"
 -- `lu` is @Task "Organize a boardgame session"
 -- `lu` is @Task "Buy a water gun for Songkran"

main = print "typechecked"
-- main = as @(Nonempty List) @Task example
 -- `yokl` by @Fore
 -- `haaa` (`yokl` by @Fore `ha` Terminal.output)
 -- `ho'yuk` Terminal.output (Signal Newline)

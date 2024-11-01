import Ya

import "base" System.IO (IO, print)
import "ya-expo" Ya.Expo.Instances ()
import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII

import "ya-expo" Ya.Expo.Terminal as Terminal

type Task = List ASCII

-- line point title =
 -- (on @List point `yokl` way @Fore `ha` output)
 -- `yuk` (title `yokl` way @Fore `ha` output)
 -- `yuk` Newline `hu` Signal `hu` output

pressed k p =
 q (k `lu` p) `yui` () `yiu` ()

key x = is @(Optional _)
 `li__` (Maybe `ha` pressed x `he_` Lower `ho` Letter `he` J)
 `lu'ys` (Maybe `ha` pressed x `he_` Lower `ho` Letter `he` K)

-- init = as @(Nonempty List) @Task
 -- `lii` is @Task "Apply to that new position"
  -- `lu` is @Task "Find a way to fix ligatures"
  -- `lu` is @Task "Organize a boardgame session"
  -- `lu` is @Task "Buy a water gun for Songkran"

main = print "typechecked"
-- main = forever
 -- `yi'yi'yi` enter @(State `TI` Scrolling List Task `JNT` IO)
   -- `yuk` Terminal.prepare `yuk` Terminal.clear
   -- `yuk` State `yi` auto `hu` Transition `haa_` (has @(Shafted List Task) `hu` Attribute) `ho_` rep (Passed ())
     -- `yok'yokl` line "  - " `ho` way @Back
   -- `yuk` State `yi` auto `hu` Transition `haa_` (has @(Focused Task) `hu` Attribute)
     -- `yok'yokl` line " -> "
   -- `yuk` State `yi` auto `hu` Transition `haa_` (has @(Shafted List Task) `hu` Attribute) `ho_` rep (Future ())
     -- `yok'yokl` line "  - " `ho` way @Fore
   -- `yuk` until `yi` input `yo` key
     -- -- `yok` State `ha` scroll @List @Task `haaa` Up `rf` Down
 -- `__yiiiii` transform @(Scrolling List) init

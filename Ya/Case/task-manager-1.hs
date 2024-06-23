import Ya

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (putStrLn)
import "ya-expo" Ya.Expo.Instances ()

type Task = String

line :: Task `ARR` String
line title = " - " ++ title

main = as @(Nonempty List)
 `yiiiii` is @Task "Apply to that new position"
     `lm` is @Task "Find a way to fix ligatures"
     `lm` is @Task "Organize a boardgame session"
     `lm` is @Task "Buy a water gun for Songkran"
 `yoklKL` line `o` putStrLn `o` Fore

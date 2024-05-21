import Ya

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (IO, putStrLn)
import "ya-expo" Ya.Expo.Instances ()
import "ya-expo" Ya.Expo.Terminal as Terminal

type Task = String

line :: Task `ARR` String
line title = " - " ++ title

main = literal @(Nonempty List)
 `yiiiii` "Apply to that new position" `u` as @Task
     `lm` "Find a way to fix ligatures" `u` as @Task
     `lm` "Organize a boardgame session" `u` as @Task
     `lm` "Buy a water gun for Songkran" `u` as @Task
 `yoklKL` line `o` putStrLn `o` Fore

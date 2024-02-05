import Ya

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (IO, putStrLn)
import "ya-expo" Ya.Expo.Instances ()
import "ya-expo" Ya.Expo.Terminal as Terminal

type Task = String

line :: Task `ARR` String
line title = " - " ++ title

main = Nonempty @List
	`a` Next "Apply to that new position"
	`a` Next "Find a way to fix ligatures"
	`a` Next "Organize a boardgame session"
	`i` Last "Buy a water gun for Songkran"
	`yoklKL` line `o` putStrLn `o` Forwards

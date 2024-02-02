import Ya

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (IO, putStrLn)
import "ya-expo" Ya.Expo.Instances ()
import "ya-expo" Ya.Expo.Terminal as Terminal

type Task = String

line :: Task `ARR` String
line title = " - " ++ " " ++ title

main = enter @IO
	`yi_yi_yukl` Terminal.clear
	`yi_yi_yukl` Nonempty @List
		`aaaaaa` Next `yi` "Apply to that new position"
		`aaaaaa` Next `yi` "Find a way to fix ligatures"
		`aaaaaa` Next `yi` "Organize a boardgame session"
		`yiiiii` Last `yi` "Buy a water gun for Songkran"
		`yoklKL` line `o` putStrLn `o` Forwards

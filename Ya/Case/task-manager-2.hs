import Ya

import "base" Data.Char (Char)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (IO, getChar, putStrLn)
import "ya-expo" Ya.Expo.Instances ()
import "ya-expo" Ya.Expo.Terminal as Terminal

type Task = String

type Bullet = () `ML` ()

pattern Bullet = This () :: Bullet
pattern Cursor = That () :: Bullet

line :: Bullet `ARR` Task `ARR` String
line bullet title = is "  - " `rf` is " -> " `yi` bullet ++ title

keypress :: Char `ARR` Optional Vertical
keypress 'j' = Some Up
keypress 'k' = Some Down
keypress _ = None ()

main = forever `o` unwrap `o` unwrap
	`yi_yi_yi_yi` enter @(State `TI` Scrolling List Task `JT` IO)
		`yi_yukl` Terminal.prepare `yukl` Terminal.clear
		`yi_yukl` review `u` State @(Scrolling List Task)
		`yi_yokl` (`yoklKL` line Bullet `o` putStrLn `o` Backwards)
			`cn_dp` (`yoklKL` line Cursor `o` putStrLn)
			`cn_dp` (`yoklKL` line Bullet `o` putStrLn `o` Forwards)
		`yi_yukl` until `yii` getChar `yo` keypress
		`yi_yokl` pass `a` State `aaa` scroll @List @Task
	`yi_yi_yi_yi` transform `a` (Construct `o` Nonempty @List)
		`aaaaaa` Next `yi` "Apply to that new position"
		`aaaaaa` Next `yi` "Find a way to fix ligatures"
		`aaaaaa` Next `yi` "Organize a boardgame session"
		`yiiiii` Last `yi` "Buy a water gun for Songkran"

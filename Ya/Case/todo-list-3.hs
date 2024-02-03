import Ya

import "base" Data.Char (Char)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" System.IO (IO, getChar, putStrLn)
import "ya-expo" Ya.Expo.Instances ()
import "ya-expo" Ya.Expo.Terminal as Terminal

type Status = () `ML` ()

pattern TODO = This () :: Status
pattern DONE = That () :: Status

type Task = Status `LM` String

pattern Task mark title = These mark title :: Task

type Bullet = () `ML` ()

pattern Bullet = This () :: Bullet
pattern Cursor = That () :: Bullet

line :: Bullet -> Task `ARR` String
line bullet (These status title) =
	is "  - " `rf` is " -> " `yi` bullet ++ 
	is "TODO" `rf` is "DONE" `yi` status ++
	" " ++ title

type Command = Vertical `ML` Status

pattern Move v = This v :: Command
pattern Mark s = That s :: Command

keypress :: Char `ARR` Optional Command
keypress 'j' = Some `i` Move Up
keypress 'k' = Some `i` Move Down
keypress 'T' = Some `i` Mark TODO
keypress 'D' = Some `i` Mark DONE
keypress _ = None

main = forever `o` unwrap `o` unwrap
	`yi_yi_yi_yi` enter @(State `TI` Scrolling List Task `JT` IO)
		`yi_yukl` Terminal.prepare `yukl` Terminal.clear
		`yi_yukl` review `u` State @(Scrolling List Task)
		`yi_yokl` (`yoklKL` line Bullet `o` putStrLn `o` Backwards)
			`cn_dp` (`yoklKL` line Cursor `o` putStrLn)
			`cn_dp` (`yoklKL` line Bullet `o` putStrLn `o` Forwards)
		`yi_yukl` until `yii` getChar `yo` keypress
		`yi_yokl` pass `a` State `aaa` scroll @List @Task
			`yi_rf` pass `a` State `aaa` switch `oo_a` part @Focused `o` has @Task `o` has @Status
	`yi_yi_yi_yi` transform `a` Nonempty @List
		`aaaaaa` Next `yi` Task TODO "Apply to that new position"
		`aaaaaa` Next `yi` Task TODO "Find a way to fix ligatures"
		`aaaaaa` Next `yi` Task TODO "Organize a boardgame session"
		`yiiiii` Last `yi` Task DONE "Buy a water gun for Songkran"

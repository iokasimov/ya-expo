import Ya

import "base" Data.String (String)
import "base" System.IO (IO, print)
import "ya-expo" Ya.Expo.Instances ()
import "ya-expo" Ya.Expo.Terminal as Terminal

type Status = () `ML` ()
pattern TODO = This ()
pattern DONE = That ()

type Task = Status `LM` String

main = Terminal.prepare
	-- `yi_yukl` enter @(Statefully IO `TI` Scrolling List Task)
		`yukl` Terminal.clear
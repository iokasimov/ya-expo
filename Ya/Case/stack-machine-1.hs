import Ya
import Ya.Expo.Instances
import Ya.Expo.Terminal

import "base" Data.Int (Int)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (show)
import "base" System.IO (IO, print, putChar, putStr)
import Prelude ((+))

type Immediate v = v

type Operation v = v `LM` v `ARR` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v

pattern Operation x = That x :: Command v

load :: forall v . Immediate v `ARR` State `TI` List v `JT` Halts `TI` v
load v = enter @(State `TI` List v `JT` Halts)
	`yukl` push @List v `u` State

eval :: forall v . Operation v `ARR` State `TI` List v `JT` Halts `TI` v
eval op = enter @(State `TI` List v `JT` Halts)
	`yukl` pop @List `u` State `u` try
	`lm_dp` pop @List `u` State `u` try
	`yokl` op `o` push @List `o` State

main = Nonempty @List
	`aaa` Next (Immediate 1)
	`aaa` Next (Immediate 2)
	`aaa` Next (Operation ((+) `j_`))
	`aaa` Next (Immediate 4)
	`yii` Last (Operation ((+) `j_`))
	`yi_yoklKL` Forwards `aaa` load `rf` eval
	`u_u_u_u_u_u_u_u` unwrap `o` unwrap
	`yi_yi_yi_yi` Empty @List
	`u_u_u_u_u_u_u_u` is "Not enough operands!" `o` print
		`yi_yi_rf` pass `aaa` unwrap `o` that
			`oo_yoklKL` show `o` putStr
				`o_yukl` putChar ',' `o` Forwards

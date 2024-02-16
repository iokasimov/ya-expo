import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (show)
import "base" Data.Eq (Eq ((==), (/=)))
import "base" System.IO (print)

type Enclosed = Shape `LM` Shape

type Imbalance = Bracket `ML` Enclosed

pattern Missing x = This x :: Imbalance
pattern Mismatch x = That x :: Imbalance

remember bracket = enter
	@(State (List Shape) `JT` Error Imbalance)
	`yukl` push @List bracket `u` State

analyze bracket = enter
	@(State `TI` List Shape `JT` Error Imbalance)
	`yi_yukl` pop @List `u` State
	`yi_yokl` Error `a` Missing `a` Closed `a` is bracket
		`yi_rf` Error `a` Mismatch `rf` Ok `aaa` (`e` bracket)

main = List `a` Next (Opened Angle) `i` Last (Closed Square)
	`yoklKL` Forwards `aaa` remember `rf` analyze
	`rwwwww_rw` Empty @List
	`yi_yokl` Ok `rf` Error `a` Missing `a` Opened `a` inspect top `cn_dp` Ok
	`u_u_u_u_u_u` print `a` is "[ERROR] Lonely bracket"
		`yi_rf` print `a` is "[ERROR] Mismatching brackets"
		`yi_rf` print `a` is "[OKAY] Brackets are balanced"

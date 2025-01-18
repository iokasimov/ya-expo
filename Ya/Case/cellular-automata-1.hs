import Ya
import Ya.World
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (show)
import "base" Data.Eq (Eq ((==), (/=)))
import "base" System.IO (print)

type Cell = () `ML` ()
pattern Dead = This ()
pattern Alive = That ()

start :: Scrolling List Cell
start = transform `haaa` Construct `ho` Nonempty @List `liii` Last Alive

-- sierpinski :: Scrolling List Cell
-- sierpinski = part @List `cn` part @Focused `cn` part @List

main = print "typechecked"

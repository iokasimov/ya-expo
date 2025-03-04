import Ya
import Ya.World
import Ya.ASCII
import Ya.Console

type Tile = Unit `S` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Nail = Unit `S` Unit

pattern Bang i = This i
pattern Sunk i = That i

type Shot = Nail `S` Unit

pattern Nail i = This i
pattern Miss i = That i

type Ship = Nonempty List Unit

submarine = Nonempty @List
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Last

destroyer = Nonempty @List
 `ha` Item Unit `ha` Next
 `ha` Item Unit `ha` Last

fleet = Nonempty @List @Ship
 `ha_` Item `hv` by submarine `ha` Next
 `ha_` Item `hv` by destroyer `ha` Last

title = is @(List ASCII) "SHIPS: " `yokl` Forth `ha` World `ha` output

print x = x `yokl_` Forth `ha` World `ha___` is @Ship
 `ho__'yukl` Forth `ha` World `ha` output `ha` Glyph `ha` Symbol `ha` Punctuate `hv` by Hash
 `ho__'yuk` World `ha` output `ha` Caret `hv` by Space

main = enter @World
 `yuk__` World `hv` title
 `yuk__` World `ha` print `hv` by fleet

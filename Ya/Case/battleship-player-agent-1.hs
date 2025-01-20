import Ya
import Ya.World
import Ya.ASCII
import Ya.Console

type Tile = Unit `ML` Unit

pattern Idle = This Unit
pattern Ship = That Unit

type Nail = Unit `ML` Unit

pattern Bang i = This i
pattern Sunk i = That i

type Shot = Nail `ML` Unit

pattern Nail i = This i
pattern Miss i = That i

type Ship = Nonempty List Unit

fleet = Nonempty @List @Ship
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Maybe `ha` Next
  `ha` Item Unit `ha` Maybe `ha` Next
  `ha` Item Unit `ha` Maybe `hv` Last
 `ha_` Maybe `ha_` Next
 `ha_` Item `ha` Nonempty @List
  `ha` Item Unit `ha` Maybe `ha` Next
  `ha` Item Unit `ha` Maybe `hv` Last
 `ha_` Maybe `hv_` Last

title = is @(List ASCII) "SHIPS: " `yokl` Forth `ha` World `ha` output

print x = x `yokl_` Forth `ha` World `ha___` is @Ship
 `ho__'yukl` Forth `ha` World `ha` output `ha` Glyph `ha` Symbol `ha` Punctuate `hv` by Hash
 `ho__'yuk` World `ha` output `ha` Caret `hv` by Space

main = enter @World
 `yuk__` World `hv` title
 `yuk__` World `hv` print fleet
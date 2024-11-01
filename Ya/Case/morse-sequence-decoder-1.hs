import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" System.IO (IO, print)

-- morse_code_tree = Binary
 -- `yiiiiiiii`(Some `ha` Root E `ha` Binary
  -- `yiiiiii` Some `ha` Node I `ha` Binary
    -- `yiiii` Some `ha` Node S `ha` Binary
      -- `yii` (Some `yi` leaf H)
       -- `lu` (Some `yi` leaf V)
     -- `yi'lu` Some `ha` Node U `ha` Binary
      -- `yii` (Some `yi` leaf F)
       -- `lu` None ()
   -- `yi'yi'lu` Some `ha` Node A `ha` Binary
    -- `yiiii` Some `ha` Node R `ha` Binary
      -- `yii` (Some `yi` leaf L)
       -- `lu` None ()
     -- `yi'lu` Some `ha` Node W `ha` Binary
      -- `yii` (Some `yi` leaf P)
       -- `lu` (Some `yi` leaf J))
 -- `yi'yi'yi'lu` (Some `ha` Root T `ha` Binary
  -- `yiiiiii` Some `ha` Node N `ha` Binary
    -- `yiiii` Some `ha` Node D `ha` Binary
      -- `yii` (Some `yi` leaf B)
       -- `lu` (Some `yi` leaf X)
     -- `yi'lu` Some `ha` Node K `ha` Binary
      -- `yii` (Some `yi` leaf C)
       -- `lu` (Some `yi` leaf Y)
   -- `yi'yi'lu` (Some `ha` Node M `ha` Binary
    -- `yiiii` Some `ha` Node G `ha` Binary
     -- `yiii` (Some `yi` leaf Z)
       -- `lu` (Some `yi` leaf Q)
     -- `yi'lu` (Some `yi` leaf O)))

type Morse = () `ML` ()

pattern Dot e = This e :: Morse
pattern Dash e = That e :: Morse

type Table = Supertype (Forest (Binary Tree) Latin)

-- TODO: now I understand what I should do
-- ..... I need to use `find` method of `Dict` class

-- TODO: make it working
-- main = morse_code_tree `yokl'yokl` Fore `ha` print

-- jump x = review `haa`rep (unwrap x) `ho` State

-- trim t = (sub `yi_` t `huuuu` this)
 -- `hu` but `hu` switch `hu` Transition `hu` State
 -- `yu` (top `yi_` t `huuuu` this)

-- main = Dot () `lu` Dash () `lu` Dot () `huuu` as @(Nonempty List) @Morse
 -- `yokl` way @Fore @(State Table `JT` Halts)
 -- `haaaaa` intro `ho'yokl` jump `ho'yokl` on @Halts `ho'yokl` trim
 -- `yiiiz'yiz` morse_code_tree
 -- `huuuuuu`but "[ERROR] Letter was not found!"
     -- `rfz` that `hoz'yo` (Letter `ha` Upper)
 -- `yokl` way @Fore `ha` output

main = print "typechecked"

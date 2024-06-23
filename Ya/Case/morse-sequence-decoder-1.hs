import Ya
import Ya.ASCII
import Ya.Expo.Instances ()
import Ya.Expo.ASCII
import Ya.Expo.Terminal

import "base" System.IO (IO, print)

morse_code_tree = Binary
 `yiiiiiiii`Some `a` Root E `a` Binary
  `yiiiiii` Some `a` Node I `a` Binary
    `yiiii` Some `a` Node S `a` Binary
      `yii` Some `i` leaf H
       `lm` Some `i` leaf V
     `yi_lm` Some `a` Node U `a` Binary
      `yii` Some `i` leaf F
       `lm` None ()
   `yi_yi_lm` Some `a` Node A `a` Binary
    `yiiii` Some `a` Node R `a` Binary
      `yii` Some `i` leaf L
       `lm` None ()
     `yi_lm` Some `a` Node W `a` Binary
      `yii` Some `i` leaf P
       `lm` Some `i` leaf J
 `yi_yi_yi_lm` Some `a` Root T `a` Binary
  `yiiiiii` Some `a` Node N `a` Binary
    `yiiii` Some `a` Node D `a` Binary
      `yii` Some `i` leaf B
       `lm` Some `i` leaf X
     `yi_lm` Some `a` Node K `a` Binary
      `yii` Some `i` leaf C
       `lm` Some `i` leaf Y
   `yi_yi_lm` Some `a` Node M `a` Binary
    `yiiii` Some `a` Node G `a` Binary
     `yiii` Some `i` leaf Z
       `lm` Some `i` leaf Q
     `yi_lm` Some `i` leaf O

type Morse = () `ML` ()

pattern Dot e = This e :: Morse
pattern Dash e = That e :: Morse

type Table = U_I_I LM `T_TT_I` Optional `TI` Binary Tree Latin

-- TODO: now I understand what I should do
-- ..... I need to use `find` method of `Dict` class

-- TODO: make it working
-- main = morse_code_tree `yoklKL_yoklKL` Fore `a` print

jump = review `a_a'` rep `o` State @Table

trim t = inspect subs t
 `u` switch `u` State @Table
 `yu` inspect top t

main = Dot () `lm` Dash () `lm` Dot () `uuu` as @(Nonempty List)
 `yoklKL` Fore @(State Table `JT` Halts)
 `aaaaa` intro `o_yokl` jump `o_yokl` on @Halts `o_yokl` trim
 `yiii'_yi'` morse_code_tree
 `uuuuuu` but "[ERROR] Letter was not found!"
     `rf` that `o'_yo` (Letter `a` Uppercase)
 `yoklKL` Fore `a` output

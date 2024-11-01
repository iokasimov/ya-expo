import Ya
import Ya.ASCII
import Ya.Expo.ASCII
import Ya.Expo.Instances
import Ya.Expo.Terminal

import "base" Data.Int (Int)
import "base" Data.String (String)
import "base" Data.List ((++))
import "base" Text.Show (Show (show))
import "base" System.IO (IO, print, putChar, putStr)
import Prelude ((+))

type Immediate v = v

type Operation v = v `LM` v `ARR` v

type Command v = Immediate v `ML` Operation v

pattern Immediate x = This x :: Command v

pattern Operation x = That x :: Command v

type Processing v = State `TI` List v `JT` Halts `TI` v

main = print "typechecked"

-- main = (Nonempty @List `ha` Construct
--  `ha` Next (Immediate 1)
--  `ha` Next (Immediate 2)
--  `ha` Next (Operation ((+) `j'`))
--  `ha` Next (Immediate 4)
--  `i` Last (Operation ((+) `j'`))
--  `yi'yokl` way @Fore @(State `TI` List Int `JT` Halts)
--   `haaaaaaa` intro @Int `hoo'yok` push @List `ho` State @(List Int)
--    `yi'yi'rf` pop @List `hu` State `hu` try
--      `lu'dp` pop @List `hu` State `hu` try
--      `yokl'a` push @List `ho` State @(List Int)
--   ) `yiiiz'_yi` Empty @List ()
--   `huuuuuu` (unwrap @Arrow `hoooo`
--     but "[ERROR] No operands!" `ho` putStr
--     `yi'rf` pass `haaa` but "[OK] Traced: " `ho` putStr)
--     `cn'dp` (`yokl` Fore `haaa` show `ho` putStr `ho'yuk` putChar ' ')

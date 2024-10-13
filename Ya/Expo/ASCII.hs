module Ya.Expo.ASCII where

import Ya
import Ya.ASCII

import "base" Data.Char (Char)
import "base" Data.String (IsString (fromString))
import "base" GHC.Err (error)
import "base" GHC.IsList (IsList (Item, toList, fromList))
import "base" GHC.Integer (Integer)
import "base" System.IO (IO, getChar)
import "base" Text.Show (show)

caret_to_char :: Caret -> Char
caret_to_char = but '\BS' `la` but '\HT' `la` but '\LF' `la` but '\ESC' `la` but '\SP' `la` but '\DEL'

bracket_to_char :: Bracket -> Char
bracket_to_char = but '(' `la` but '{' `la` but '<' `la` but '['
            `laa` but ')' `la` but '}' `la` but '>' `la` but ']'

punctuation_to_char :: Punctuation -> Char
punctuation_to_char = but '\"' `la` but '\'' `la` but '#' `la` but '-' `la` but '@'
 `la` but '^' `la` but '_' `la` but '`' `la` but '|' `la` but '~'
 `la` but '+' `la` but '*' `la` but '%' `la` but '&' `la` but '$' `la` but '\\' `la` but '/'
 `la` but '.' `la` but ',' `la` but ';' `la` but ':' `la` but '!' `la` but '?'

upper_latin_to_char :: Latin -> Char
upper_latin_to_char = but 'A' `la` but 'B' `la` but 'C' `la` but 'D' `la` but 'E' `la` but 'F'
 `la` but 'G' `la` but 'H' `la` but 'I' `la` but 'J' `la` but 'K' `la` but 'L'
 `la` but 'M' `la` but 'N' `la` but 'O' `la` but 'P' `la` but 'Q' `la` but 'R'
 `la` but 'S' `la` but 'T' `la` but 'U' `la` but 'V' `la` but 'W' `la` but 'X'
 `la` but 'Y' `la` but 'Z'

lower_latin_to_char :: Latin -> Char
lower_latin_to_char = but 'a' `la` but 'b' `la` but 'c' `la` but 'd' `la` but 'e' `la` but 'f'
 `la` but 'g' `la` but 'h' `la` but 'i' `la` but 'j' `la` but 'k' `la` but 'l'
 `la` but 'm' `la` but 'n' `la` but 'o' `la` but 'p' `la` but 'q' `la` but 'r'
 `la` but 's' `la` but 't' `la` but 'u' `la` but 'v' `la` but 'w' `la` but 'x'
 `la` but 'y' `la` but 'z'

digit_to_char :: Number -> Char
digit_to_char = but '0' `la` but '1' `la` but '2' `la` but '3' `la` but '4' `la` but '5' `la` but '6' `la` but '7' `la` but '8' `la` but '9'

ascii_to_char :: ASCII -> Char
ascii_to_char = is
  `li` lower_latin_to_char
  `la` upper_latin_to_char
 `laa` digit_to_char
 `laa` bracket_to_char
  `la` punctuation_to_char
 `laa` caret_to_char

char_to_ascii :: Char -> ASCII
char_to_ascii = \case
	'\BS' -> Caret Backspace
	'\HT' -> Caret Tab
	'\LF' -> Caret Newline
	'\ESC' -> Caret Escape
	'\SP' -> Caret Space
	'\DEL' -> Caret Delete
	'/' -> Glyph `ha` Symbol `ha` Punctuation `ha` Back `ha` Slash `he` ()
	'\\' -> Glyph `ha` Symbol `ha` Punctuation `ha` Slash `he` ()
	'(' -> Glyph `ha` Symbol `ha` Bracket `ha` Opened `li` Round
	')' -> Glyph `ha` Symbol `ha` Bracket `ha` Closed `li` Round
	'{' -> Glyph `ha` Symbol `ha` Bracket `ha` Opened `li` Curly
	'}' -> Glyph `ha` Symbol `ha` Bracket `ha` Closed `li` Curly
	'<' -> Glyph `ha` Symbol `ha` Bracket `ha` Opened `li` Angle
	'>' -> Glyph `ha` Symbol `ha` Bracket `ha` Closed `li` Angle
	'[' -> Glyph `ha` Symbol `ha` Bracket `ha` Opened `li` Square
	']' -> Glyph `ha` Symbol `ha` Bracket `ha` Closed `li` Square
	'"' -> Glyph `ha` Symbol `ha` Punctuation `ha` Doublequote `he` ()
	'\'' -> Glyph `ha` Symbol `ha` Punctuation `ha` Singlequote `he` ()
	'.' -> Glyph `ha` Symbol `ha` Punctuation `ha` Period `he` ()
	',' -> Glyph `ha` Symbol `ha` Punctuation `ha` Comma `he` ()
	';' -> Glyph `ha` Symbol `ha` Punctuation `ha` Semicolon `he` ()
	':' -> Glyph `ha` Symbol `ha` Punctuation `ha` Colon `he` ()
	'!' -> Glyph `ha` Symbol `ha` Punctuation `ha` Exclam `he` ()
	'?' -> Glyph `ha` Symbol `ha` Punctuation `ha` Question `he` ()
	'#' -> Glyph `ha` Symbol `ha` Punctuation `ha` Hash `he` ()
	'$' -> Glyph `ha` Symbol `ha` Punctuation `ha` Dollar `he` ()
	'%' -> Glyph `ha` Symbol `ha` Punctuation `ha` Percent `he` ()
	'&' -> Glyph `ha` Symbol `ha` Punctuation `ha` Ampersand `he` ()
	'*' -> Glyph `ha` Symbol `ha` Punctuation `ha` Asterisk `he` ()
	'+' -> Glyph `ha` Symbol `ha` Punctuation `ha` Plus `he` ()
	'-' -> Glyph `ha` Symbol `ha` Punctuation `ha` Hyphen `he` ()
	'@' -> Glyph `ha` Symbol `ha` Punctuation `ha` At `he` ()
	'^' -> Glyph `ha` Symbol `ha` Punctuation `ha` Circumflex `he` ()
	'_' -> Glyph `ha` Symbol `ha` Punctuation `ha` Underscore `he` ()
	'`' -> Glyph `ha` Symbol `ha` Punctuation `ha` Grave `he` ()
	'|' -> Glyph `ha` Symbol `ha` Punctuation `ha` Bar `he` ()
	'~' -> Glyph `ha` Symbol `ha` Punctuation `ha` Tilde `he` ()
	'A' -> Glyph `ha` Letter `ha` Upper `li`A
	'B' -> Glyph `ha` Letter `ha` Upper `li`B
	'C' -> Glyph `ha` Letter `ha` Upper `li`C
	'D' -> Glyph `ha` Letter `ha` Upper `li`D
	'E' -> Glyph `ha` Letter `ha` Upper `li`E
	'F' -> Glyph `ha` Letter `ha` Upper `li`F
	'G' -> Glyph `ha` Letter `ha` Upper `li`G
	'H' -> Glyph `ha` Letter `ha` Upper `li`H
	'I' -> Glyph `ha` Letter `ha` Upper `li`I
	'J' -> Glyph `ha` Letter `ha` Upper `li`J
	'K' -> Glyph `ha` Letter `ha` Upper `li`K
	'L' -> Glyph `ha` Letter `ha` Upper `li`L
	'M' -> Glyph `ha` Letter `ha` Upper `li`M
	'N' -> Glyph `ha` Letter `ha` Upper `li`N
	'O' -> Glyph `ha` Letter `ha` Upper `li`O
	'P' -> Glyph `ha` Letter `ha` Upper `li`P
	'Q' -> Glyph `ha` Letter `ha` Upper `li`Q
	'R' -> Glyph `ha` Letter `ha` Upper `li`R
	'S' -> Glyph `ha` Letter `ha` Upper `li`S
	'T' -> Glyph `ha` Letter `ha` Upper `li`T
	'U' -> Glyph `ha` Letter `ha` Upper `li`U
	'V' -> Glyph `ha` Letter `ha` Upper `li`V
	'W' -> Glyph `ha` Letter `ha` Upper `li`W
	'X' -> Glyph `ha` Letter `ha` Upper `li`X
	'Y' -> Glyph `ha` Letter `ha` Upper `li`Y
	'Z' -> Glyph `ha` Letter `ha` Upper `li`Z
	'a' -> Glyph `ha` Letter `ha` Lower `li`A
	'b' -> Glyph `ha` Letter `ha` Lower `li`B
	'c' -> Glyph `ha` Letter `ha` Lower `li`C
	'd' -> Glyph `ha` Letter `ha` Lower `li`D
	'e' -> Glyph `ha` Letter `ha` Lower `li`E
	'f' -> Glyph `ha` Letter `ha` Lower `li`F
	'g' -> Glyph `ha` Letter `ha` Lower `li`G
	'h' -> Glyph `ha` Letter `ha` Lower `li`H
	'i' -> Glyph `ha` Letter `ha` Lower `li`I
	'j' -> Glyph `ha` Letter `ha` Lower `li`J
	'k' -> Glyph `ha` Letter `ha` Lower `li`K
	'l' -> Glyph `ha` Letter `ha` Lower `li`L
	'm' -> Glyph `ha` Letter `ha` Lower `li`M
	'n' -> Glyph `ha` Letter `ha` Lower `li`N
	'o' -> Glyph `ha` Letter `ha` Lower `li`O
	'p' -> Glyph `ha` Letter `ha` Lower `li`P
	'q' -> Glyph `ha` Letter `ha` Lower `li`Q
	'r' -> Glyph `ha` Letter `ha` Lower `li`R
	's' -> Glyph `ha` Letter `ha` Lower `li`S
	't' -> Glyph `ha` Letter `ha` Lower `li`T
	'u' -> Glyph `ha` Letter `ha` Lower `li`U
	'v' -> Glyph `ha` Letter `ha` Lower `li`V
	'w' -> Glyph `ha` Letter `ha` Lower `li`W
	'x' -> Glyph `ha` Letter `ha` Lower `li`X
	'y' -> Glyph `ha` Letter `ha` Lower `li`Y
	'z' -> Glyph `ha` Letter `ha` Lower `li`Z
	'0' -> Glyph `ha` Number `ha` Zero `he` ()
	'1' -> Glyph `ha` Number `ha` One `he` ()
	'2' -> Glyph `ha` Number `ha` Two `he` ()
	'3' -> Glyph `ha` Number `ha` Three `he` ()
	'4' -> Glyph `ha` Number `ha` Four `he` ()
	'5' -> Glyph `ha` Number `ha` Five `he` ()
	'6' -> Glyph `ha` Number `ha` Six `he` ()
	'7' -> Glyph `ha` Number `ha` Seven `he` ()
	'8' -> Glyph `ha` Number `ha` Eight `he` ()
	'9' -> Glyph `ha` Number `ha` Nine `he` ()
	_ -> error "Not ASCII!"

instance IsString (List Char) where
 fromString x = T_TT_I (Some (Construct (worker x))) where
  worker (c : []) = Last c
  worker (c : cs) = Next c (worker cs)

-- char_to_ascii_with_error :: Char -> ASCII
-- char_to_ascii_with_error x =
	-- (error ('\'' : x : '\'' : " - is not ASCII") `hs` i)
	-- (char_to_ascii x)

instance IsString (List ASCII) where
 fromString x = T_TT_I (Some (Construct (worker x))) where
  worker (c : []) = Last (char_to_ascii c)
  worker (c : cs) = Next (char_to_ascii c) (worker cs)

-- instance IsString (List Latin) where

instance IsString (Construction Optional ASCII) where
 fromString x = Construct (worker x) where
  worker (c : []) = Last (char_to_ascii c)
  worker (c : cs) = Next (char_to_ascii c) (worker cs)

instance IsList (Construction Optional item) where
 type Item (Construction Optional item) = item
 fromList x = Construct (worker x) where
  worker (c : []) = Last c
  worker (c : cs) = Next c (worker cs)

-- instance IsList (Construction Optional item) where
 -- type Item (Construction Optional item) = item
 -- fromList x = Construct (worker x) where
  -- worker (c : []) = Last c
  -- worker (c : cs) = Next c (worker cs)

integer :: Integer -> Nonempty List ASCII
integer = show `ho` fromList `ho'yo` char_to_ascii

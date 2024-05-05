module Ya.Expo.ASCII where

import Ya
import Ya.ASCII

import "base" Data.Char (Char)
import "base" Data.String (IsString (fromString))
import "base" GHC.Err (error)
import "base" System.IO (IO, getChar)

char :: ASCII -> Char
char = is '\BS' `rf` is '\HT' `rf` is '\LF' `rf` is '\ESC' `rf` is '\SP' `rf` is '\DEL'
	`yi_yi_rf` is '/' `rf` is '\\'
	  `yi_rf` (is '(' `rf` is '{' `rf` is '<' `rf` is '['
		`yi_rf` is ')' `rf` is '}' `rf` is '>' `rf` is ']')
		`yi_rf` is '\"' `rf` is '\'' `rf` is '.'
			`rf` is ',' `rf` is ';' `rf` is ':' `rf` is '!' `rf` is '?'
		`yi_rf` is '#' `rf` is '$' `rf` is '%' `rf` is '&'
			`rf` is '*' `rf` is '+' `rf` is '-' `rf` is '@'
			`rf` is '^' `rf` is '_' `rf` is '`' `rf` is '|' `rf` is '~'
	`yi_yi_rf` is 'A' `rf` is 'B' `rf` is 'C' `rf` is 'D' `rf` is 'E' `rf` is 'F'
			`rf` is 'G' `rf` is 'H' `rf` is 'I' `rf` is 'J' `rf` is 'K' `rf` is 'L'
			`rf` is 'M' `rf` is 'N' `rf` is 'O' `rf` is 'P' `rf` is 'Q' `rf` is 'R'
			`rf` is 'S' `rf` is 'T' `rf` is 'U' `rf` is 'V' `rf` is 'W' `rf` is 'X'
			`rf` is 'Y' `rf` is 'Z'
		`yi_rf` is 'a' `rf` is 'b' `rf` is 'c' `rf` is 'd' `rf` is 'e' `rf` is 'f'
			`rf` is 'g' `rf` is 'h' `rf` is 'i' `rf` is 'j' `rf` is 'k' `rf` is 'l'
			`rf` is 'm' `rf` is 'n' `rf` is 'o' `rf` is 'p' `rf` is 'q' `rf` is 'r'
			`rf` is 's' `rf` is 't' `rf` is 'u' `rf` is 'v' `rf` is 'w' `rf` is 'x'
			`rf` is 'y' `rf` is 'z'
	`yi_yi_rf` is '0' `rf` is '1' `rf` is '2' `rf` is '3' `rf` is '4'
			`rf` is '5' `rf` is '6' `rf` is '7' `rf` is '8' `rf` is '9'

char_to_ascii :: Char -> ASCII
char_to_ascii = \case
	'\BS' -> Signal Backspace
	'\HT' -> Signal Tab
	'\LF' -> Signal Newline
	'\ESC' -> Signal Escape
	'\SP' -> Signal Space
	'\DEL' -> Signal Delete
	'/' -> Symbol `a` Slashes `i` This ()
	'\\' -> Symbol `a` Slashes `i` That ()
	'(' -> Symbol `a` Bracket `a` Opened `i` Round
	')' -> Symbol `a` Bracket `a` Closed `i` Round
	'{' -> Symbol `a` Bracket `a` Opened `i` Curly
	'}' -> Symbol `a` Bracket `a` Closed `i` Curly
	'<' -> Symbol `a` Bracket `a` Opened `i` Angle
	'>' -> Symbol `a` Bracket `a` Closed `i` Angle
	'[' -> Symbol `a` Bracket `a` Opened `i` Square
	']' -> Symbol `a` Bracket `a` Closed `i` Square
	'"' -> Symbol `a` Punctuation `i` Doublequote
	'\'' -> Symbol `a` Punctuation `i` Singlequote
	'.' -> Symbol `a` Punctuation `i` Period
	',' -> Symbol `a` Punctuation `i` Comma
	';' -> Symbol `a` Punctuation `i` Semicolon
	':' -> Symbol `a` Punctuation `i` Colon
	'!' -> Symbol `a` Punctuation `i` Exclamation
	'?' -> Symbol `a` Punctuation `i` Question
	'#' -> Symbol `a` Miscellanneous `i` Hash
	'$' -> Symbol `a` Miscellanneous `i` Dollar
	'%' -> Symbol `a` Miscellanneous `i` Percent
	'&' -> Symbol `a` Miscellanneous `i` Ampersand
	'*' -> Symbol `a` Miscellanneous `i` Asterisk
	'+' -> Symbol `a` Miscellanneous `i` Plus
	'-' -> Symbol `a` Miscellanneous `i` Hyphen
	'@' -> Symbol `a` Miscellanneous `i` At
	'^' -> Symbol `a` Miscellanneous `i` Caret
	'_' -> Symbol `a` Miscellanneous `i` Underscore
	'`' -> Symbol `a` Miscellanneous `i` Grave
	'|' -> Symbol `a` Miscellanneous `i` Bar
	'~' -> Symbol `a` Miscellanneous `i` Tilde
	'A' -> Letter `a` Uppercase `i`A
	'B' -> Letter `a` Uppercase `i`B
	'C' -> Letter `a` Uppercase `i`C
	'D' -> Letter `a` Uppercase `i`D
	'E' -> Letter `a` Uppercase `i`E
	'F' -> Letter `a` Uppercase `i`F
	'G' -> Letter `a` Uppercase `i`G
	'H' -> Letter `a` Uppercase `i`H
	'I' -> Letter `a` Uppercase `i`I
	'J' -> Letter `a` Uppercase `i`J
	'K' -> Letter `a` Uppercase `i`K
	'L' -> Letter `a` Uppercase `i`L
	'M' -> Letter `a` Uppercase `i`M
	'N' -> Letter `a` Uppercase `i`N
	'O' -> Letter `a` Uppercase `i`O
	'P' -> Letter `a` Uppercase `i`P
	'Q' -> Letter `a` Uppercase `i`Q
	'R' -> Letter `a` Uppercase `i`R
	'S' -> Letter `a` Uppercase `i`S
	'T' -> Letter `a` Uppercase `i`T
	'U' -> Letter `a` Uppercase `i`U
	'V' -> Letter `a` Uppercase `i`V
	'W' -> Letter `a` Uppercase `i`W
	'X' -> Letter `a` Uppercase `i`X
	'Y' -> Letter `a` Uppercase `i`Y
	'Z' -> Letter `a` Uppercase `i`Z
	'a' -> Letter `a` Lowercase `i`A
	'b' -> Letter `a` Lowercase `i`B
	'c' -> Letter `a` Lowercase `i`C
	'd' -> Letter `a` Lowercase `i`D
	'e' -> Letter `a` Lowercase `i`E
	'f' -> Letter `a` Lowercase `i`F
	'g' -> Letter `a` Lowercase `i`G
	'h' -> Letter `a` Lowercase `i`H
	'i' -> Letter `a` Lowercase `i`I
	'j' -> Letter `a` Lowercase `i`J
	'k' -> Letter `a` Lowercase `i`K
	'l' -> Letter `a` Lowercase `i`L
	'm' -> Letter `a` Lowercase `i`M
	'n' -> Letter `a` Lowercase `i`N
	'o' -> Letter `a` Lowercase `i`O
	'p' -> Letter `a` Lowercase `i`P
	'q' -> Letter `a` Lowercase `i`Q
	'r' -> Letter `a` Lowercase `i`R
	's' -> Letter `a` Lowercase `i`S
	't' -> Letter `a` Lowercase `i`T
	'u' -> Letter `a` Lowercase `i`U
	'v' -> Letter `a` Lowercase `i`V
	'w' -> Letter `a` Lowercase `i`W
	'x' -> Letter `a` Lowercase `i`X
	'y' -> Letter `a` Lowercase `i`Y
	'z' -> Letter `a` Lowercase `i`Z
	'0' -> Number `i` D0
	'1' -> Number `i` D1
	'2' -> Number `i` D2
	'3' -> Number `i` D3
	'4' -> Number `i` D4
	'5' -> Number `i` D5
	'6' -> Number `i` D6
	'7' -> Number `i` D7
	'8' -> Number `i` D8
	'9' -> Number `i` D9
	_ -> error "Not ASCII!"

instance IsString (List Char) where
 fromString x = T_TT_I (Some (Construct (worker x))) where
  worker (c : []) = Last c
  worker (c : cs) = Next c (worker cs)

-- char_to_ascii_with_error :: Char -> ASCII
-- char_to_ascii_with_error x =
	-- (error ('\'' : x : '\'' : " - is not ASCII") `rf` i)
	-- (char_to_ascii x)

instance IsString (List ASCII) where
 fromString x = T_TT_I (Some (Construct (worker x))) where
  worker (c : []) = Last (char_to_ascii c)
  worker (c : cs) = Next (char_to_ascii c) (worker cs)

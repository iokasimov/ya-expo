module Ya.Expo.ASCII where

import Ya
import Ya.ASCII

import "base" Data.Char (Char)
import "base" Data.String (IsString (fromString))
import "base" GHC.Err (error)
import "base" System.IO (IO, getChar)

char :: ASCII -> Char
char = is '\BS' `rf` is '\HT' `rf` is '\LF' `rf` is '\ESC' `rf` is '\SP' `rf` is '\DEL'
	`yi_yi_rf` is '(' `rf` is '{' `rf` is '<' `rf` is '['
		`yi_rf` is ')' `rf` is '}' `rf` is '>' `rf` is ']'
		`yi_rf` is '/' `rf` is '\\' `rf` is '\"' `rf` is '\'' `rf` is '.'
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

char_to_ascii :: Char -> Optional ASCII
char_to_ascii = \case
	'\BS' -> Some `i` Peripheral Backspace
	'\HT' -> Some `i` Peripheral Tab
	'\LF' -> Some `i` Peripheral Newline
	'\ESC' -> Some `i` Peripheral Escape
	'\SP' -> Some `i` Peripheral Space
	'\DEL' -> Some `i` Peripheral Delete
	'(' -> Some `a` Sign `a` Bracket `a` Opened `i` Round
	')' -> Some `a` Sign `a` Bracket `a` Closed `i` Round
	'{' -> Some `a` Sign `a` Bracket `a` Opened `i` Curly
	'}' -> Some `a` Sign `a` Bracket `a` Closed `i` Curly
	'<' -> Some `a` Sign `a` Bracket `a` Opened `i` Angle
	'>' -> Some `a` Sign `a` Bracket `a` Closed `i` Angle
	'[' -> Some `a` Sign `a` Bracket `a` Opened `i` Square
	']' -> Some `a` Sign `a` Bracket `a` Closed `i` Square
	'/' -> Some `a` Sign `a` Punctuation `i` Slash
	'\\' -> Some `a` Sign `a` Punctuation `i` Backslash
	'"' -> Some `a` Sign `a` Punctuation `i` Doublequote
	'\'' -> Some `a` Sign `a` Punctuation `i` Singlequote
	'.' -> Some `a` Sign `a` Punctuation `i` Period
	',' -> Some `a` Sign `a` Punctuation `i` Comma
	';' -> Some `a` Sign `a` Punctuation `i` Semicolon
	':' -> Some `a` Sign `a` Punctuation `i` Colon
	'!' -> Some `a` Sign `a` Punctuation `i` Exclamation
	'?' -> Some `a` Sign `a` Punctuation `i` Question
	'#' -> Some `a` Sign `a` Miscellanneous `i` Hash
	'$' -> Some `a` Sign `a` Miscellanneous `i` Dollar
	'%' -> Some `a` Sign `a` Miscellanneous `i` Percent
	'&' -> Some `a` Sign `a` Miscellanneous `i` Ampersand
	'*' -> Some `a` Sign `a` Miscellanneous `i` Asterisk
	'+' -> Some `a` Sign `a` Miscellanneous `i` Plus
	'-' -> Some `a` Sign `a` Miscellanneous `i` Hyphen
	'@' -> Some `a` Sign `a` Miscellanneous `i` At
	'^' -> Some `a` Sign `a` Miscellanneous `i` Caret
	'_' -> Some `a` Sign `a` Miscellanneous `i` Underscore
	'`' -> Some `a` Sign `a` Miscellanneous `i` Grave
	'|' -> Some `a` Sign `a` Miscellanneous `i` Bar
	'~' -> Some `a` Sign `a` Miscellanneous `i` Tilde
	'A' -> Some `a` Letter `a` Uppercase `i`A
	'B' -> Some `a` Letter `a` Uppercase `i`B
	'C' -> Some `a` Letter `a` Uppercase `i`C
	'D' -> Some `a` Letter `a` Uppercase `i`D
	'E' -> Some `a` Letter `a` Uppercase `i`E
	'F' -> Some `a` Letter `a` Uppercase `i`F
	'G' -> Some `a` Letter `a` Uppercase `i`G
	'H' -> Some `a` Letter `a` Uppercase `i`H
	'I' -> Some `a` Letter `a` Uppercase `i`I
	'J' -> Some `a` Letter `a` Uppercase `i`J
	'K' -> Some `a` Letter `a` Uppercase `i`K
	'L' -> Some `a` Letter `a` Uppercase `i`L
	'M' -> Some `a` Letter `a` Uppercase `i`M
	'N' -> Some `a` Letter `a` Uppercase `i`N
	'O' -> Some `a` Letter `a` Uppercase `i`O
	'P' -> Some `a` Letter `a` Uppercase `i`P
	'Q' -> Some `a` Letter `a` Uppercase `i`Q
	'R' -> Some `a` Letter `a` Uppercase `i`R
	'S' -> Some `a` Letter `a` Uppercase `i`S
	'T' -> Some `a` Letter `a` Uppercase `i`T
	'U' -> Some `a` Letter `a` Uppercase `i`U
	'V' -> Some `a` Letter `a` Uppercase `i`V
	'W' -> Some `a` Letter `a` Uppercase `i`W
	'X' -> Some `a` Letter `a` Uppercase `i`X
	'Y' -> Some `a` Letter `a` Uppercase `i`Y
	'Z' -> Some `a` Letter `a` Uppercase `i`Z
	'a' -> Some `a` Letter `a` Lowercase `i`A
	'b' -> Some `a` Letter `a` Lowercase `i`B
	'c' -> Some `a` Letter `a` Lowercase `i`C
	'd' -> Some `a` Letter `a` Lowercase `i`D
	'e' -> Some `a` Letter `a` Lowercase `i`E
	'f' -> Some `a` Letter `a` Lowercase `i`F
	'g' -> Some `a` Letter `a` Lowercase `i`G
	'h' -> Some `a` Letter `a` Lowercase `i`H
	'i' -> Some `a` Letter `a` Lowercase `i`I
	'j' -> Some `a` Letter `a` Lowercase `i`J
	'k' -> Some `a` Letter `a` Lowercase `i`K
	'l' -> Some `a` Letter `a` Lowercase `i`L
	'm' -> Some `a` Letter `a` Lowercase `i`M
	'n' -> Some `a` Letter `a` Lowercase `i`N
	'o' -> Some `a` Letter `a` Lowercase `i`O
	'p' -> Some `a` Letter `a` Lowercase `i`P
	'q' -> Some `a` Letter `a` Lowercase `i`Q
	'r' -> Some `a` Letter `a` Lowercase `i`R
	's' -> Some `a` Letter `a` Lowercase `i`S
	't' -> Some `a` Letter `a` Lowercase `i`T
	'u' -> Some `a` Letter `a` Lowercase `i`U
	'v' -> Some `a` Letter `a` Lowercase `i`V
	'w' -> Some `a` Letter `a` Lowercase `i`W
	'x' -> Some `a` Letter `a` Lowercase `i`X
	'y' -> Some `a` Letter `a` Lowercase `i`Y
	'z' -> Some `a` Letter `a` Lowercase `i`Z
	'0' -> Some `a` Decimal `i` D0
	'1' -> Some `a` Decimal `i` D1
	'2' -> Some `a` Decimal `i` D2
	'3' -> Some `a` Decimal `i` D3
	'4' -> Some `a` Decimal `i` D4
	'5' -> Some `a` Decimal `i` D5
	'6' -> Some `a` Decimal `i` D6
	'7' -> Some `a` Decimal `i` D7
	'8' -> Some `a` Decimal `i` D8
	'9' -> Some `a` Decimal `i` D9
	_ -> None

instance IsString (List Char) where
	fromString x = List (worker x) where
		worker (c : []) = Last c
		worker (c : cs) = Next c (worker cs)

char_to_ascii_with_error :: Char -> ASCII
char_to_ascii_with_error x =
	(error ('\'' : x : '\'' : " - is not ASCII") `rf` i)
	(char_to_ascii x)

instance IsString (List ASCII) where
	fromString x = List (worker x) where
		worker (c : []) = Last (char_to_ascii_with_error c)
		worker (c : cs) = Next (char_to_ascii_with_error c) (worker cs)

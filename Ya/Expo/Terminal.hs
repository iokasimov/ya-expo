module Ya.Expo.Terminal where

import Ya
import Ya.ASCII
import Ya.Expo.Instances
import Ya.Expo.ASCII

import "base" Data.Bool as Base (Bool (False))
import "base" System.IO (IO, BufferMode (NoBuffering), hSetBuffering, hSetEcho, stdin, putStr, getChar)

clear :: IO ()
clear = do
	putStr "\ESC[2J"
	putStr "\ESC[100A"

prepare :: IO ()
prepare = do
	hSetBuffering stdin NoBuffering
	hSetEcho stdin Base.False
	putStr "\ESC[?25l"

input :: IO `TI` Optional ASCII
input = getChar `yo` char_to_ascii

module Ya.Expo.Terminal where

import "base" Data.Bool (Bool (False))
import "base" System.IO (IO, BufferMode (NoBuffering), hSetBuffering, hSetEcho, stdin, putStr)

clear :: IO ()
clear = do
	putStr "\ESC[2J"
	putStr "\ESC[100A"

prepare :: IO ()
prepare = do
	hSetBuffering stdin NoBuffering
	hSetEcho stdin False
	putStr "\ESC[?25l"

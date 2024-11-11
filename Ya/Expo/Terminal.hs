module Ya.Expo.Terminal where

import Ya
import Ya.ASCII
import Ya.Expo.Instances
import Ya.Expo.ASCII

import "base" Data.Bool as Base (Bool (False))
import "base" System.IO (IO, BufferMode (NoBuffering), hSetBuffering, hSetEcho, stdin, putStr, putChar, getChar)

clear :: IO Unit
clear = do
 putStr "\ESC[2J"
 putStr "\ESC[100A"

prepare :: IO Unit
prepare = do
 hSetBuffering stdin NoBuffering
 hSetEcho stdin Base.False
 putStr "\ESC[?25l"

input :: IO ASCII
input = getChar `yo` char_to_ascii

output :: ASCII -> IO ()
output = ascii_to_char `ho` putChar

type Styled = Turn Unit `ML` Turn Unit `ML` Turn Unit `ML` Turn Unit `ML` Turn Unit

pattern Emphasize e = This (This (This (This e)))
pattern Invisible e = This (This (This (That e)))
pattern Underline e = This (This (That e))
pattern Blinking e = This (That e)
pattern Crossing e = That e

type Turn e = e `ML` e

pattern Off e = This e :: Turn e
pattern On e = That e :: Turn e

styled = putStr `ha____` is @Styled `ho___`  is
 `li_` is `hu`"\ESC[22m" `la` is `hu`"\ESC[1m"
 `la_` is `hu`"\ESC[27m" `la` is `hu`"\ESC[7m"
 `la_` is `hu`"\ESC[24m" `la` is `hu`"\ESC[4m"
 `la_` is `hu`"\ESC[25m" `la` is `hu`"\ESC[5m"
 `la_` is `hu`"\ESC[29m" `la` is `hu`"\ESC[9m"

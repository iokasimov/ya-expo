import Ya

import "ya-ascii" Ya.ASCII
import "ya-expo" Ya.Expo.ASCII
import "ya-expo" Ya.Expo.Instances

import "base" System.IO (IO)

import qualified "ya-expo" Ya.Expo.Terminal as Console

type Title = List ASCII

initial = Construct `ho` Nonempty @List
 `ha_` Next `he` "Apply to that new position"
 `ha_` Next `he` "Find a way to fix ligatures"
 `ha_` Next `he` "Organize a boardgame session"
 `he_` Last `he` "Buy a water gun for Songkran"

print ttl = enter @IO
 `yuk___` IO (ttl `yokl` Forth `ha` Console.output)
 `yuk___` IO (Console.output `he` Signal Newline)

main = initial `yokl` Forth `ha` print `ha` is @Title

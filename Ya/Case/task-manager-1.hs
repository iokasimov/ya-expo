import "ya" Ya
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

import "ya-expo" Ya.Expo.Instances ()

import "base" System.IO (IO)

type Title = List ASCII

initial = Nonempty @List
 `ha_` Next `he` "Apply to that new position"
 `ha_` Next `he` "Find a way to fix ligatures"
 `ha_` Next `he` "Organize a boardgame session"
 `he_` Last `he` "Buy a water gun for Songkran"

print ttl = enter @IO
 `yuk___` Run (ttl `yokl` Forth `ha` Run `ha` output)
 `yuk___` Run (output `he` Caret Newline)

main = initial `yokl` Forth `ha` Run `ha` print `ha` is @Title

import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Title = List ASCII

initial = Nonempty @List @Title
 `ha` Item "Apply to that new position" `ha` Next
 `ha` Item "Find a way to fix ligatures" `ha` Next
 `ha` Item "Organize a boardgame session" `ha` Next
 `ha` Item "Buy a water gun for Songkran" `ha` Maybe `hv` Last

print title = enter @World
 `yuk___` Run `hv____` title `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline

main = initial `yokl` Forth `ha` Run `ha` print

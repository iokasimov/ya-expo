import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

type Mode = Unit `S` Unit

pattern Review e = This e
pattern Search e = That e

type Title = List ASCII

type Mark = Unit `S` Unit

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `P` Sliding List ASCII

pattern Bullet e = This e
pattern Cursor e = That e

type Move = Shifter List

pattern Lift x = This x
pattern Down x = That x

type Command = Move `S` Mark `S` Unit `S_` ASCII `S` Unit `S` Unit

pattern Move x = This (This (This x))
pattern Mark x = This (This (That x))
pattern Find x = This (That x)

pattern Heap x = That (This (This x))
pattern Away x = That (This (That x))
pattern Stop x = That (That x)

print cursor (These status task) = enter @World
 `yuk___` Run `hv____` hand cursor `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` mark status `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` show task -- `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline

hand cursor = is @Title `hv__` Bullet `hu` "  -  " `la` Cursor `hu` "  -> " `li` cursor

mark status = is @Title `hv__` TODO `hu` "TODO " `la` DONE `hu` "DONE " `li` status

show = shaft `hv` by Passed `ho` this `ho_'yokl` Prior `ha` Run `ha` output `ho_'yu` Unit
 `lo__'yp` focus `ho` this `ho_'yokl` Forth `ha` Run `ha` output `ho_'yu` Unit
 `lo__'yp` shaft `hv` by Future `ho` this `ho_'yokl` Forth `ha` Run `ha` output `ho_'yu` Unit

-- (`ha'yo`): (t (tt o) i) -> into (from (a) o) (t (tt a) i)

start = to @(Scrolling List) `ha` Nonempty @List @Task
 `ha_` Next `ho` Item (by TODO `lu` to @(Sliding List) @List @ASCII "Apply to that new position")
 `ha_` Next `ho` Item (by TODO `lu` to @(Sliding List) @List @ASCII "Find a way to fix ligatures")
 `ha_` Next `ho` Item (by TODO `lu` to @(Sliding List) @List @ASCII "Organize a boardgame session")
 `ha_` Last `ho` Item (by DONE `lu` to @(Sliding List) @List @ASCII "Buy a water gun for Songkran")

excerpt = shaft `hv` by Passed `ho` this `ho_'yokl` Prior `ha` Run `ha` print (by Bullet)
 `lo__'yp` focus `ho` this `ho_'yokl` Forth `ha` Run `ha` print (by Cursor)
 `lo__'yp` shaft `hv` by Future `ho` this `ho_'yokl` Forth `ha` Run `ha` print (by Bullet)

active title = enter @World
 `yuk___` World `ha` styled `ha` Emphasize `hv` by On
 `yuk___` World `ha` styled `ha` Underline `hv` by On
 `yuk___` World (is @Title `hv` title `yokl` Forth `ha` Run `ha` output)
 `yuk___` World `ha` styled `ha` Emphasize `hv` by Off
 `yuk___` World `ha` styled `ha` Underline `hv` by Off

inactive title = enter @World
 `yuk___` World (is @Title `hv` title `yokl` Forth `ha` Run `ha` output)

indicate = is
  `hu__` output `ha` Caret `hv` by Space
  `lu'yp` active "REVIEW"
  `lu'yp` output `ha` Caret `hv` by Space
  `lu'yp` inactive "SEARCH"
  `lu'yp` output `ha` Caret `hv` by Newline
  `yu` Unit
 `la_______` is
  `hu__` output `ha` Caret `hv` by Space
  `lu'yp` inactive "REVIEW"
  `lu'yp` output `ha` Caret `hv` by Space
  `lu'yp` active "SEARCH"
  `lu'yp` output `ha` Caret `hv` by Newline
  `yu` Unit

render = is `hu_` output `ha` Caret `hv` by Newline
 `lo___'yp` that @Mode `ho` indicate
 `lo___'yp` is `hu_` output `ha` Caret `hv` by Newline
 `lo___'yp` this `ho` this `ho` this `ho` excerpt `ho'yu` Unit

-- `yok___` World `ha__` render `lo'yp` match `ho'yok` Retry `lo'yp` intro
-- `yok___` World `ha__` render `lo'yp` Some `hu` input `lo'yp` intro

-- match mode = input `yo_` is `hu` review `la` is `hu` (Some `ha` search) `li` mode

review :: ASCII `AR__` Maybe Command
review = on @Glyph @ASCII `ho'ho` on @Letter `ho` row
 `ho______` is `hu` by Wrong -- is @(ASCII `M` Glyph `S_` Glyph `M` Letter) `hu` by Wrong
  `la____` press `hv` Lower J `hv` (Move `ha` Down)
  `lo'ys'la` press `hv` Lower K `hv` (Move `ha` Lift)
  `lo'ys'la` press `hv` Upper T `hv` (Mark `ha` TODO)
  `lo'ys'la` press `hv` Upper D `hv` (Mark `ha` DONE)
  `lo'ys'la` press `hv` Lower F `hv` (Find)

search :: ASCII `AR__` Command
search = Heap `ha'he` Glyph
 `la_` Backspace `hu` by Away
  `la` Tab `hu`by Stop
  `la` Newline `hu`by Stop
  `la` Escape `hu`by Stop
  `la` Heap `ha` Caret `ha` Space
  `la` Delete `hu` by Stop

press k f p = Maybe `hv___` k `hd'q` p `yui` Unit `yiu` f Unit

-- filter :: Reviewing `AR___` Searching
-- filter (These result hidden) = is @Reviewing `ho'yoi'yoi` to @List `ho` wrap

type Interface = Scrolling List Task `P` Shafted List Task `P` Title `P` Mode

update character (These (These (These filtered hidden) filter) mode) =
 -- let new = that @Title `hv` push character filter in
 -- new `yokl` locate
 Unit `lu` That (filtered `lu` that @Title `hv` push character filter)

-- TODO: `locate` method of `Sliding List`
-- match x = enter @(State Task `JNT` Progress Unit)
 -- `yuk_____` _

-- new `yokl` 

proccess = enter @(State `WR` Interface `JNT` World)
 `yuk______` World `hv__` prepare `lu'yp` clear
 `yuk______` State `ho` Old `ha` Event `hv` get
 `yok______` World `ha` render
 `yuk______` World `hv` input
 -- `yok______` State `ho` New `ha` Event `ha` update

-- "Buy [a] w[a]ter gun for Songkr[a]n"

 -- `yok______` State `ho` New `ha___` Event @Reviewing `ha` (scroll `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task)
 --  `la______` (is `hu______` State `ho` New `hv__` Event @Searching `hv` (auto `ho'yui` Unit))

main = proccess `he'he'hv__` (by `hv` start `lu` empty `lu` empty `lu` by `hv` Review)

import "ya" Ya
import "ya-world" Ya.World
import "ya-ascii" Ya.ASCII
import "ya-console" Ya.Console

-- type Mode = Unit `S` Unit

-- pattern Review e = This e
-- pattern Search e = That e

type Title = List ASCII

type Mark = Unit `S` Unit

pattern TODO e = This e
pattern DONE e = That e

type Task = Mark `P` Title

pattern Bullet e = This e
pattern Cursor e = That e

type Move = Scroller List

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
 `yuk___` Run `hv____` task `yokl` Forth `ha` Run `ha` output
 `yuk___` Run `hv____` output `ha` Caret `hv` by Newline

hand cursor = is @Title `hv__` Bullet `hu` "  -  " `la` Cursor `hu` "  -> " `li` cursor

mark status = is @Title `hv__` TODO `hu` "TODO " `la` DONE `hu` "DONE " `li` status

start = to @(Scrolling List) `ha` Nonempty @List @Task
 `ha_` Next `ho` Item (by TODO `lu` "Apply to that new position")
 `ha_` Next `ho` Item (by TODO `lu` "Find a way to fix ligatures")
 `ha_` Next `ho` Item (by TODO `lu` "Organize a boardgame session")
 `ha_` Last `ho` Item (by DONE `lu` "Buy a water gun for Songkran")

type Reviewing = Scrolling List Task `P` Shafted List Task

type Searching = Sliding List Task `P` Title

type Interface = Reviewing `S` Searching

excerpt = shaft `hv` by Passed `ho` this `ho_'yokl` Prior `ha` Run `ha` print (by Bullet)
 `lo__'yp` focus `ho` this `ho_'yokl` Forth `ha` Run `ha` print (by Cursor)
 `lo__'yp` shaft `hv` by Future `ho` this `ho_'yokl` Forth `ha` Run `ha` print (by Bullet)

 -- (`ha'yuk`): u (t o) e -> L l tt o -> u (t a) e

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
 `lo___'yp` indicate
 `lo___'yp` is `hu_` output `ha` Caret `hv` by Newline
 `lo___'yp` this `ho` to `la` this `ho_` excerpt `ho'yu` Unit

-- match: Interface -> 

-- input: World ASCII

-- `yok___` World `ha__` render `lo'yp` match `ho'yok` Retry `lo'yp` intro
-- `yok___` World `ha__` render `lo'yp` Some `hu` input `lo'yp` intro

match mode = input `yo_` is `hu` review `la` is `hu` (Some `ha` search) `li` mode

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

-- type Reviewing = Scrolling List Task `P` Shafted List Tasks `P` Title

-- type Searching = Sliding List Task `P` Title

-- filter :: Reviewing `AR___` Searching
-- filter (These result hidden) = is @Reviewing `ho'yoi'yoi` to @List `ho` wrap

proccess = enter @(State `WR` Interface `JNT` World)
 `yuk______` World `hv__` prepare `lu'yp` clear
 `yuk______` State `ho` Old `hv___` Event `hv` get
 `yok______` World `ha__` render
 -- `yuk______` World `ha__` input
 -- `yok______` State `ha` New `ha` review
 --   `ho_____` Event `ha` (scroll `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task)
 --     `la___` Event `ha` (switch `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task) `ho_` Scope `hv` focus `ho_'he` Scope `hv` at @Mark
 --  `la______` State `ha` New `ha` search
 --   `ho_____` _
 
 -- (`hd'q` Lower J)

 -- `yok___` State `ho` Old `hv___` Event `hv` get 
 -- `yok___` that @Command `ho__` _

 -- `yok___` State `ho` New `ha___` Event `ha` (scroll `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task)
 --  `la___` State `ho` New `ha___` Event `ha` (switch `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task) `ho_` Scope `hv` focus `ho_'he` Scope `hv` at @Mark

 -- `yuk___` State `ho` Old `hv___` Event `hv` get 
 -- `yuk___` World `hv___` input
 -- `yok` Retry @Command `ha` apply

  -- `ha___` is @Reviewing `ho` (this @(Scrolling List Task) `ho` to `ho` total `ho'yu` Unit)
  --    `la` is @Searching `ho` (this @(Sliding List Task) `ho` total `ho'yu` Unit)

 -- (this @Title `ho_'yokl` Forth `ha` Run `ha` output `ho_'yu` Unit

 -- `yuk___` State `ho` Old `hv___` Event `hv` auto `ha__` Scope `hv` at @(Scrolling List Task) `ho_` Scope `ha` shaft `hv` by Passed `yok___` World `ha_'yokl` Prior `ha` Run `ha` print (by Bullet)
 -- `yuk___` State `ho` Old `hv___` Event `hv` auto `ha__` Scope `hv` at @(Scrolling List Task) `ho_` Scope `hv` focus `ho` Scope it `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Cursor)
 -- `yuk___` State `ho` Old `hv___` Event `hv` auto `ha__` Scope `hv` at @(Scrolling List Task) `ho_` Scope `ha` shaft `hv` by Future `yok___` World `ha_'yokl` Forth `ha` Run `ha` print (by Bullet)
 -- `yuk___` World `hv___` input `yok` Retry @Command `ha` apply `ha_` on @Glyph `ho'ho` on @Letter `ho` row
 -- `yok___` State `ho` New `ha___` Event `ha` (scroll `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task)
 --  `la___` State `ho` New `ha___` Event `ha` (switch `ho'ho'yui` Unit) `ho__'ha` Scope `hv` at @(Scrolling List Task) `ho_` Scope `hv` focus `ho_'he` Scope `hv` at @Mark
 -- `yok___` Again `ha` Once

main = proccess `he'he'hv__` This (by `hv` start `lu`  empty)

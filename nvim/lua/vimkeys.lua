-- ============================================================================
--  SETTINGS ──── clipboard, line numbers, etc.
-- ============================================================================

vim.opt.clipboard = "unnamedplus"    -- y/yank → system clipboard (+)
vim.opt.number = true
vim.opt.relativenumber = true

-- ============================================================================
--  CLIPBOARD ── delete → black-hole register, explicit Ctrl-c/v
-- ============================================================================

-- All delete / change / paste operations use the black-hole register "_
-- so they never overwrite the system clipboard.

local bh = { expr = false }

vim.keymap.set({ "n", "v" }, "d",  '"_d',  bh)
vim.keymap.set({ "n", "v" }, "D",  '"_D',  bh)
vim.keymap.set({ "n" },        "dd", '"_dd', bh)
vim.keymap.set({ "n", "v" }, "c",  '"_c',  bh)
vim.keymap.set({ "n", "v" }, "C",  '"_C',  bh)
vim.keymap.set({ "n" },        "cc", '"_cc', bh)
vim.keymap.set({ "n", "v" }, "x",  '"_x',  bh)
vim.keymap.set({ "n", "v" }, "X",  '"_X',  bh)
vim.keymap.set({ "n", "v" }, "s",  '"_s',  bh)
vim.keymap.set({ "n" },        "S",  '"_S',  bh)

-- Explicit system-clipboard copy / paste.
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y',  bh)
vim.keymap.set({ "n" },        "<C-v>", '"+p',  bh)
vim.keymap.set({ "v" },        "<C-v>", '"_d"+P', bh)      -- paste over selection
vim.keymap.set({ "i" },        "<C-v>", '<C-r>+', bh)

-- ============================================================================
--  CUSTOM LEADER MAPPINGS   ⇒   <Leader> = <Space>
-- ============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Leader>w",  ":w<CR>",              opts)   -- save
map("n", "<Leader>q",  ":q<CR>",              opts)   -- quit
map("n", "<Leader>bd", ":bd<CR>",             opts)   -- close buffer
map("n", "<Leader>bn", ":bnext<CR>",          opts)   -- next buffer
map("n", "<Leader>bp", ":bprevious<CR>",      opts)   -- prev buffer
map("n", "<Leader>hl", ":nohlsearch<CR>",     opts)   -- clear search highlight
map("n", "<Leader>pv", ":Ex<CR>",             opts)   -- NetRW file explorer
map("n", "n",          "nzz",                 opts)   -- center after next
map("n", "N",          "Nzz",                 opts)   -- center after prev
map("i", "jk",         "<Esc>",               opts)   -- escape from insert

-- ============================================================================
--  BUILT-IN KEYBIND REFERENCE  ────  categorized
-- ============================================================================

---@section CURSOR MOVEMENT ─────────────────────────────────────────────

--  h / j / k / l          cursor left / down / up / right
--  w / W                  word forward (W = WORD)
--  b / B                  word backward
--  e / E                  end of word forward
--  ge / gE                end of word backward
--  0                      first column
--  ^                      first non-blank character
--  $                      end of line
--  g_                     last non-blank character
--  gg                     first line
--  G                      last line
--  :{n}                   go to line n
--  H / M / L              top / middle / bottom of window
--  %                      matching pair ( ), { }, [ ], etc.
--  {  }                   paragraph backward / forward
--  [[  ]]                 section backward / forward
--  (  )                   sentence backward / forward
--  Ctrl-f / Ctrl-b        page down / page up
--  Ctrl-d / Ctrl-u        half-page down / half-page up
--  Ctrl-e / Ctrl-y        scroll lines down / up
--  Ctrl-y / Ctrl-e        scroll down/up one line
--  zz                     centre cursor in window
--  zt                     cursor at top of window
--  zb                     cursor at bottom of window
--  ; / ,                  repeat latest f/t in same / opposite direction
--  f{char} / F{char}      jump forward / back to char
--  t{char} / T{char}      jump forward / back to before char
--  *  / #                 search forward / backward for word under cursor
--  /{pat} / ?{pat}        search forward / backward
--  n  / N                 next / previous search match
--

---@section INSERT MODE ──────────────────────────────────────────────────

--  Ctrl-h / <BS>          delete char before cursor
--  Ctrl-w                 delete word before cursor
--  Ctrl-u                 delete all before cursor on current line
--  Ctrl-j / <CR>          new line
--  Ctrl-k                 digraph / special character
--  Ctrl-r {reg}           insert register content (e.g. Ctrl-r "  →  last yank)
--  Ctrl-r Ctrl-p {reg}    insert register literally
--  Ctrl-o                 execute ONE normal-mode command then return
--  Ctrl-n / Ctrl-p        next / previous completion match
--  Ctrl-x Ctrl-n          next completion match in current file
--  Ctrl-x Ctrl-f          file name completion
--  Ctrl-x Ctrl-k          dictionary completion
--  Ctrl-x Ctrl-l          whole-line completion
--  Ctrl-x Ctrl-o          omni-completion (LSP etc.)
--  Ctrl-t / Ctrl-d        indent / dedent current line
--  Ctrl-v / Ctrl-q        insert literal char (e.g. Ctrl-v 27 → Esc)
--  Ctrl-y                 insert char from above line
--  Ctrl-e                 insert char from below line
--  Ctrl-a                 insert previously inserted text
--  Ctrl-@ / Ctrl-space    insert previously inserted text and stop
--  Ctrl-[ / <Esc>         exit insert mode
--  jk                     (custom) exit insert mode
--

---@section VISUAL MODE ──────────────────────────────────────────────────

--  v                      start character-wise visual mode
--  V                      start line-wise visual mode
--  Ctrl-v                 start block-wise (column) visual mode
--  o                      jump to other end of selection
--  O                      (block mode) jump to other corner
--  ~                      swap case of selection
--  u  / U                 lowercase / uppercase selection
--  <  / >                 indent / dedent selection
--  =                      re-indent selection
--  J                      join selected lines
--  gv                     reselect last visual selection
--  gq                     format / hard-wrap selection (textwidth)
--  y                      yank (copy) selection
--  d  / x                 delete selection
--  c                      change (delete + insert) selection
--  :'<,'>                 apply command to selection (auto-inserted)
--

---@section CUT, COPY, PASTE ─────────────────────────────────────────────

--  y  / yy / Y            yank (copy) text / line / line-to-end
--  d  / dd / D            delete (cut)    text / line / to-end-of-line
--  c  / cc / C            change (delete + insert) text / line / to-EOL
--  x  / X                 delete char under / before cursor
--  s  / S                 delete char / whole line + go to insert
--  p  / P                 paste after / before cursor
--  gp / gP                paste & leave cursor at end
--  "0p                    paste last yanked text (always untouched by delete)
--  "+p                    paste from system clipboard
--  "ap / "bp / ...        paste from register a / b / ...
--  :y                     ex-command yank
--  :d                     ex-command delete
--  :t{addr} / :co{addr}   copy text to address
--  :m{addr}               move text to address
--  :put                   paste register (default " unnamed)
--  :put!                  paste above current line
--  ciw                    change inner word
--  diw                    delete inner word
--  yiw                    yank inner word
--  ci( / ci" / ci[ / ...  change inside delimiters
--  da( / da" / da[ / ...  delete around delimiters
--

---@section UNDO / REDO / REPEAT ─────────────────────────────────────────

--  u              undo last change
--  Ctrl-r         redo last undo
--  U              restore last changed line
--  .              repeat last change
--  g; / g,        jump to older / newer change position
--  :earlier {n}   go back n seconds / lines / changes
--  :later {n}     go forward n seconds / lines / changes
--  :undolist      show undo history branches
--

---@section MARKS ────────────────────────────────────────────────────────

--  m{a-z}         set local mark
--  m{A-Z}         set file mark (cross-file)
--  `{a-z}         jump to exact position of mark
--  '{a-z}         jump to start of line of mark
--  `.             jump to last change position
--  `^             jump to last insert position
--  `[ / `]        jump to start / end of last change / yank
--  `< / `>        jump to start / end of last visual selection
--  g; / g,        cycle older / newer change positions
--  Ctrl-o / i     jump to older / newer cursor position (jump-list)
--  :marks         list all marks
--  :delmarks {a-z}     delete marks
--

---@section SEARCH & REPLACE ─────────────────────────────────────────────

--  /{pat}        search forward
--  ?{pat}        search backward
--  *  / #        search word under cursor forward / backward
--  n  / N        next / previous match
--  :noh[lsearch] clear search highlighting
--  :s/old/new/   substitute first match on current line
--  :s/old/new/g  substitute all matches on current line
--  :%s/old/new/g substitute all matches in file
--  :%s/old/new/gc  substitute with confirmation
--  :{range}s/old/new/  substitute in range (e.g. :10,20s/old/new/g)
--  gd            go to local definition of symbol under cursor
--  gD            go to global definition
--  gf            go to file under cursor
--  [i / ]I       show / list lines matching keyword under cursor
--  :vimgrep /{pat}/g {files}  search in multiple files
--  :g/pattern/   run command on lines matching pattern
--  :v/pattern/   run command on lines NOT matching
--

---@section MULTIPLE FILES / BUFFERS ─────────────────────────────────────

--  :e[dit] {file}       open file
--  :ene[w]              open new empty buffer
--  :find {file}         find & open file in 'path'
--  :bn[ext]             next buffer
--  :bp[revious]         previous buffer
--  :bf[irst]            first buffer
--  :bl[ast]             last buffer
--  :bd[elete]           close current buffer
--  :bw[ipeout]          wipe buffer (removes from list, unlike :bd)
--  :b {name} / :b {n}   switch to buffer by name / number
--  :b# / Ctrl-^         toggle previous buffer
--  :ls / :buffers       list all buffers
--  :args                list argument list
--  :argdo {cmd}         run command on all args
--  :bufdo {cmd}         run command on all buffers
--  :cdo {cmd}           run command on all quickfix entries
--  :cfdo {cmd}          run command on all files in quickfix list
--

---@section TABS ─────────────────────────────────────────────────────────

--  :tabnew / :tabe[dit] {file}   open file in new tab
--  :tabclose / :tabc             close current tab
--  :tabonly / :tabo              close all other tabs
--  gt / :tabn[ext]               next tab
--  gT / :tabp[revious]           previous tab
--  {n}gt                         go to tab n
--  :tabfir[st]                   first tab
--  :tabla[st]                    last tab
--  :tabm[ove] {n}                move tab to position n
--  :tabdo {cmd}                  run command in every tab
--  :tabs                         list tabs
--

---@section SEARCH IN MULTIPLE FILES (GREP / QUICKFIX) ──────────────────

--  :vimgrep /{pat}/g {files}       search in files (Vim's built-in grep)
--  :vimgrep /{pat}/gj {files}      without jumping to first match
--  :grep {args}                    use external 'grep' (set grepprg)
--  :lgrep / :lvimgrep              populate location list (per-window)
--  :copen                          open quickfix window
--  :cclose                         close quickfix window
--  :cnext / :cprev                 next / previous quickfix entry
--  :cfirst / :clast                first / last quickfix entry
--  :cnfile / :cpfile               next / previous file in quickfix
--  :lopen / :lclose / :lnext / :lprev   same for location list
--  :cdo {cmd}                      run command on every line in qf list
--  :cfdo {cmd}                     run command on every file in qf list
--

---@section WINDOW NAVIGATION ────────────────────────────────────────────

--  Ctrl-w h / j / k / l       move to left / down / up / right window
--  Ctrl-w H / J / K / L       move window to far left / bottom / top / right
--  Ctrl-w w                    cycle to next window
--  Ctrl-w W                    cycle to previous window
--  Ctrl-w p                    go to previous (last accessed) window
--  Ctrl-w t / b                go to top-left / bottom-right window
--

---@section WINDOW MANAGEMENT ────────────────────────────────────────────

--  :sp[lit] {file}            horizontal split
--  :vs[plit] {file}           vertical split
--  :new                       horizontal split in new buffer
--  :vne[w]                    vertical split in new buffer
--  Ctrl-w q / :q              close current window
--  Ctrl-w o / :on[ly]         close all windows except current
--  Ctrl-w =                   equalise all window sizes
--  Ctrl-w _                   maximise window height
--  Ctrl-w |                   maximise window width
--  Ctrl-w + / -               increase / decrease window height
--  Ctrl-w > / <               increase / decrease window width
--  Ctrl-w r / R               rotate windows right / left
--  Ctrl-w x                   swap current with next window
--

---@section SAVING & EXITING ─────────────────────────────────────────────

--  :w[rite]                   save
--  :w[rite]!                  force save (if read-only)
--  :w[rite] {file}            save as
--  :wq / :x / :exit           save & quit
--  :q[uit]                    quit (fails if unsaved)
--  :q[uit]!                   force quit (discard changes)
--  :wqa / :xa                 save all & quit
--  :qa[ll]!                   force quit all (discard changes)
--  ZZ                         save & quit (same as :wq)
--  ZQ                         quit (same as :q!)
--  :cq                        quit with error code (useful for git)
--  :w !sudo tee %             save with sudo
--

---@section FOLDING ──────────────────────────────────────────────────────

--  za / zA                   toggle fold / toggle fold recursively
--  zo / zO                   open fold / open fold recursively
--  zc / zC                   close fold / close fold recursively
--  zM                        close all folds
--  zR                        open all folds
--  zd / zD                   delete fold / delete fold recursively
--  zE                        delete all folds
--  zf{motion}                create fold from motion
--  :fold / :{range}fo        create fold for range
--  :foldd[oopen] / :foldc[lose]  open / close fold under cursor
--  :set foldmethod=indent    fold by indent level
--  :set foldmethod=marker    fold by markers ({{{ }}}
--  :set foldmethod=syntax    fold by syntax
--  :set foldcolumn=1         show fold margin
--

---@section QUICKFIX / LOCATION LIST ─────────────────────────────────────

--  :cope[n]              open quickfix window
--  :ccl[ose]             close quickfix window
--  :cn[ext]              next quickfix entry
--  :cp[revious]          previous quickfix entry
--  :cfir[st]             first quickfix entry
--  :cla[st]              last quickfix entry
--  :cnf[ile]             next file in quickfix
--  :cpf[ile]             previous file in quickfix
--  :cc [n]               jump to entry n
--  :cr[ewind] [n]        jump to entry n (rewind)
--  :cdo {cmd}            run command on each line in quickfix
--  :cfdo {cmd}           run command on each file in quickfix
--  :lopen / :lcl / :ln / :lp / :lf / :ll   location list (per-window)
--  :ldo / :lfdo          location list versions of :cdo / :cfdo
--

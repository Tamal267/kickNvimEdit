local map = vim.api.nvim_set_keymap

map("n", "<F2>", ":w<CR>", {})
map("i", "<F2>", "<Esc>:w<CR>", {})
map("n", "<F12>", "ggVG", {})

map("n", "<space>;", ":HopWord<CR>", {})
map("n", "<space>l", ":HopChar1<CR>", {})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap



keymap("", "L", ":HopWordCurrentLine<cr>", { silent = true })
-- keymap("", "S", ":HopChar2<cr>", { silent = true })
-- keymap("", "Q", ":HopPattern<cr>", { silent = true })
keymap("", "H", ":HopChar2<cr>", { silent = true })

keymap("o", "f", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>", opts)
keymap("o", "F", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>", opts)
keymap("o", "t", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>", opts)
keymap("o", "T", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>", opts)

keymap("n", "f", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>", opts)
keymap("n", "F", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>", opts)
keymap("n", "t", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>", opts)
keymap("n", "T", ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>", opts)

map("n", "<F4>", ":ClangFormat<CR>", {})
map("n", "<F6>", ":CompetiTest add_testcase<CR>", {})
map("n", "<F7>", ":CompetiTest edit_testcase<CR>", {})
map("n", "<F8>", ":CompetiTest run", {})

vim.api.nvim_create_autocmd("FileType", { pattern = "cpp",
	command = "nnoremap <F5> :lua Compile_run_cpp5()<CR>"})

vim.api.nvim_create_autocmd("FileType", { pattern = "cpp",
	command = "inoremap <F5> <Esc>:lua Compile_run_cpp5()<CR>"})

-- Define the mapping
-- vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':lua Compile_run_cpp5()<CR>', { silent = true })

-- Define the function
function Compile_run_cpp5()
	local src_path = vim.fn.expand('%:p:~')
	local src_noext = vim.fn.expand('%:p:~:r')
	local inp_file = vim.fn.expand('inp1.txt')
	local _flag = '-Wall -Wextra -Wshadow -std=c++17 -DONPC -O2'
	local prog = 'g++'

	-- if vim.fn.executable('clang++') then
	--   prog = 'clang++'
	-- elseif vim.fn.executable('g++') then
	--   prog = 'g++'
	-- else
	--   vim.api.nvim_err_writeln('No compiler found!')
	--   return
	-- end

	vim.cmd('w')
	vim.cmd('vnew')
	vim.cmd('set nonu')
	vim.cmd('set nornu')
	vim.cmd('term ' .. prog .. ' ' .. _flag .. ' ' .. src_path .. ' -o ' .. src_noext .. ' && ' .. src_noext .. ' < ' .. inp_file)
	vim.cmd('startinsert')
end


vim.api.nvim_create_autocmd("FileType", { pattern = "c",
	command = "nnoremap <F5> :vsplit <Bar> execute 'terminal g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o %< % && ./%< < inp' <Bar> startinsert<CR>"})


vim.api.nvim_create_autocmd("FileType", { pattern = "cpp",
	command = "nnoremap <F9> :lua Compile_run_cpp()<CR>"})

vim.api.nvim_create_autocmd("FileType", { pattern = "cpp",
	command = "inoremap <F9> <Esc>:lua Compile_run_cpp()<CR>"})

-- Define the mapping
-- vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':lua Compile_run_cpp()<CR>', { silent = true })

-- Define the function
function Compile_run_cpp()
	local src_path = vim.fn.expand('%:p:~')
	local src_noext = vim.fn.expand('%:p:~:r')
	local _flag = '-Wall -Wextra -std=c++17 -DONPC -O2'
	local prog = 'g++'

	-- if vim.fn.executable('clang++') then
	--   prog = 'clang++'
	-- elseif vim.fn.executable('g++') then
	--   prog = 'g++'
	-- else
	--   vim.api.nvim_err_writeln('No compiler found!')
	--   return
	-- end

	vim.cmd('w')
	vim.cmd('vnew')
	vim.cmd('set nonu')
	vim.cmd('set nornu')
	vim.cmd('term ' .. prog .. ' ' .. _flag .. ' ' .. src_path .. ' -o ' .. src_noext .. ' && ' .. src_noext)
	vim.cmd('startinsert')
end


vim.api.nvim_create_autocmd("FileType", { pattern = "c",
	command = "nnoremap <F9> :vsplit <Bar> execute 'terminal g++ -g % -o %:r && ./%:r' <Bar> startinsert<CR>"})


vim.api.nvim_create_autocmd("FileType", { pattern = "python",
	command = "nnoremap <F9> :vsplit <Bar> execute 'terminal python3 %' <Bar> startinsert<CR>"})

vim.api.nvim_create_autocmd("FileType", { pattern = "java",
	command = "nnoremap <F9> <Esc>:lua Compile_run_java()<CR>"})

vim.api.nvim_create_autocmd("FileType", { pattern = "java",
	command = "inoremap <F9> <Esc>:lua Compile_run_java()<CR>"})

function Compile_run_java()
	local src_path = vim.fn.expand('%')
	local src_noext = vim.fn.expand('%:r')
	vim.cmd('w')
	vim.cmd('vnew')
	vim.cmd('set nonu')
	vim.cmd('set nornu')
	vim.cmd('term javac ' .. src_path .. ' && java ' .. src_noext )
	vim.cmd('startinsert')
end

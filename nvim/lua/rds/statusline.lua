-- TODO: things I need:
-- git branch
-- path + filename
-- line and col
-- total of lines (?)
-- filetype
-- enconding (?)
-- LSP erros and warnings

-- local function harpoon_status()
    -- return ""
-- end

local function lsp_status()
    local errors = vim.lsp.diagnostic.get_count(0, "Error")
    local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
    local hints = vim.lsp.diagnostic.get_count(0, "Hint")
    return string.format("%%-20.20(|LSP E:%s W:%s H:%s%%)", errors, warnings, hints)
end

local function harpoon_status()
    local status = require("harpoon.mark").status()
    if #status == 0 then
        status = "-"
    end

    return string.format("%%-15.15(|Harpoon: %s%%)", status)
end

function Statusline()
    local git_branch = vim.fn["fugitive#head"]()

    if #git_branch == 0 then
        git_branch = "no-git"
    end

    local git_str = string.format("%%-10.25(|(%s)%%)", git_branch)

    local file_str = "|%-60.110f"

    return git_str..lsp_status()..harpoon_status()..file_str
end

vim.o.statusline = "%!v:lua.Statusline()"

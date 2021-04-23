-- TODO: things I need:
-- git branch
-- path + filename
-- line and col
-- total of lines (?)
-- filetype
-- enconding (?)
-- LSP erros and warnings

function Statusline()
    local git_branch = vim.fn["fugitive#head"]()

    if #git_branch == 0 then
        git_branch = "no-git"
    end

    local git_str = string.format("%%-20.20((%s)%%)", git_branch)

    local file_str = "|%-10.100f"

    return git_str..file_str
end

vim.o.statusline = "%!v:lua.Statusline()"

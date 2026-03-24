-- ========================================================================== --
--                            ATAJOS DE TECLADO (MAPS)                        --
-- ========================================================================== --

local keymap = vim.keymap

-- Configuración para abrir el explorador con la motion de espacio e
keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Abrir explorador de archivos" })

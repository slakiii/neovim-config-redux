(module config.plugin.harpoon
  {autoload {mark harpoon.mark
             ui harpoon.ui
             ;;util config.util
             nvim aniseed.nvim}})

;; (util.nnoremap :<leader>a mark.add_file)
;; (util.nnoremap :<C-a> ui.toggle_quick_menu)

(nvim.set_keymap :n :zx ":lua require('harpoon.mark').add_file()<CR>" {:noremap true})
(nvim.set_keymap :n :<C-h> ":lua require('harpoon.ui').toggle_quick_menu()<CR>" {:noremap true})


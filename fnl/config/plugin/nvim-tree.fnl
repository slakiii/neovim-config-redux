(module config.plugin.nvim-tree
  {autoload {tree nvim-tree}})

;; https://github.com/kyazdani42/nvim-tree.lua

(tree.setup
 {:sort_by "case_sensitive"
  :open_on_setup true
  :view {:adaptive_size true
         :mappings {:list [{:key "u" :action "dir_up"}]}
         :centralize_selection true}
  :renderer {:group_empty true
             :highlight_opened_files "name"}
  :filters {:dotfiles false}
  })


  ;; sort_by = "case_sensitive",
  ;; view = {
  ;;   adaptive_size = true,
  ;;   mappings = {
  ;;     list = {
  ;;       { key = "u", action = "dir_up" },
  ;;     },
  ;;   },
  ;; },
  ;; renderer = {
  ;;   group_empty = true,
  ;; },
  ;; filters = {
  ;;   dotfiles = true,
  ;; },

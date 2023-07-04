(module config.plugin.theme-newpaper
  {autoload {theme newpaper}})

;; https://github.com/yorik1984/newpaper.nvim

(theme.setup
  {:style :dark
   :italic_comments true
   :borders false
   :terminal "contrast"
   :sidebars_contrast ["NvimTree"]})


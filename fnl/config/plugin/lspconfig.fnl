(module config.plugin.lspconfig
  {autoload {nvim aniseed.nvim
             lsp lspconfig
             cmplsp cmp_nvim_lsp}})


;; gutter icons for lsp diagnostics
;; :help vim.lsp.diagnostic.set_signs
(defn define-signs
  [prefix]
  (let [error (.. prefix "SignError")
        warn  (.. prefix "SignWarn")
        info  (.. prefix "SignInfo")
        hint  (.. prefix "SignHint")]
    (vim.fn.sign_define error {:text "" :texthl error})
    (vim.fn.sign_define warn  {:text "" :texthl warn})
    (vim.fn.sign_define info  {:text "" :texthl info})
    (vim.fn.sign_define hint  {:text "" :texthl hint})))

;; LSP naming changed between neovim 0.6 and 0.7 onward
(if (= (nvim.fn.has "nvim-0.6") 1)
  (define-signs "Diagnostic")
  (define-signs "LspDiagnostics"))


;; Configure server features
(let [handlers {"textDocument/publishDiagnostics"
                (vim.lsp.with
                 vim.lsp.diagnostic.on_publish_diagnostics
                 {:severity_sort true
                  :update_in_insert false
                  :underline true
                  :virtual_text false})
                "textDocument/hover"
                (vim.lsp.with
                 vim.lsp.handlers.hover
                 {:border "single"})
                "textDocument/signatureHelp"
                (vim.lsp.with
                 vim.lsp.handlers.signature_help
                 {:border "single"})}
      capabilities (cmplsp.default_capabilities)
      on_attach (fn [client bufnr]
                  (do
                    (nvim.buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>ld "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lt "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lh "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>ln "<cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.formatting()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lj "<cmd>lua vim.diagnostic.goto_next()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lk "<cmd>lua vim.diagnostic.goto_prev()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>la "<cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :v :<leader>la "<cmd>lua vim.lsp.buf.range_code_action()<CR> " {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>a  "<cmd>lua vim.lsp.buf.code_action_group()<CR>" {:noremap true})
                    ;telescope
                    (nvim.buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true})))]

  ;; Clojure LSP Server setup
  (lsp.clojure_lsp.setup {:on_attach on_attach
                          :handlers handlers
                          :capabilities capabilities})

  ;; C/Cpp
  (lsp.clangd.setup {:on_attach on_attach
                     :handlers handlers
                     :capabilities capabilities})

  ;; JavaScript and TypeScript
  (lsp.tsserver.setup {:on_attach on_attach
                       :handlers handlers
                       :capabilities capabilities})

  ;; html / css / json

  (lsp.cssls.setup {:on_attach on_attach
                    :handlers handlers
                    :capabilities capabilities
                    :cmd ["vscode-css-languageserver" "--stdio"]})

  (lsp.html.setup {:on_attach on_attach
                   :handlers handlers
                   :capabilities capabilities
                   :cmd ["vscode-html-languageserver" "--stdio"]})

  (lsp.jsonls.setup {:on_attach on_attach
                     :handlers handlers
                     :capabilities capabilities
                     :cmd ["vscode-json-languageserver" "--stdio"]})

  (lsp.rust_analyzer.setup {:on_attach on_attach
                            :handlers handlers
                            :capabilities capabilities})
 
  (lsp.terraformls.setup {:on_attach on_attach
                          :handlers handlers
                          :capabilities capabilities}) 
 
  (lsp.kotlin_language_server.setup {:on_attach on_attach
                                     :handlers handlers
                                     :capabilities capabilities}))

;; (vim.lsp.protocol.CompletionItemKind
;;  {"   (Text) ",
;;   "   (Method)",
;;   "   (Function)",
;;   "   (Constructor)",
;;   " ﴲ  (Field)",
;;   "[] (Variable)",
;;   "   (Class)",
;;   " ﰮ  (Interface)",
;;   "   (Module)",
;;   " 襁 (Property)",
;;   "   (Unit)",
;;   "   (Value)",
;;   " 練 (Enum)",
;;   "   (Keyword)",
;;   "   (Snippet)",
;;   "   (Color)",
;;   "   (File)",
;;   "   (Reference)",
;;   "   (Folder)",
;;   "   (EnumMember)",
;;   " ﲀ  (Constant)",
;;   " ﳤ  (Struct)",
;;   "   (Event)",
;;   "   (Operator)",
;;   "   (TypeParameter)"})

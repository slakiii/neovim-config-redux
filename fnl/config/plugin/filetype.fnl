(module config.plugin.filetype
  {autoload {filetype filetype}})

(filetype.setup
  {:overrides
   {:extensions
    {:tf "tf"
     :tfvars "terraform"
     :tfstate "json"}}})


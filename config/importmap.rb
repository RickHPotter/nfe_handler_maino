# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "stimulus-notification" # @2.2.0
pin "hotkeys-js" # @3.13.7
pin "stimulus-use" # @0.51.3

pin_all_from "app/javascript/controllers", under: "controllers"

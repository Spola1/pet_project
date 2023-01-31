// Entry point for the build script in your package.json
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"

import '@popperjs/core'
import 'bootstrap/js/dist/dropdown'
import "@hotwired/turbo-rails"
import "./controllers"

Rails.start()
Turbolinks.start()
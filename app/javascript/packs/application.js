// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Import Rails and UJS
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Initialize Rails and Turbolinks
Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Import jQuery
import $ from 'jquery'
window.jQuery = $
window.$ = $

$(document).on('turbolinks:load', function() {
  // Any specific JavaScript to run on page load
})

// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

import './components/animate_feature_row';
import './components/popup_card';

document.addEventListener('turbo:load', function() {
  // Initialize tooltips
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl, {
      template: '<div class="tooltip custom-tooltip-theme" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large-tooltip"></div></div>',
      html: true,
      animation: true,
      delay: { show: 50, hide: 100 },
      placement: 'top'
    })
  })

  // Initialize dropdowns
  var dropdownTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="dropdown"]'))
  var dropdownList = dropdownTriggerList.map(function (dropdownTriggerEl) {
    return new bootstrap.Dropdown(dropdownTriggerEl)
  })
})

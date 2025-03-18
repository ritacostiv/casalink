// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import './components/animate_feature_row';
import './components/popup_card';


document.addEventListener('turbo:load', function() {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl, {
      template: '<div class="tooltip custom-tooltip-theme" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large-tooltip"></div></div>',
      // Other options:
      html: true,               // Allow HTML in tooltip content
      animation: true,          // Fade animation
      delay: { show: 50, hide: 100 },  // Delay showing/hiding
      placement: 'top'          // Position (top, bottom, left, right)
    })
  })
})

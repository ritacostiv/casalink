// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

// import './components/animate_feature_row';
// import './components/popup_card';


document.addEventListener('turbo:load', function() {
  console.log('Initializing tooltips');

  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
    new bootstrap.Tooltip(el, {
      template: '<div class="tooltip custom-tooltip-theme" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large-tooltip"></div></div>',
      html: true,
      animation: true,
      delay: { show: 50, hide: 100 },
      placement: 'top'
    });
  });
});

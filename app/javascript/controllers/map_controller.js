import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    markerImageUrl: String // Add this for the custom marker image
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    // Create the map
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    // Add markers to the map
    this.#addMarkersToMap();

    // Fit the map to markers and save the initial bounds
    this.originalBounds = this.#fitMapToMarkers();

    // Add the reset button to the map
    this.#addResetViewButton();

    // Add zoom controls to the map
    this.#addZoomControls();

    // Add listeners to location pins
    this.#addLocationPinListeners(); // NEW
  }

  #addMarkersToMap() {
    const markerImageUrl = this.markerImageUrlValue; // Retrieve the image URL from the data attribute

    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html); // Attach popup

      // Use the custom image for the marker
      const customMarker = document.createElement("img");
      customMarker.src = markerImageUrl;
      customMarker.style.width = "30px";
      customMarker.style.height = "30px";

      // Create the marker
      const mapMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat]) // Position the marker
        .setPopup(popup)
        .addTo(this.map);

      // Add data attributes for lat/lng
      const markerElement = mapMarker.getElement(); // Get the DOM element
      markerElement.dataset.lat = marker.lat;
      markerElement.dataset.lng = marker.lng;
    });
  }


  #addLocationPinListeners() {
    // Select all location pins
    const locationPins = document.querySelectorAll(".location-pin");

    locationPins.forEach((pin) => {
      pin.addEventListener("click", (event) => {
        // Get latitude and longitude from data attributes
        const lat = parseFloat(pin.dataset.lat);
        const lng = parseFloat(pin.dataset.lng);

        // Highlight the corresponding marker
        this.#highlightMarker(lat, lng);
      });
    });
  }

  #highlightMarker(lat, lng) {
    // Select all markers
    const markers = document.querySelectorAll("img[src='" + this.markerImageUrlValue + "']");

    markers.forEach((marker) => {
      // Get marker position from its parent container
      const markerPosition = marker.closest(".mapboxgl-marker")._lngLat;

      // Check if the marker matches the target coordinates
      if (markerPosition.lng === lng && markerPosition.lat === lat) {
        // Highlight this marker
        marker.style.width = "50px"; // Larger width
        marker.style.height = "50px"; // Larger height
        marker.style.transition = "transform 0.3s ease";
        marker.style.transform = "scale(1.25)"; // Smooth zoom effect
      } else {
        // Reset other markers to their normal size
        marker.style.width = "30px";
        marker.style.height = "30px";
        marker.style.transform = "scale(1)";
      }
    });
  }



  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    return bounds; // Save the initial bounds
  }

  #addResetViewButton() {
    const resetButton = document.createElement("button");
    resetButton.className = "mapboxgl-ctrl-icon"; // Style like other Mapbox controls
    resetButton.type = "button";
    resetButton.setAttribute("aria-label", "Reset View");
    resetButton.innerHTML = `<i class="fa-solid fa-house"></i>`; // Font Awesome icon

    // Event listener to reset the view
    resetButton.addEventListener("click", () => {
      this.map.fitBounds(this.originalBounds, { padding: 70, maxZoom: 15, duration: 1000 });
    });

    const resetButtonContainer = document.createElement("div");
    resetButtonContainer.className = "mapboxgl-ctrl mapboxgl-ctrl-group"; // Matches Mapbox styling
    resetButtonContainer.appendChild(resetButton);

    this.map.addControl({
      onAdd: () => resetButtonContainer,
      onRemove: () => resetButtonContainer.remove()
    }, "top-right"); // Add to top-right corner
  }

  #addZoomControls() {
    const zoomControls = new mapboxgl.NavigationControl();
    this.map.addControl(zoomControls, "top-right");
  }
}

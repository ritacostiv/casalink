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
  }

  #addMarkersToMap() {
    const markerImageUrl = this.markerImageUrlValue; // Retrieve the image URL from the data attribute
    console.log("Marker Image URL:", markerImageUrl); // Debugging

    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html); // Attach popup

      // Use the custom image for the marker
      const customMarker = document.createElement("img");
      customMarker.src = markerImageUrl; // Set the marker image
      customMarker.style.width = "30px"; // Adjust size
      customMarker.style.height = "30px"; // Adjust size

      // Add the custom marker with the popup
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat]) // Position the marker
        .setPopup(popup) // Attach the popup
        .addTo(this.map); // Add to the map
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

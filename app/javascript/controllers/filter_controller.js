import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("Filter controller connected!");

    // Cache all property cards
    this.propertyCards = Array.from(document.querySelectorAll(".properties-list-left .property-card"));
    console.log(this.propertyCards)
    // Attach the toggle functionality for the filter form
    const toggleButton = document.getElementById("toggle-filter-button");
    if (toggleButton) {
      toggleButton.addEventListener("click", () => this.toggleFilterForm());
    }

    // Attach real-time search functionality with debounce
    const searchBox = document.getElementById("search-box");
    if (searchBox) {
      searchBox.addEventListener("input", (event) => {
        debounce(() => this.filterBySearch(event.target.value), 300); // Debounced
      });
    }

    // Attach the toggle functionality for the Sort By dropdown
    const toggleSortButton = document.getElementById("toggle-sort-button");
    const sortDropdown = document.getElementById("sort-dropdown");
    if (toggleSortButton && sortDropdown) {
      toggleSortButton.addEventListener("click", () => {
        sortDropdown.style.display = sortDropdown.style.display === "none" || sortDropdown.style.display === "" ? "block" : "none";
      });
    }

    // Attach the Apply Sort functionality
    const applySortButton = document.getElementById("apply-sort-button");
    if (applySortButton) {
      applySortButton.addEventListener("click", () => this.applySort());
    }

    // Attach sort input validation
    const validateSortInputs = () => {
      const sortOrder = document.querySelector('input[name="sort-order"]:checked');
      const sortOption = document.getElementById("sort-options").value;
      if (applySortButton) {
        applySortButton.disabled = !(sortOrder && sortOption); // Enable only if valid
      }
    };

    document.querySelectorAll('input[name="sort-order"]').forEach((input) => {
      input.addEventListener("change", validateSortInputs);
    });

    document.getElementById("sort-options").addEventListener("change", validateSortInputs);
  }


  applyFilters(event) {
    event.preventDefault(); // Prevent the form from submitting normally

    const formData = new FormData(this.formTarget);

    // Extract filter values
    const searchKeyword = formData.get("search") || "";
    const selectedTypology = formData.get("typology") || "";
    const selectedPrice = formData.get("price") || "";
    const selectedSize = formData.get("size") || "";
    const hasElevator = formData.get("elevator") === "true";
    const hasGarage = formData.get("garage") === "true";

    console.log("Selected Filters:", { searchKeyword, selectedTypology, selectedPrice, selectedSize, hasElevator, hasGarage });

    // Apply all filters, including search
    this.filterProperties(searchKeyword, selectedTypology, selectedPrice, selectedSize, hasElevator, hasGarage);
  }

  applySort() {
    // Get sort order (asc/desc)
    const sortOrder = document.querySelector('input[name="sort-order"]:checked').value;

    // Get sort attribute (price, size, typology, etc.)
    const sortAttribute = document.getElementById("sort-options").value;

    // Call sortProperties with the selected options
    this.sortProperties(sortAttribute, sortOrder);
  }

  sortProperties(attribute, order) {
    const sortedCards = [...this.propertyCards];

    // Sort based on attribute and order
    sortedCards.sort((a, b) => {
      const valueA = this.getAttributeValue(a, attribute);
      const valueB = this.getAttributeValue(b, attribute);

      if (order === "asc") {
        return valueA > valueB ? 1 : valueA < valueB ? -1 : 0;
      } else {
        return valueA < valueB ? 1 : valueA > valueB ? -1 : 0;
      }
    });

    // Rearrange the cards in the DOM
    const container = document.querySelector(".properties-list-left");
    container.innerHTML = ""; // Clear existing cards
    sortedCards.forEach((card) => container.appendChild(card)); // Append sorted cards
  }

  getAttributeValue(card, attribute) {
    // Parse card attribute for sorting
    switch (attribute) {
      case "price":
        return parseFloat(card.dataset.price);
      case "size":
        return parseFloat(card.dataset.size);
      case "typology":
        return parseInt(card.dataset.typology);
      case "garage":
        return card.dataset.garage === "true" ? 1 : 0;
      case "elevator":
        return card.dataset.elevator === "true" ? 1 : 0;
      default:
        return 0; // Default case
    }
  }

  filterBySearch(searchKeyword) {
    // Real-time filtering on keyword input
    const formData = new FormData(this.formTarget);
    const selectedTypology = formData.get("typology") || "";
    const selectedPrice = formData.get("price") || "";
    const selectedSize = formData.get("size") || "";
    const hasElevator = formData.get("elevator") === "true";
    const hasGarage = formData.get("garage") === "true";

    this.filterProperties(searchKeyword, selectedTypology, selectedPrice, selectedSize, hasElevator, hasGarage);
  }

  filterProperties(searchKeyword, selectedTypology, selectedPrice, selectedSize, hasElevator, hasGarage) {
    const lowercasedSearch = searchKeyword.toLowerCase();

    // Filter cards based on all conditions
    this.propertyCards.forEach((card) => {
      const cardContent = card.textContent.toLowerCase();
      const cardTypology = card.dataset.typology;
      const cardPrice = card.dataset.price;
      const cardSize = card.dataset.size;
      const cardElevator = card.dataset.elevator === "true";
      const cardGarage = card.dataset.garage === "true";

      // Match conditions
      const matchesSearch = lowercasedSearch === "" || cardContent.includes(lowercasedSearch);
      const matchesTypology = selectedTypology === "" || cardTypology === selectedTypology;
      const matchesPrice = selectedPrice === "" || cardPrice === selectedPrice;
      const matchesSize = selectedSize === "" || cardSize === selectedSize;
      const matchesElevator = !hasElevator || cardElevator;
      const matchesGarage = !hasGarage || cardGarage;

      // Determine visibility
      const isVisible = matchesSearch && matchesTypology && matchesPrice && matchesSize && matchesElevator && matchesGarage;
      console.log(isVisible)
      card.style.display = isVisible ? "block" : "none";
    });

    // Handle "No Results" message
    const noResultsMessage = document.querySelector(".no-results-message");
    const anyVisible = this.propertyCards.some((card) => card.style.display === "block");
    if (noResultsMessage) {
      noResultsMessage.style.display = anyVisible ? "none" : "block";
    }
  }

  toggleFilterForm() {
    const filterForm = document.getElementById("filter-form");
    const toggleButton = document.getElementById("toggle-filter-button");

    if (filterForm.style.display === "none") {
      filterForm.style.display = "block";
      toggleButton.textContent = "Hide Filters";
    } else {
      filterForm.style.display = "none";
      toggleButton.textContent = "Show Filters";
    }
  }
}

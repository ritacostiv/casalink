import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["badge"];

  connect() {
    console.log("Notifications controller connected!");
  }

  addNotification() {
    this.badgeTarget.classList.remove("d-none"); // Show the badge
  }
}

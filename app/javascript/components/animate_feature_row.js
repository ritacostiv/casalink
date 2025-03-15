document.addEventListener("DOMContentLoaded", () => {
  const featureRow = document.querySelector(".feature-row");

  // Add the animation class after a delay of 900ms
  if (featureRow) {
    setTimeout(() => {
      featureRow.classList.add("slide-in");
    }, 500); // milliseconds delay
  }
});

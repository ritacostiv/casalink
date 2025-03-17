document.addEventListener("DOMContentLoaded", () => {
  console.log("JavaScript loaded!");

  const popUpCard = document.querySelector(".pop-up-card");
  const closeBtn = document.querySelector(".close-btn");

  // Automatically display the pop-up after a short delay
  setTimeout(() => {
    if (popUpCard) {
      popUpCard.classList.add("active");
      console.log("Pop-up activated");
    }
  }, 500); // Delay before showing

  // Close button functionality
  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      popUpCard.classList.remove("active");
      console.log("Pop-up closed");
    });
  }

  
});

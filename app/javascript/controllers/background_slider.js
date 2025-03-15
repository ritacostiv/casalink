document.addEventListener('DOMContentLoaded', () => {
  const slides = document.querySelectorAll('.slider-images img');
  let currentSlide = 0;

  function changeSlide() {
    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + 1) % slides.length;
    slides[currentSlide].classList.add('active');
  }

  setInterval(changeSlide, 5000); // Change slide every 5 seconds
});

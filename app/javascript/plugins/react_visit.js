const infiniteScroll = () => {
  const nextButton = document.querySelector('.review-next-button');
  const container = document.querySelector('.review-show-container');
  if (nextButton) {
    window.addEventListener('scroll', () => {
          if (window.scrollY >= 60 ) {
        console.log('You have scrolled to the end of the page')
        // container.insertAdjacentHTML(beforeend, "hey" )
        nextButton.click();
      }
    })
  }
}

// export { infiniteScroll };

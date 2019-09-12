const updateBannerOnScroll = () => {
  const banner = document.querySelector('.banner');
  const bannerText = document.querySelector('.banner-text');
  const search = document.querySelector('.search');
  const bannerContainer = document.querySelector('.banner-container');
  if (banner) {
    window.addEventListener('scroll', () => {

      if (window.scrollY >= (window.innerHeight * 0.25)) {
        banner.classList.add('banner-background-hide');
        bannerText.classList.add('banner-content-hide');
        search.classList.add('search-white');
        bannerContainer.classList.add('banner-container-hide')
      } else {
        banner.classList.remove('banner-background-hide');
        bannerText.classList.remove('banner-content-hide');
        search.classList.remove('search-white');
        bannerContainer.classList.remove('banner-container-hide')
      }
    });
  }
}

export { updateBannerOnScroll };

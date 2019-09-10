console.log('Your coffee script is being read')
if $('#infinite-scrolling').size() > 0
  $(window).on 'scroll', ->
    console.log('You scrolled')
    more_reviews_url = $('.pagination .next_page a').attr('href')
    if more_reviews_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
      console.log('You scrolled enough')
      $('.pagination').html('<p> loading <p>')
      $.getScript more_reviews_url
      console.log('Added next 5 reviews')
    return
  return

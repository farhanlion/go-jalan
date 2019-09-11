if $('#infinite-scrolling').size() > 0
  $(window).on 'scroll', ->
    more_reviews_url = $('.pagination .next_page a').attr('href')
    if more_reviews_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
      $('.pagination').html('<p> loading <p>')
      $.getScript more_reviews_url
      console.log('Added next 5 reviews')
    return
  return

V3RedroverWebsite.BrowsePlacesView = Ember.View.extend
  templateName: 'browse_places'
  controllerBinding: 'V3RedroverWebsite.router.browsePlacesController'
  didInsertElement: ->
    @initializeCarousel()

  initializeCarousel: (->
    sliderOpts = {
      minSlides: 4
      maxSlides: 4
      moveSlides: 4
      slideWidth: 186
      slideMargin: 10
      pager: false
      infiniteLoop: false
      hideControlOnEnd: true
      slideSelector: '.slide'
    }

    if(@get('controller').get('filteredPlaces').isLoaded)
      setTimeout( (=>
        @$('.bxslider').bxSlider(sliderOpts)
        ), 0)

  ).observes('controller.categorizedPlaces')

  notFoundResults:(->
    @get("controller.categorizedPlaces").length <= 0 && @get("spinnerToggle") is "hide"
    ).property('controller.categorizedPlaces')

  spinnerToggle: ( ->
    if @get('controller').get('filteredPlaces').isLoaded
      "hide"
    else
      "icomoon-spinner"
  ).property('controller.categorizedPlaces')
		
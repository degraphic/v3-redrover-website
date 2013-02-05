V3RedroverWebsite.BrowsePlacesController = Ember.ArrayController.extend
  content: []
  filteredPlaces: []
  categories: (->
    V3RedroverWebsite.Category.find({type: "place"})
  ).property()
  category_ids: []

  find: (parameters)->
    @set("filteredPlaces", V3RedroverWebsite.Place.find(parameters) )
    @category_ids = parameters.categories_ids.split "," 


  filteredCategoriesIds: (->
    catIds = []

    filteredCategories = @get('categories').toArray()
    catIds.push "#{category.id}" for category in filteredCategories
    catIds
  ).property('categories.@each','categories.isLoaded')

  changeFilteredCategoriesIds: (->
    @category_ids = @get('filteredCategoriesIds')
    @set("filteredPlaces", V3RedroverWebsite.Place.find({
      categories_ids: @get('filteredCategoriesIds').join(","),
      distance: "5mi"
    }) )
  ).observes 'filteredCategoriesIds.isLoaded' 

  categorizedPlaces: (->
    categoryHash = {}
    filteredPlaces = @get('filteredPlaces').toArray()
    @category_ids = @get('categories') if @category_ids.length is 0


    for place in filteredPlaces
      for category in place.get('categories').toArray()
        categoryHash[category.id] = new Ember.A() unless categoryHash[category.id]
        categoryHash[category.id].pushObject(place)

    result = Ember.A()
    for category in @get('categories').toArray()
      if (categoryHash[category.id] && category.id in @category_ids)
        result.pushObject({
          category: category
          places: categoryHash[category.id].toArray()
        })
    result.toArray()
  ).property('filteredPlaces.isLoaded')

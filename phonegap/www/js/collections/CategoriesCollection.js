define([ "jquery","backbone","models/CategoryModel" ], function( $, Backbone, CategoryModel ) {
  // Extends Backbone.Router
  var Collection = Backbone.Collection.extend( {
    // The Collection constructor
    initialize: function(models, options ) {
      // Sets the type instance property (ie. animals)
      this.type = options.type;
    },
    // Sets the Collection model property to be a Category Model
    model: CategoryModel,
    url: 'http://192.168.3.48:3000/books/api',
    // Sample JSON data that in a real app will most likely come from a REST web service
    jsonArray: [
      { "category": "animals",  "type": "Pets" },
      { "category": "animals",  "type": "Farm Animals" },
      { "category": "animals",  "type": "Wild Animals" },
      { "category": "colors",   "type": "Blue" },
      { "category": "colors",   "type": "Green" },
      { "category": "colors",   "type": "Orange" },
      { "category": "colors",   "type": "Purple" },
      { "category": "colors",   "type": "Red" },
      { "category": "colors",   "type": "Yellow" },
      { "category": "colors",   "type": "Violet" },
      { "category": "vehicles", "type": "Cars" },
      { "category": "vehicles", "type": "Planes" },
      { "category": "vehicles", "type": "Construction" }
    ],
    parse: function(data) {
      this.models[0] = new this.model(data[0]);
    },

    // Overriding the Backbone.sync method (the Backbone.fetch method calls the sync method when trying to fetch data)
    sync_old: function( method, model, options ) {
      // Local Variables
      // ===============
      // Instantiates an empty array
      var categories = [],
      // Stores the this context in the self variable
      self = this,
      // Creates a jQuery Deferred Object
      deferred = $.Deferred();
      // Uses a setTimeout to mimic a real world application that retrieves data asynchronously
      setTimeout( function() {
        categories = _.filter( self.jsonArray, function(row) {
            return row.category === self.type;
        } );
        options.success(categories);
        self.trigger("added");
        deferred.resolve();
      }, 1000);
      return deferred;
    }
  });
  // Returns the Model class
  return Collection;
} );
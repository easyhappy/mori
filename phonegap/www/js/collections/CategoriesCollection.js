define([ "jquery","backbone","models/CategoryModel",
  "collections/BaseCollection"], 
  function( $, Backbone, CategoryModel, BaseCollection) {
  // Extends Backbone.Router
  var Collection = Backbone.Collection.extend(BaseCollection).extend( {
    model: CategoryModel,
    url: function(){
      //return 'http://192.168.1.102:3000/api/categories';
      return this.baseUrl() + '/categories';
    },
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
        deferred.resolve();
      }, 1000);
      return deferred;
    }
  });
  // Returns the Model class
  return Collection;
} );
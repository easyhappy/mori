define([ "jquery","backbone", "../models/CategoryModel", "../collections/CategoriesCollection", "../views/CategoryView" ], function( $, Backbone, CategoryModel, CategoriesCollection, CategoryView ) {
    // Extends Backbone.Router
    var CategoryRouter = Backbone.Router.extend( {
    // The Router constructor
    initialize: function() {
      this.animalsView = new CategoryView( { el: "#animals", collection: new CategoriesCollection( [] , { type: "animals" } ) } );
      this.colorsView = new CategoryView( { el: "#colors", collection: new CategoriesCollection( [] , { type: "colors" } ) } );
      this.vehiclesView = new CategoryView( { el: "#vehicles", collection: new CategoriesCollection( [] , { type: "vehicles" } ) } );
      Backbone.history.start();
    },

    // Backbone.js Routes
    routes: {
      "": "home",
      "category?:type": "category"
    },

    // Home method
    home: function() {
      $.mobile.changePage( "#categories" , { reverse: false, changeHash: false } );
    },

    category: function(type) {
      var currentView = this[ type + "View" ];
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        currentView.collection.fetch().done( function() {
          $.mobile.changePage( "#" + type, { reverse: false, changeHash: false } );
            } );
        }
      else {
        $.mobile.changePage( "#" + type, { reverse: false, changeHash: false } );
      }
    }
  });
  return CategoryRouter;
});
define([ "jquery","backbone", "../models/CategoryModel", "../collections/CategoriesCollection", "../views/CategoryView", "../views/HomeView"], function( $, Backbone, CategoryModel, CategoriesCollection, CategoryView, HomeView) {
  window.Page1View = Backbone.View.extend({
  
      template:_.template($('#page1').html()),
  
      render:function (eventName) {
        $(this.el).html(this.template());
        return this;
      }
  });

    var CategoryRouter = Backbone.Router.extend( {
    // The Router constructor
    initialize: function() {
      this.animalsView  = new CategoryView({el: "#animals",  collection: new CategoriesCollection([], {type: "animals"})});
      this.colorsView   = new CategoryView({el: "#colors",   collection: new CategoriesCollection([], {type: "colors"})});
      this.vehiclesView = new CategoryView({el: "#vehicles", collection: new CategoriesCollection([], {type: "vehicles"})});
      Backbone.history.start();
    },

    // Backbone.js Routes
    routes: {
      "": "home",
      "category":"category"
    },

    home:function () {
      this.changePage(new HomeView());
    },

    page1:function () {
      this.changePage(new Page1View());
    },

    category_new: function(){
      options = {collection: new CategoriesCollection([], {type: "animals"})}
      this.changePage(new CategoryView(options));
    },

    category: function() {
      var type = 'category'
      var currentView = new CategoryView({collection: new CategoriesCollection([], {type: "animals"})});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        currentView.collection.fetch().done( function() {
          //$.mobile.changePage( $(currentView.el), { reverse: false, changeHash: false } );
            } );
          currentView.render();
          $('body').append($(currentView.el));
          var transition = $.mobile.defaultPageTransition;
      // We don't want to slide the first page
      if (this.firstPage) {
          transition = 'none';
          this.firstPage = false;
      }
          $.mobile.changePage($(currentView.el), {changeHash:false, transition: $.mobile.defaultPageTransition});
        }
      else {
        $.mobile.changePage($(currentView.el), {changeHash:false, transition: $.mobile.defaultPageTransition});
      }
    },

    changePage:function (page) {
      $.mobile.loading( "show" );
      page.render();
      $('body').append($(page.el));
      var transition = $.mobile.defaultPageTransition;
      // We don't want to slide the first page
      if (this.firstPage) {
          transition = 'none';
          this.firstPage = false;
      }
      $.mobile.changePage($(page.el), {changeHash:false, transition: transition});
    }
  });
  return CategoryRouter;
});
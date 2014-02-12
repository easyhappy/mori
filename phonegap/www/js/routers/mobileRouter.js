define([ "jquery","backbone", "../models/CategoryModel", "../collections/CategoriesCollection", "../views/CategoryView" ], function( $, Backbone, CategoryModel, CategoriesCollection, CategoryView ) {
    // Extends Backbone.Router

    window.HomeView = Backbone.View.extend({

    template:_.template($('#home').html()),

    render:function (eventName) {
        $(this.el).html(this.template());
        return this;
    }
  });

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
      "page1":"page1"
    },

    home:function () {
      this.changePage(new HomeView());
    },

    page1:function () {
      console.log('#page1');
      this.changePage(new Page1View());
    },

    category: function(type) {
      var currentView = this[ type + "View" ];
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        currentView.collection.fetch({data: {page: 3}}).done( function() {
          $.mobile.changePage( "#" + type, { reverse: false, changeHash: false } );
            } );
        }
      else {
        $.mobile.changePage( "#" + type, { reverse: false, changeHash: false } );
      }
    },

    changePage:function (page) {
        $(page.el).attr('data-role', 'page');
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
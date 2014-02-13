define([ "jquery","backbone", "../models/CategoryModel", 
    "../collections/CategoriesCollection", "../views/CategoryView", 
    "../views/HomeView", '../views/BookView',
    '../collections/BooksCollection',
    '../views/ChapterView', '../collections/ChaptersCollection'], 
    function( $, Backbone, CategoryModel, 
      CategoriesCollection, CategoryView, 
      HomeView, BookView, BooksCollection,
      ChapterView, ChaptersCollection) {
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
      "category": "category",
      "books?:cid": "books",
      "chapters?:bid": "chapters"
    },

    home:function () {
      this.changePage(new HomeView());
    },

    books: function(){
      var type = 'category'
      var currentView = new BookView({collection: new BooksCollection([])});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        currentView.collection.fetch();
      }
    },

    chapters: function(){
      var type = 'category'
      var currentView = new ChapterView({collection: new ChaptersCollection([])});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        currentView.collection.fetch();
      }
    },

    category: function() {
      var type = 'category'
      var currentView = new CategoryView({collection: new CategoriesCollection([], {type: "animals"})});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        currentView.collection.fetch();
      }
    },
    activeSelector:function(selector){
      $(selector).addClass("ui-btn-active")
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
      this.activeSelector("a.home")
      $.mobile.changePage($(page.el), {changeHash:false, transition: transition});
    }

  });
  return CategoryRouter;
});
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
      "chapters?:bid": "chapters",
      "more_books": "more_books"
    },

    home:function () {
      this.changePage(new HomeView());
    },

    more_books: function(){
      var currentView = new BookView({collection: new BooksCollection([])});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        alert('jjjj')
        options = {dataType: 'json', data: {'cid': 1}};
        //_.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
        currentView.collection.fetch(options);
      }
    },

    books: function(){
      var currentView = new BookView({collection: new BooksCollection([])});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        options = {dataType: 'json', crossDomain : true, data: {}};
        _.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
        currentView.collection.fetch(options);
      }
    },

    chapters: function(){
      var type = 'category'
      var currentView = new ChapterView({collection: new ChaptersCollection([])});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        options = {data: {h: document.body.clientHeight, w: document.body.clientWidth}};
        currentView.collection.fetch(options);
      }
    },

    category: function() {
      var currentView = new CategoryView({collection: new CategoriesCollection([])});
      if(!currentView.collection.length) {
        $.mobile.loading( "show" );
        options = {dataType: 'json', data: {}};
        currentView.collection.fetch(options);
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
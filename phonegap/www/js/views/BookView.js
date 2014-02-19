define([ "jquery", "backbone","models/BookModel", "collections/BooksCollection", "views/BaseView"], function( $, Backbone, BookMode, BooksCollection,  BaseView) {
  var BookView = Backbone.View.extend(BaseView).extend({
    initialize: function(){
      //参数this的作用是什么？
      this.template = _.template($('#books').html());
      this.collection.on("added", this.render, this);
    },

    render: function(){
      if(arguments[0].more !='true'){
        this.$el.html(this.template());
        var categoryView = _.template($('#BookItems').html(), {collection: this.collection})
        this.$el.find("ul.category").append(categoryView);
        $('body').append($(this.el));
        $('a.category').addClass("ui-btn-active")
        $('#category_name').html(arguments[0]['category_name'])
        this.$el.find("ul.category").attr('data-page', arguments['0']['page'])
        this.$el.find("ul.category").attr('data-cid',  arguments['0']['cid'])
        $.mobile.changePage($(this.el), {swipeleft: true, reverse: false, changeHash:false, transition: $.mobile.defaultPageTransition});  
      }else{
        var categoryView = _.template($('#BookItems').html(), {collection: this.collection})
        $("ul.category").append(categoryView);
        $('a.category').addClass("ui-btn-active")
        $('#category_name').html(arguments[0]['category_name'])
        $("ul.category").attr('data-page', arguments['0']['page'])
        $("ul.category").attr('data-cid',  arguments['0']['cid'])
        $("ul.category").listview("refresh")
        var self = this 
        this.$el.find('#more_books').click(function(){
          self.more_books();
        });
      }
      this.removeLastView();
      return this;
    },

    more_books: function(){
      var currentView = new BookView({collection: new BooksCollection([])});
      if(!currentView.collection.length) {
        options = {dataType: 'json', data: {'cid': 1}};
        //options[data]['page'] = 
        options['data']['more'] = true
        options['data']['page'] = $('ul.category').last().attr('data-page')
        //_.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
        var self = this;
        currentView.collection.fetch(options).done(function(){
          $('#more_books').click(function(){
          self.more_books();
        });
        });;
      }
    },
  });
  // Returns the View class
  return BookView;
});
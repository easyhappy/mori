define([ "jquery", "backbone","models/BookModel", "collections/BooksCollection", "views/BaseView"], 
  function( $, Backbone, BookMode, BooksCollection,  BaseView) {
  var BookView = Backbone.View.extend(BaseView).extend({
    initialize: function(){
      this.template = _.template($('#books').html());
      this.collection.on("added", this.render, this);
    },

    render: function(){
      if(arguments[0].more !='true'){
        this.$el.html(this.template());
        var bookView = _.template($('#BookItems').html(), {collection: this.collection})
        this.$el.find("ul.category").append(bookView);
        $('body').append($(this.el));
        $('a.category').addClass("ui-btn-active")
        $('#category_name').html(arguments[0]['category_name'])
        this.$el.find("ul.category").attr('data-page', arguments[0]['page'])
        this.$el.find("ul.category").attr('data-cid',  arguments[0]['cid'])
        $.mobile.changePage($(this.el), {changeHash:false});
      }else{
        var bookView = _.template($('#BookItems').html(), {collection: this.collection})
        $("ul.category").append(bookView);
        $("ul.category").attr('data-page', arguments[0]['page']);
        $("ul.category").listview("refresh");
      }
      this.removeLastView();
      return this;
    },
  });

  return BookView;
});
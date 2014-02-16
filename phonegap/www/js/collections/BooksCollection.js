define([ "jquery","backbone","models/BookModel",
 "collections/BaseCollection"], 
  function( $, Backbone, BookModel, BaseCollection) {
  var Collection = Backbone.Collection.extend(BaseCollection).extend( {
    model: BookModel,
    url:   function(){
      return this.baseUrl() + "/books";
    },
  });
  return Collection;
});

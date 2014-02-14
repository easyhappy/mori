define([ "jquery","backbone",
  "models/ChapterModel", 'collections/BaseCollection'],
  function( $, Backbone, ChapterModel, BaseCollection) {
  var Collection = Backbone.Collection.extend(BaseCollection).extend( {
    model: ChapterModel,
    url: function(){
      //return 'http://192.168.1.102:3000/api/categories';
      return this.baseUrl() + '/chapters';
    },

    parse: function(response){
      var count = 0;
      var self = this;
      _.each(response.data, function(item){
        self.models[count] = new self.model(item);
        count += 1;
      });
      //$('#category_test').attr("top", response.top)
      this.trigger("added", response.top, response.height, response.position);
    },
  });
  return Collection;
});
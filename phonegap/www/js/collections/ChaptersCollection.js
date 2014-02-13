define([ "jquery","backbone",
  "models/ChapterModel", 'collections/BaseCollection'],
  function( $, Backbone, ChapterModel, BaseCollection) {
  var Collection = Backbone.Collection.extend(BaseCollection).extend( {
    model: ChapterModel,
    url: function(){
      //return 'http://192.168.1.102:3000/api/categories';
      return this.baseUrl() + '/chapters';
    },

    parse: function(chapters){
      var count = 0;
      var self = this;
      _.each(chapters, function(item){
        self.models[count] = new self.model(item);
        count += 1;
      });
      this.trigger("added");
    },
  });
  return Collection;
});
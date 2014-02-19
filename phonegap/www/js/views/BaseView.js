define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    initialize: function(){
      this.collection.on("added", this.render, this);
    },

    removeLastView: function() {
      while($('.ui-page').size() > 2){
        $('.ui-page').first().remove();
      }
      return this;
    }
  }
  return Mixin;
})
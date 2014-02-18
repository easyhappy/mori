define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    removeLastView: function() {
      while($('.ui-page').size() > 2){
        $('.ui-page').first().remove();
      }
      return this;
    }
  }
  return Mixin;
})
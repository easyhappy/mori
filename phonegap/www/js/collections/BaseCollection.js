define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    baseUrl: function(){
      return 'http://www.5ireading.com/api';
    }
  }
  return Mixin;
})

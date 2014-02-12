define([ "jquery", "backbone"], function($, Backbone){
  var HomeView = Backbone.View.extend({
    template: _.template($('#home').html()),
    
    render:function (eventName) {
      $(this.el).html(this.template());
      return this;
    }
  });
  return HomeView;
});
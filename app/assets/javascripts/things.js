// AJAX call to get our list of things
window.loadThingsPage = function() {
  $.ajax({
      type: 'GET', 
      url: 'http://localhost:3000/things.json', 
      dataType: 'json'
  }).done(function(data) {
    
      // grabs the template we're going to use
      var source = $("#things-template").html();

      // compiles it with Handlebars (pops content from things into thing-template)
      var template = Handlebars.compile(source);

      // displays compiled template with things in a div called content
      $('#content').html(template(data));
  })
};

// AJAX call to get our single thing
window.loadThingPage = function() {
  $(function() {
    $.get(window.location.href + '.json', function(data) {

      // Sets the yellow gradient width behind the "average rating" star block
      data.thing.ratingWidth = data.thing.average_rating * 20;

      // Helper for date format
      Handlebars.registerHelper("formatDate", function(datetime) {
        return $.format.date(datetime, "ddd, MMM d, yyyy h:mm a").replace(/^([\w]{3})[\w]+(.*)$/, '$1$2');
      });

      // Helper for yellow gradient width behind each rating star block
      Handlebars.registerHelper('starWidth', function(rating) {
        return rating * 20;
      });
      
      // Radio button configuration (because Handlebars won't allow == in an #if)
      data.thing.buttons = [
        { checked: data.thing.current_user_opinion.rating == 1, class: 'one', value: 1},
        { checked: data.thing.current_user_opinion.rating == 2, class: 'two', value: 2},
        { checked: data.thing.current_user_opinion.rating == 3, class: 'three', value: 3},
        { checked: data.thing.current_user_opinion.rating == 4, class: 'four', value: 4},
        { checked: data.thing.current_user_opinion.rating == 5, class: 'five', value: 5}
      ];

      // grabs the template we're going to use
      var source = $("#thing-template").html();

      // compiles it with Handlebars (pops content from things into thing-template)
      var template = Handlebars.compile(source);

      // displays compiled template with things in a div called content
      $('body').html(template(data)); 
    });
  });
};

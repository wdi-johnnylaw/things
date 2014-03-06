Handlebars.registerHelper('formatTime', function(time) {
 return $.format.date(time, "ddd, MMM d, yyyy h:mm a").replace(/^([\w]{3})[\w]+(.*)$/, '$1$2')
});

Handlebars.registerHelper('starWidth', function(rating) {
 return rating * 20;
});

Handlebars.registerHelper('truncateURL', function(url) {
 return url.replace(/\.json$/, '');
});

Handlebars.registerHelper('opinionFormBanner', function(isNew) {
  if(isNew) {
    return "Please share your opinion";
  } else {
    return "Change of heart? Update your opinion";
  }
});

Handlebars.registerPartial("starsSpan", $("#stars-span-partial").html());

Handlebars.setOpinionButtons = function(opinion) {
  opinion.buttons = [
      {klass: 'one', value: 1, checked: opinion.rating == 1},
      {klass: 'two', value: 2, checked: opinion.rating == 2},
      {klass: 'three', value: 3, checked: opinion.rating == 3},
      {klass: 'four', value: 4, checked: opinion.rating == 4},
      {klass: 'five', value: 5, checked: opinion.rating == 5},
    ];
};

window.loadThingPage = function() {
  $.get(window.location.href + '.json', function(data) {
    data.thing.current_user_opinion.form_authenticity_token = data.form_authenticity_token;
    var template = Handlebars.compile($('#thing-template').html());
    $('#content').html(template(data.thing));

    Handlebars.setOpinionButtons(data.thing.current_user_opinion);
    template = Handlebars.compile($('#opinion-form-template').html());
    $('#opinion-form-container').html(template(data.thing.current_user_opinion));

    template = Handlebars.compile($('#opinion-list-item').html());
    $('ul.opinions-list').html('');
    $.each(data.thing.opinions, function() {
      $('ul.opinions-list').append(template(this));
    });
  });
};

window.loadThingsPage = function() {
  // AJAX call to get our list of things
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
  });
};
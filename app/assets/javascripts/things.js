Handlebars.registerHelper('formatTime', function(time) {
 return $.format.date(time, "ddd, MMM d, yyyy h:mm a").replace(/^([\w]{3})[\w]+(.*)$/, '$1$2')
});

Handlebars.registerHelper('starWidth', function(rating) {
 return rating * 20;
});

Handlebars.registerHelper('formAuthenticityToken', function() {
  return window.formAuthenticityToken;
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

Handlebars.render = function(templateSelector, data, containerSelector) {
  var template = Handlebars.compile($(templateSelector).html());
  $(containerSelector).html(template(data));
};

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
  Handlebars.registerPartial('starsSpan', $('#stars-span-partial').html());
  Handlebars.registerPartial('opinionFormPartial', $('#opinion-form-template').html());
  Handlebars.registerPartial('opinionListPartial', $('#opinion-list-item').html());
  ThingsApp.ajaxLoadPageData().done(function(data) {
    Handlebars.setOpinionButtons(data.thing.current_user_opinion);
    var template = Handlebars.compile($('#thing-template').html());
    $('#content').html(template(data.thing));
  });
};

window.loadThingsPage = function() {
  ThingsApp.ajaxLoadPageData().done(function(data) {
    Handlebars.render('#things-template', data, '#content');
  });
};

$(document.body).on('submit', 'form#current-user-opinion', function(event) {
   event.preventDefault();
   $(this).ajaxSubmitForm().done(function(data) {
      var opinion = data.opinion;
      Handlebars.render('#stars-span-partial', opinion.thing, '#thing-' + opinion.thing.id + '-average-rating');

      Handlebars.setOpinionButtons(data.opinion);
      Handlebars.render('#opinion-form-template', opinion, '#opinion-form-container');

      template = Handlebars.compile($('#opinion-list-item').html());
      var opinionHTML = template(opinion);
      $('li#opinion-' + opinion.id).remove();
      $('ul.opinions-list').prepend(opinionHTML);
      $('li#opinion-' + opinion.id).hide().show(500);
   });
});

window.loadThingPage = function() {
  $.get(window.location.href + '.json', function(data) {
    var thing = data.thing;

    // Set name into h1 tag
    $('h1 span.name').html(thing.name);

    // Set the description
    $('p.thing-description').html(thing.description);

    // Set up the image tag
    $('img.thing-image').prop({ src: thing.image_url, alt: thing.name, title: thing.name })

    // // Set width on average rating span inside h1 tag
    var averageRating = thing.average_rating * 20;
    $('h1 span.star-rating span').css('width', averageRating + '%')

    // Populate ul.opinion-list with thing's opinions
    $.each(thing.opinions, function() {
      var ratingPercentage = this.rating * 20;
      var opinionCreatedAt = $.format.date(this.created_at, "ddd, MMM d, yyyy h:mm a").replace(/^([\w]{3})[\w]+(.*)$/, '$1$2')

      var opinionHTML = '<li id="opinion-' + this.id + '"><span class="star-rating prior"><span style="width:' + ratingPercentage + '%"></span></span><span class="opinion-created-at">' + opinionCreatedAt + '</span><q>' + this.comment + '</q><cite>&mdash;' + this.username + '</cite></li>';
      $('ul.opinions-list').append(opinionHTML);
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
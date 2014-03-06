$(function() {
   $(document.body).on('submit', 'form#current-user-opinion', function() {
      event.preventDefault();
      var $form = $(this);
      $.ajax({
         url: $form.prop('action'),
         type: 'post',
         dataType: 'json',
         data: $form.serialize()
      }).done(function(data) {
         data.opinion.form_authenticity_token = data.form_authenticity_token;
         var template = Handlebars.compile($('#stars-span-partial').html());
         $('#thing-' + data.opinion.thing.id + '-average-rating').html(template(data.opinion.thing));

         template = Handlebars.compile($('#opinion-form-template').html());
         Handlebars.setOpinionButtons(data.opinion);
         $('#opinion-form-container').html(template(data.opinion));

         template = Handlebars.compile($('#opinion-list-item').html());
         var opinionHTML = template(data.opinion);
         $('li#opinion-' + data.opinion.id).remove();
         $('ul.opinions-list').prepend(opinionHTML);
         $('li#opinion-' + data.opinion.id).hide().show(500);
      });
   });
});
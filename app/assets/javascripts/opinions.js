$(function() {
   $('form#current-user-opinion').submit(function() {
      event.preventDefault();
      var $form = $(this);
      $.ajax({
         url: $form.prop('action'),
         type: 'post',
         dataType: 'json',
         data: $form.serialize()
      }).done(function(data) {
         var opinion = data.opinion;
         var ratingPercentage = opinion.rating * 20;
         var opinionCreatedAt = $.format.date(opinion.created_at, "ddd, MMM d, yyyy h:mm a").replace(/^([\w]{3})[\w]+(.*)$/, '$1$2')

         var opinionHTML = '<li id="opinion-' + opinion.id + '"><span class="star-rating prior"><span style="width:' + ratingPercentage + '%"></span></span><span class="opinion-created-at">' + opinionCreatedAt + '</span><q>' + opinion.comment + '</q><cite>&mdash;' + opinion.username + '</cite></li>';
         var $list = $('ul.opinions-list');
         var $existingItem = $list.find('li#opinion-' + opinion.id);
         if($existingItem.length > 0) {
            $existingItem.remove();
         }
         $('ul.opinions-list').prepend(opinionHTML);
      });
   });
});
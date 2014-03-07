// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// Do not require jquery here; do it above, since this manifest is being included in the body,
//     apparently
// require jquery
//
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

window.ThingsApp = {
  ajaxLoadPageData: function(url) {
    return $.ajax({
      type: 'GET',
      url: url || (window.location.href + '.json'),
      dataType: 'json'
    }).done(function(data) {
      window.formAuthenticityToken = data.form_authenticity_token;
    });
  }
}

$.fn.ajaxSubmitForm = function(options) {
  var $form = $(this);
  return $.ajax({
    type: 'POST',
    url: $form.prop('action'),
    dataType: 'json',
    data: $form.serialize(),
  }).done(function(data) {
    window.formAuthenticityToken = data.form_authenticity_token;
  });
};

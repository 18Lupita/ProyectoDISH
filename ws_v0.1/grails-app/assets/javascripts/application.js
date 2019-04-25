// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery.min
//= require jquery.print
//= require jquery-ui.min
//= require bootstrap
//= require jquery.alphanum
//= require jquery.mask
//= require jquery.limitkeypress
//= require select2/select2.min
//= require select2/i18n/es.js
//= require sweetalert2.min
//= require core
//= require amaran/jquery.amaran.min.js
//= require switchery/switchery.min
//= require jquery.simplyCountable
//= require date.format
//= require_self

if (typeof jQuery !== 'undefined') {
    (function($) {
        $('#spinner').ajaxStart(function() {
            $(this).fadeIn();
        }).ajaxStop(function() {
            $(this).fadeOut();
        });
    })(jQuery);
}

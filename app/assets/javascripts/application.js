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
//= require underscore
//= require gmaps/google
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require autocomplete-rails
//= require foundation
//= require_tree .


$(function(){ $(document).foundation(); });

function displayOnMap(lat,lng){
handler = Gmaps.build('Google');
handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
  markers = handler.addMarkers([
    {
      "lat": lat,
      "lng": lng,
    }
  ]);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
  handler.getMap().setZoom(17);
});
};


// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});

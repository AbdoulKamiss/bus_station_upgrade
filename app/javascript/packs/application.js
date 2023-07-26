// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
function initMap() {
  const latitude = parseFloat(document.getElementById('latitude').value);
  const longitude = parseFloat(document.getElementById('longitude').value);
  const latitude2 = parseFloat(document.getElementById('latitude2').value);
  const longitude2 = parseFloat(document.getElementById('longitude2').value);
  const locations = [
    { lat: latitude, lng: longitude },
    { lat: latitude2, lng: longitude2 }
  ];

  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 6,
    center: locations[0],
  });

  const directionsService = new google.maps.DirectionsService();
  const directionsRenderer = new google.maps.DirectionsRenderer({
    map: map,
  });

  const origin = new google.maps.LatLng(latitude, longitude);
  const destination = new google.maps.LatLng(latitude2, longitude2);

  const request = {
    origin: origin,
    destination: destination,
    travelMode: google.maps.TravelMode.DRIVING,
  };

  directionsService.route(request, (result, status) => {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsRenderer.setDirections(result);
    }
  });

  for (const location of locations) {
    const marker = new google.maps.Marker({
      position: location,
      map: map,
    });
  }
}

window.initMap = initMap;

  
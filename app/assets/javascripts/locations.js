// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



//function myMapBuilder() {


var map;
var polyLine;

function initialize() {
  var mapOptions = {
    zoom: 7,
    // Center the map on Chicago, USA.
    center: new google.maps.LatLng(43.0512606, -75.40397089999999)
  };

  map = new google.maps.Map(document.getElementById('map'), mapOptions);
  
  //alert(gon.latLngs);
  for (obj in gon.latLngs) {
  	//alert(gon.latLngs[obj]);
  	var marker = new google.maps.Marker({
  		position : new google.maps.LatLng(gon.latLngs[obj][0], gon.latLngs[obj][1]),
  		map : map,
  		draggable : true
  	});
  }

  var drawingManager = new google.maps.drawing.DrawingManager({
    drawingMode: google.maps.drawing.OverlayType.POLYLINE,
    drawingControl: true,
    drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: [
          google.maps.drawing.OverlayType.MARKER,
          google.maps.drawing.OverlayType.POLYLINE
        ]
    },
    polylineOptions: { geodesic: true }
  });
  

  drawingManager.setMap(map);
  
  google.maps.event.addListener(drawingManager, 'polylinecomplete', movePolyLine);
  
  //google.maps.event.addListener(map, 'drag', drawPath);
}
  

function movePolyLine(event) {
  //var line = event;
  //alert("click to continue!");
  event.setOptions({strokeColor: '#0000FF'});
//  event.visible = false;
  //strokeColor: '#0000FF');
}


function drawPath(event) {
  var path = polyLine.getPath();

  path.push(event.latLng);

  var marker = new google.maps.Marker({
    position : event.latLng,
    map : map
  });

}


//google.maps.event.addDomListener(window, 'load', initialize);


/*
	handler = Gmaps.build('Google');
	handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
		//handler.centerOn([-77.085246, 38.978694]);
		//alert(gon.json);
		markers = handler.addMarkers(gon.json, {draggable : true});
	  	/*markers = handler.addMarkers(
	  	[
    	{
      	"lat": 43.0500184,
      	"lng": -75.3786691,
      	//"picture": {
        //"url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
        //"width":  36,
        //"height": 36
      	//},
      	"infowindow": "hello!"
    	}
  	]
  
  	);
  	

 	handler.bounds.extendWith(markers);
  	handler.fitMapToBounds();
	});
*/
//}

//$(function () { myMapBuilder(); });
$(function () { initialize(); });
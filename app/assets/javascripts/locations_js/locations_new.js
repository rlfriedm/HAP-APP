//= require gmaps/google

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



//function myMapBuilder() {


var map;
var polyLine;

function initialize() {
  var mapOptions = {
    zoom: 9,
    // Center the map on Chicago, USA.
    center: new google.maps.LatLng(43.9829194, -74.4593776),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  map = new google.maps.Map(document.getElementById('newmap'), mapOptions);
  
  //alert(gon.latLngs);
  for (obj in gon.latLngs) {
  	//alert(gon.latLngs[obj]);
  	var marker = new google.maps.Marker({
  		position : new google.maps.LatLng(gon.latLngs[obj][0], gon.latLngs[obj][1]),
  		map : map,
  		draggable : true
  	});
  }

  var linepath;
/*
  for (var i = 0; i < gon.paths.length; i++) {
    linepath = [];
    for (var j = 0; j < gon.paths[i].length; j++) {
      //alert(gon.paths[i][j]);
      linepath[linepath.length] = new google.maps.LatLng(gon.paths[i][j][0], gon.paths[i][j][1]); 
    }
    var line = new google.maps.Polyline({
      path : linepath,
      map : map,
      strokeColor : '#006400'
    });
  }
  */
  //alert(path);

  

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
    polylineOptions: { geodesic: true,
                       editable: true }
  });
  

  drawingManager.setMap(map);
  
  google.maps.event.addListener(drawingManager, 'polylinecomplete', movePolyLine);
  
  //google.maps.event.addListener(map, 'drag', drawPath);
}
  

function movePolyLine(event) {
  //var line = event;
  //alert("click to continue!");
  var pathArray = event.getPath().getArray();
  var start = pathArray[0];
  var end = pathArray[pathArray.length-1];

  var array = []
  for (var i = 0; i < pathArray.length; i++) {
    array[array.length] = [pathArray[i].lat(), pathArray[i].lng()];

  }
  alert(array);
  $('#location_startLat').val(start.lat());
  $('#location_startLng').val(start.lng());
  $('#location_endLat').val(end.lat());
  $('#location_endLng').val(end.lng());
  alert(JSON.stringify(array));
  $('#location_path').val(JSON.stringify(array));
  event.setOptions({strokeColor: '#006400'});
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
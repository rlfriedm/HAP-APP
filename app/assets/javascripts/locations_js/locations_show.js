//= require gmaps/google

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



//function myMapBuilder() {


var map;
var polyLine;
var line;
function initialize() {
  var mapOptions = {
    zoom: 9,
    // Center the map on the Adirondaks
    center: new google.maps.LatLng(43.9829194, -74.4593776),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  map = new google.maps.Map(document.getElementById('showmap'), mapOptions);
  
  //alert(gon.latLngs);
 
  var start;

  var linepath = [];
  var ary = JSON.parse(gon.path);
  //alert(ary);
  var northmost = ary[0][0];
  var southmost = ary[0][0]; 
  var eastmost = ary[0][1];
  var westmost = ary[0][1];



  var sw = new google.maps.LatLng(southmost, westmost);
  var ne = new google.maps.LatLng(northmost, eastmost);

  start = sw;

  var bounds = new google.maps.LatLngBounds(sw, ne);
  map.fitBounds(bounds);
  //alert(ary);

  for (var j = 0; j < ary.length; j++) {
      //alert(gon.paths[i][j]);
    var lat = ary[j][0];
    var lang = ary[j][1];
/*
    if (lat > northmost)
      northmost = lat;
    if (lat < southmost)
      southmost = lat;

    if (lang < westmost)
      westmost = lang;
    if (lang > eastmost)
      eastmost = lang;
*/
    linepath[linepath.length] = new google.maps.LatLng(ary[j][0], ary[j][1]); 
    sw = new google.maps.LatLng(southmost, westmost);
    ne = new google.maps.LatLng(northmost, eastmost);

    bounds.extend(new google.maps.LatLng(lat, lang));
  }
  line = new google.maps.Polyline({
    path : linepath,
    map : map,
    strokeColor : '#006400',
    editable : false
  });

  //var beginArrow = new google.maps.

  var end = new google.maps.LatLng(ary[ary.length-1][0], ary[ary.length-1][1]);

  var endMarker = new google.maps.Marker({
    position : end,
    map : map,
    icon : "/assets/EndArrow.png"
  });

  var startMarker = new google.maps.Marker({
    position : start,
    map : map,
    icon : "/assets/BeginArrow.png"
  });

  google.maps.event.addListener(startMarker, 'mouseover', function() {
    //infowindow.open(map);
    startMarker.setZIndex(1);
    endMarker.setZIndex(0);
  });

  google.maps.event.addListener(endMarker, 'mouseover', function() {
    //infowindow.open(map);
    endMarker.setZIndex(1);
    startMarker.setZIndex(0);
  });
  //alert(southmost);
  //alert(northmost);
  //var sw = new google.maps.LatLng(southmost, westmost);
  //var ne = new google.maps.LatLng(northmost, eastmost);

  //map.fitBounds();  
  /*
  var drawingManager = new google.maps.drawing.DrawingManager({
    drawingControl: true,
    drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: [
        ]
    },
    polylineOptions: { geodesic: true,
                       editable: true }
  });
  

  drawingManager.setMap(map);

  google.maps.event.addListener(line.getPath(), 'set_at', movePolyLine); //function() //{
  google.maps.event.addListener(line.getPath(), 'insert_at', movePolyLine); //function() //{ 
//    google.maps.event.addListener(line.getPath(), 'set_at', movePolyLine);
  //  google.maps.event.addListener(line.getPath(), 'insert_at', movePolyLine);
  //});
  
  //google.maps.event.addListener(map, 'drag', drawPath);
  */
}
  

function movePolyLine(event) {
  //var line = event;
  //alert("click to continue!");
  //alert(event);
  //alert(line.getPath().getArray());
  var pathArray = line.getPath().getArray();
  var start = pathArray[0];
  var end = pathArray[pathArray.length-1];

  var array = []
  for (var i = 0; i < pathArray.length; i++) {
    array[array.length] = [pathArray[i].lat(), pathArray[i].lng()];

  }
  //alert(array);
  
  $('#trail_location_startLat').val(start.lat());
  $('#trail_location_startLng').val(start.lng());
  $('#trail_location_endLat').val(end.lat());
  $('#trail_location_endLng').val(end.lng());
  //alert(JSON.stringify(array));
  $('#trail_location_path').val(JSON.stringify(array));
  
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
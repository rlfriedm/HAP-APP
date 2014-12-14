//= require gmaps/google

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



//function myMapBuilder() {


var map;
var polyLine;
var currentWindow;

function initialize() {
  var mapOptions = {
    zoom: 9,
    // Center the map on Chicago, USA.
    center: new google.maps.LatLng(43.9829194, -74.4593776),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  map = new google.maps.Map(document.getElementById('indexmap'), mapOptions);
  
  //alert(gon.latLngs);
  /*for (obj in gon.latLngs) {
  	//alert(gon.latLngs[obj]);
  	var marker = new google.maps.Marker({
  		position : new google.maps.LatLng(gon.latLngs[obj][0], gon.latLngs[obj][1]),
  		map : map,
  		draggable : true
  	});
  }*/
  currentWindow = null;

  var linepath;
  var ary;

  var bounds = new google.maps.LatLngBounds();
  var northmost, southmost, eastmost, westmost, sw, ne;
  
  for (var i = 0; i < gon.paths.length; i++) {
    linepath = [];
    ary = JSON.parse(gon.paths[i]);
    
    northmost = ary[0][0];
    southmost = ary[0][0]; 
    eastmost = ary[0][1];
    westmost = ary[0][1];

    sw = new google.maps.LatLng(southmost, westmost);
    ne = new google.maps.LatLng(northmost, eastmost);
    //if (bounds.isEmpty())
      //bounds = new google.maps.LatLngBounds(sw, ne);

    for (var j = 0; j < ary.length; j++) {
      //alert(gon.paths[i][j]);

      var lat = ary[j][0];
      var lang = ary[j][1];

      if (lat > northmost)
        northmost = lat;
      if (lat < southmost)
        southmost = lat;

      if (lang < westmost)
        westmost = lang;
      if (lang > eastmost)
        eastmost = lang;
      bounds.extend(new google.maps.LatLng(ary[j][0], ary[j][1]));
      linepath[linepath.length] = new google.maps.LatLng(ary[j][0], ary[j][1]); 

      
    }

    sw = new google.maps.LatLng(southmost, westmost);
    ne = new google.maps.LatLng(northmost, eastmost);
    //alert(bounds.toUrlValue())
    //bounds = bounds.union(new google.maps.LatLngBounds(sw, ne)); 
    

    var line = new google.maps.Polyline({
      path : linepath,
      map : map,
      strokeColor : '#006400',
      strokeWeight : 3
    });

    //alert(gon.infos[i]["trail_id"]);

    var name = gon.infos[i]["name"],
    rating = (gon.infos[i]["rating"] === null ? "N/A" : gon.infos[i]["rating"].toString()),
    description = gon.infos[i]["description"],
    trail_id = gon.infos[i]["trail_id"].toString();


    var contentString = '<div id="content">' +
      '<h1 id="trailName"><a href="/trails/' + trail_id + '">' + name + '</a></h1>' +
      '<h2 id="trailRating">Rating: ' + rating + '</h2>' +
      '<div id="trailDescription">' +
      '<p>' + description + '</p>' +
      '<a href="/trails/' + trail_id + '">Go to trail page</a>' +
      '</div>' + 
      '</div>';

    var infowindow = new google.maps.InfoWindow({
      position : linepath[0],
      content : contentString,
      maxWidth : 200
    });

    addListeners(line, infowindow);
    addDomListeners(trail_id, line, infowindow);
    
  }
  //alert(bounds.toUrlValue());
  if (gon.paths.length > 0)
    map.fitBounds(bounds);
}


function addDomListeners(trail_id, line, infowindow) {

    //alert("trail_" + trail_id);

    var trailRow = document.getElementById("trail_" + trail_id);
    var color = window.getComputedStyle(trailRow, null).getPropertyValue("background-color");
    trailRow.style.backgroundColor = color;
    //alert(color);
    trailRow.addEventListener('mouseenter', function() {
      //infowindow.open(map);
      line.setOptions({strokeWeight: 5});

      if (currentWindow !== null) currentWindow.close();

      infowindow.open(map);
      currentWindow = infowindow;
      trailRow.style.backgroundColor = "DarkGreen";
      trailRow.style.color = 'white';
    });

    trailRow.addEventListener('mouseleave', function() {
      currentWindow.close();
      line.setOptions({strokeWeight: 3});
      currentWindow = null;
      trailRow.style.backgroundColor = color;
      trailRow.style.color = 'black';
    });
}

function addListeners(line, infowindow) {

  google.maps.event.addListener(line, 'mouseover', function() {
    //infowindow.open(map);
    line.setOptions({strokeWeight: 5});
  });

  google.maps.event.addListener(line, 'mouseout', function() {
    //infowindow.close();
    line.setOptions({strokeWeight: 3});
  });

  google.maps.event.addListener(line, 'click', function() {
    if (currentWindow !== null) currentWindow.close();

    infowindow.open(map);
    currentWindow = infowindow;
  });

  google.maps.event.addListener(infowindow, 'closeclick', function() {
    currentWindow = null;
  });
}
  //alert(path);

  
/*
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
  */
  //google.maps.event.addListener(map, 'drag', drawPath);

  

function movePolyLine(event) {
  //var line = event;
  //alert("click to continue!");
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
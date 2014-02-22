var request = require('request');
var fs = require('fs');


getRoute('http://runkeeper.com/user/1326910888/route');


function getRoute(url) {
    request(url, function(error, response, body) {
        if (!error && response.statusCode == 200) {
            var start = body.indexOf('var routePoints =');
            var end = body.indexOf('];', start);
            console.log("Start: " + start + "End: " + end);

            var route = body.substring(start + 18, end + 1);
            var jsonRoute = JSON.parse(route);

            var geojsonRoute = convertToGeojsonLine(jsonRoute);
            writeToFile('route.json', JSON.stringify(geojsonRoute));

        } else {
            console.log(error);

        }
    });
}

function writeToFile(fileName, content) {
    fs.writeFile("./routes/" + fileName, content, function(err) {
        if (err) {
            console.log(err);
        } else {
            console.log("The file was saved!");
        }
    });
}


function convertToGeojsonLine(route) {
    var geojsonRoute = {
        "type": "Feature",
        "properties": {},
        "geometry": {
            "type": "LineString",
            "coordinates": []
        }
    };

    route.forEach(function(routeSegment) {
        geojsonRoute.geometry.coordinates.push([routeSegment.longitude, routeSegment.latitude]);
    });

    return geojsonRoute;

}

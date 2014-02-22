var request = require('request');
var fs = require('fs');

var routesUrls = require('../runscraper/routes.json');

var geojsonCollection = {
    "type": "FeatureCollection",
    "features": []
};

var lastRequest = false;


//getRoute('http://runkeeper.com/user/1326910888/route');
getRouteUrls();

function getRouteUrls() {
    for (var i = 0; i < routesUrls.routes.length; i++) {
        if (i == routesUrls.routes.length - 1) {
            getRoute(routesUrls.routes[i].href, true);

        } else {
            getRoute(routesUrls.routes[i].href, false);
        }


    }


}


function getRoute(url, last) {
    request('http://runkeeper.com' + url, function(error, response, body) {
        if (!error && response.statusCode === 200) {
            var start = body.indexOf('var routePoints =');
            var end = body.indexOf('];', start);
            console.log("Start: " + start + "End: " + end);

            if (start !== -1) {
                var route = body.substring(start + 18, end + 1);
                var jsonRoute = JSON.parse(route);

                var geojsonRoute = convertToGeojsonLine(jsonRoute);
                geojsonCollection.features.push(geojsonRoute);

                if (last) {
                    writeToFile('route.json', JSON.stringify(geojsonCollection));
                }
            }

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

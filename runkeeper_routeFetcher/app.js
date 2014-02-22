var request = require('request');
var fs = require('fs');


request('http://runkeeper.com/user/1326910888/route', function(error, response, body) {
    if (!error && response.statusCode == 200) {
        var start = body.indexOf('var routePoints =');
        var end = body.indexOf('];', start);
        console.log("Start: " + start + "End: " + end);

        var route = body.substring(start + 18, end + 1);
        writeToFile("route.json", route);
    } else {
        console.log(error);

    }
});

function writeToFile(fileName, content){
	fs.writeFile("./routes/"+fileName, content, function(err) {
    if(err) {
        console.log(err);
    } else {
        console.log("The file was saved!");
    }
}); 
}


process.chdir(__dirname);

var fs = require ("fs");
var service = require ("os-service");
const path = require('path');

function usage () {
	console.log ("usage: node service --add");
	console.log ("       node service --remove");
	console.log ("       node service --run");
	process.exit (-1);
}

if (process.argv[2] == "--add") {
	var options = {
        name: "Cloudbeat Agent",
        nodePath: path.join(__dirname, "nodejs", "node.exe"),
        programPath: path.join(__dirname, "main.js"),
		programArgs: [process.argv[3], process.argv[4]]


	};

	service.add ("Cloudbeat Agent", options, function(error) {
		if (error)
			console.log(error.toString());
	});


} else if (process.argv[2] == "--remove") {

	service.remove ("Cloudbeat Agent", function(error) {
		if (error)
			console.log(error.toString());
	});


} else {
	usage ();
}

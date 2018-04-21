var http = require('http');
var os = require('os');
var server = http.createServer(function (req, res) {
  res.writeHead(200);
  res.end('Hello Kubernetes! 2.0 - ' +os.hostname());
});

server.listen(8080);

console.log("Server running at http://127.0.0.1:8080/");

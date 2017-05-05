var http = require('http');
var url=require('url');
var os = require('os');

var start = Date.now();
var server = http.createServer(function (req, res) {
    var pathname = url.parse(req.url).pathname;
    switch(pathname){
    case '/healthz':
        duration =  Math.abs(Date.now() - start);
        if (duration > 60000) {
            res.writeHead(500);
            res.end('Error: '+duration+'ms');
        } else {
            res.writeHead(200);
            res.end('Ok');
        }
        break;
    default:
        res.writeHead(200);
        res.end('Hello Kubernetes! 1.0 - ' +os.hostname());
        break;
    }
});

server.listen(8080);

console.log("Server running at http://127.0.0.1:8080/");
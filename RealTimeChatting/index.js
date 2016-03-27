var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res) {
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){
	console.log('a user connected');
	socket.on('disconnect', function() {
		console.log('user disconnected');
	});

	socket.on('connectUser', function(nickname) {
		console.log(nickname, " connected");
	});
	socket.on('chatMessage', function(nickname, message) {
		console.log(message)
    var currentDateTime = new Date().toLocaleString();
    io.emit('chatMessage', nickname, message, currentDateTime)
	})
});

http.listen(3000, function() {
    console.log('listening on *:3000');
});


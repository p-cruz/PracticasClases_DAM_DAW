var http= require('http');

var server = http.createServer(function(req, res){
    console.log(req.url);
    if (req.url == '/'){
        res.setHeader('Content-Type', 'text/html');
        res.end('<html><head><link rel="stylesheet" type="text/css" href="estilos.css" /></head><body><h1>Bienvenido a la página principal</h1><h2>teclea /uno o /dos para pedir los json correspondientes</h2></body></html>');
    }else if (req.url == '/uno'){
        res.setHeader('Content-Type', 'application/json');
        res.end('{"nombre":"Juan","edad":30}');
    }else if (req.url == '/dos'){
        res.setHeader('Content-Type', 'application/json');
        res.end('{"nombre":"Ana","edad":25}');
    }else if (req.url == '/estilos.css'){
        res.setHeader('Content-Type', 'text/css');
        res.end('h1{color:red;}');
    }



/*    res.setHeader('Content-Type', 'text/html');
    res.end('<h1>Hola Mundo</h1>');*/
});
console.log('Servidor escuchando por el puerto 3000')
server.listen(3000);
var http= require('http');
var fs = require('fs');

var server = http.createServer((req, res) => {
    console.log('URL recibida: '+req.url);  
    if(req.url=== '/'){
        fs.readFile('./ficheros/index.html', (err, data) => {
            res.setHeader('Content-Type', 'text/html');
            if(err) {
                console.log(err);
                res.end('<h2>Error en la lectura de la página</h2>')
            }else {
                res.end(data.toString());
            }
        });
    }else if (req.url==='/estilos.css'){
        fs.readFile('./ficheros/estilos.css', (err, data) => {
            res.setHeader('Content-Type', 'text/css');
            if(err) {
                console.log(err);
            }else {
                res.end(data.toString());
            }
        });
    }else if (req.url==='/js/index.js'){
        fs.readFile('./ficheros/js/index.js', (err, data) => {
            res.setHeader('Content-Type', 'text/javascript');
            if(err) {
                console.log(err);
            }else {
                res.end(data.toString());
            }
        });
    }else if (req.url.endsWith('.json')){
        var ruta=`./ficheros/JSON${req.url}`;
        //console.log("Petición de JSON recibida "+ ruta);
        fs.readFile(ruta, (err, data) => {
            if(err){
                console.log(err);
            }else{
                //console.log(data.toString());
                res.setHeader('Content-Type', 'application/json');
                res.end(data.toString());   
            }
        })
    }else if (req.url.endsWith('.jpg') || req.url.endsWith('.jfif')){
        var rutaImagen=`./ficheros${req.url}`;
        fs.readFile(rutaImagen, (err, data) => {
            if(err){
                console.log(err);
            }else{
                res.setHeader('Content-Type', 'image/jpeg');
                res.end(data);   
            }
        })
    }
});

console.log("Servidor corriendo en http://localhost:3000") ;
server.listen(3000);

var fs=require('fs');
var http= require('http');

var ficherosweb=fs.readdirSync("web");
console.log(ficherosweb);

var server = http.createServer(function(req, res){
    console.log(req.url);
    if (req.url == '/'){
        res.setHeader('Content-Type', 'text/html');
        //leo el contenido del fichero index.html
        fs.readFile(`web/index.html`, 'utf8', (err, data) => {
            if (err) {
                console.log(`Error leyendo del fichero: ${err}`);
            } else {
                res.end(data);
            }
        });
    }else if (req.url == '/estilos.css'){
        res.setHeader('Content-Type', 'text/css');
        //leo el contenido del fichero estilos.cs
        fs.readFile(`web${req.url}`, 'utf8', (err, data) => {
            if (err) {
                console.log(`Error leyendo del fichero: ${err}`);
            } else {
                res.end(data);
            }
        });
    }
});
console.log('Servidor escuchando por el puerto 3000')
server.listen(3000);
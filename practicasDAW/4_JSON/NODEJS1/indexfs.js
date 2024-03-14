var fs=require('fs');
var http= require('http');

var server = http.createServer(function(req, res){
    console.log(req.url);
    if (req.url == '/'){
        fs.readFile('web/index.html','utf8',function(err,data){
            if (err){
                console.log('Error: '+err);
                res.setHeader('Content-Type', 'text/html');
                res.end('h1>Error en la lectura del archivo</h1>')
            }else{
                res.setHeader('Content-Type', 'text/html');
                res.end(data);
            }
        });
    }else if (req.url == '/estilos.css'){
        fs.readFile('web/estilos.css','utf8',function(err,data){
            if (err){
                console.log('Error: '+err);
            }else{
                res.setHeader('Content-Type', 'text/css');
                res.end(data);            }
        });
    }else if (req.url=='/provincias.json'){
        fs.readFile('web/provincias.json','utf8',function(err,data){
            if (err){
                console.log('Error: '+err);
            }else{
                res.setHeader('Content-Type', 'application/json');
                res.end(data);
            }
        });
    }else if (req.url=='/municipios.json'){
        fs.readFile('web/municipios.json','utf8',function(err,data){
            if (err){
                console.log('Error: '+err);
            }else{
                res.setHeader('Content-Type', 'application/json');
                res.end(data);
            }
        });
    }
});
console.log('Servidor escuchando por el puerto 3000...')
server.listen(3000);
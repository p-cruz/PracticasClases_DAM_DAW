var http=require('http');
var fs=require('fs');

var ruta='D:/Curso 2023-2024/2_LMSGI/practicasRealizadasEnClase/practicasDAM/NODEJS1/ficheros';

var app=http.createServer(function(req,res){
    console.log(`${ruta}${req.url}`)
    if (req.url==='/'){
        res.writeHead(200,{'Content-Type':'text/html'});
        fs.readFile(`${ruta}/index.html`,function(err,data){
            if (err){
                console.log(err);
                res.end('<h2>Página no encontrada</h2>');
            }else{
                res.end(data.toString());
            }
        });
    }else if (req.url==='/estilos.css'){
        fs.readFile(`${ruta}${req.url}`,function(err,data){
            if (err){
                console.log(err);
                res.end('<h2>Página no encontrada</h2>');
            }else{
                res.writeHead(200,{'Content-Type':'text/css'});
                res.end(data.toString());
            }
        });
    }else if (req.url==='/logo-IESGP-FP.png'){
        fs.readFile(`${ruta}${req.url}`,function(err,data){
            if (err){
                console.log(err);
                res.end('<h2>Página no encontrada</h2>');
            }else{
                res.writeHead(200,{'Content-Type':'image/png'});
                res.end(data);
            }
        });
    } else if (req.url==='/json'){
        res.writeHead(200,{'Content-Type':'application/json'});
        fs.readFile(`${ruta}/dato.json`,function(err,data){
            if (err){
                console.log(err);
                res.end('<h2>Página no encontrada</h2>');
            }else{
                res.end(data.toString());
            }
        }); 
    }else if(req.url==='/yaml'){
        res.writeHead(200,{'Content-Type':'text/yaml'});
        fs.readFile(`${ruta}/dato.yaml`,function(err,data){
            if (err){
                console.log(err);
                res.end('<h2>Página no encontrada</h2>');
            }else{
                res.end(data.toString());
            }
        });
    }else{
        res.writeHead(200,{'Content-Type':'text/html'});
        res.end('<h2>Página no encontrada</h2>');
    }
})
console.log("Escuchando en el puerto 3000...")
app.listen(3000);
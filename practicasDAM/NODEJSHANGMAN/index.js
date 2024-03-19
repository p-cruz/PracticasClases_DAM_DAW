var http=require('http');
var fs=require('fs');

var server=http.createServer(function(req,res){
    console.log(req.url);
    if (req.url==='/'){
        res.writeHead(200,{'Content-Type':'text/html'});
        fs.readFile('./ficheros/index.html',function(err,data){
            if (err){
                console.log(err);
                res.end('<h2>Página no encontrada</h2>');
            }else{
                res.end(data.toString());
            }
        });
    }else if (req.url.endsWith('.png')){
        res.writeHead(200,{'Content-Type':'image/png'});
        fs.readFile('./ficheros/images'+req.url,function(err,data){
            if (err){
                console.log(err);
            }else{
                res.end(data);
            }
        }
    )} else if (req.url==='/palabra'){
        res.writeHead(200,{'Content-Type':'application/json'});
        fs.readFile('./ficheros/palabras.json',function(err,data){
            if (err){
                console.log(err);
            }else{
                var palabras=JSON.parse(data);
                var posicionAzar=Math.floor(Math.random()*palabras.length)
                console.log(`{"palabra":"${palabras[posicionAzar]}"}`)
                res.end(`{"palabra":"${palabras[posicionAzar]}"}`);
            }
        });

    }else{
        res.writeHead(404,{'Content-Type':'text/html'});
        res.end('<h2>Página no encontrada</h2>');
    
    };
});

console.log("Escuchando en el puerto 3000...");
server.listen(3000);
    
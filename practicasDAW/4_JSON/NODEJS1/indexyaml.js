var fs=require('fs');
var yaml = require('js-yaml');

try{
    var datos=yaml.load(fs.readFileSync('web/datos.yaml','utf8'));
    console.log(datos);
    var datos2=["uno" , "dos" , "tres" , "cuatro" , "cinco" , "seis" , "siete" , "ocho" , "nueve" , "diez"]
    console.log(yaml.dump(datos2));
}catch(err){
    console.log('Error: '+err);
}
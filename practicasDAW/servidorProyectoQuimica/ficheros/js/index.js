window.addEventListener("DOMContentLoaded",()=>{
    const asignar_dom_modal = (nombre,simbolo,numeroAtomico,numeroMasico,grupo,periodo,propiedadesFisicas,propiedadesQuimicas,aplicaciones,descubrimiento,objectURL) =>{
        document.querySelector(".modal-title").innerHTML = `${nombre}`;

        document.querySelector(".modal-body").innerHTML = `
        <div class="fotoDescubridor"><strong>Foto Descubridor </strong><img src="${objectURL}"></div>
        <div class="simbolo"><strong>Simbolo: </strong></div>
        <div class="nombre"><strong>Nombre: </strong>${nombre}</div>
        <div class="numeroAtomico"><strong>Numero Atomico: </strong></div>       
        <div class="numeroMasico"><strong>Numero Masico: </strong></div>
        <div class="grupo"><strong>Grupo: </strong></div>
        <div class="periodo"><strong>Periodo: </strong></div>
        <div class="propiedadesFisicas"><strong>Propiedades Fisicas: </strong></div>
        <div class="propiedadesQuimicas"><strong>Propiedades Quimicas: </strong></div>
        <div class="aplicaciones"><strong>Aplicaciones: </strong></div>
        <div class="descubrimiento"><strong>Descubrimiento: </strong></div>
        `

        let arr_variables_ajax = [{"simbolo":simbolo},{"numeroAtomico":numeroAtomico},{"numeroMasico":numeroMasico},{"grupo":grupo},{"periodo":periodo},{"propiedadesFisicas":propiedadesFisicas},{"propiedadesQuimicas":propiedadesQuimicas},{"aplicaciones":aplicaciones},{"descubrimiento":descubrimiento}];
        arr_variables_ajax.forEach(elemento => {
            let clave = Object.keys(elemento)[0];
            let valor = elemento[clave];
            Array.isArray(valor) ?
            (document.querySelector(`.${clave}`).append(document.createElement("ul")),
            valor.forEach(elemento => document.querySelector(`.${clave} > ul`).innerHTML += `<li>${elemento}</li>`))
            : document.querySelector(`.${clave}`).innerHTML += valor;
        })
    
    }

    const asignar_error_dom = (type_err) =>{
        if(type_err == "img_found"){
            document.querySelector(".modal-title").innerHTML = "Error en la peticion al buscar la imagen del autor";
            document.querySelector(".modal-body").innerHTML = `Error en la peticion al buscar la imagen del autor`;
        }else if(type_err == "json_found"){
            document.querySelector(".modal-title").innerHTML = "Error en la peticion al buscar la informacion del elemento";
            document.querySelector(".modal-body").innerHTML = `Error en la peticion al buscar la informacion del elemento`;
        }
        else{
        document.querySelector(".modal-title").innerHTML = "Error en la peticion...";
        document.querySelector(".modal-body").innerHTML = `Error en la peticion...`;
        }
    }

    document.querySelectorAll("ol li").forEach((element, index) => {
        element.setAttribute("data-bs-toggle","modal")
        element.setAttribute("data-bs-target","#exampleModal")
        
        const computedStyle = window.getComputedStyle(element);
        let bg_color_li = computedStyle.getPropertyValue('background-color');
        element.style.boxShadow = `6px 6px 1px rgba(51, 51, 50, 0.585), 6px 6px 1px ${bg_color_li}`;

        element.addEventListener("click", async ()=>{
           let njson = index+1;

          try{
            let peticion = await fetch("http://localhost:3000/"+njson+".json");
            if(peticion.status != 200) throw "json_found";

            let {simbolo, nombre, numeroAtomico, numeroMasico,
            grupo, periodo, propiedadesFisicas, propiedadesQuimicas,
            aplicaciones, descubrimiento, fotoDescubridor} = await peticion.json();

            let peticion_img = await fetch(`${fotoDescubridor}`);
            if(peticion_img.status != 200) throw "img_found";
        
            let respuesta_img = await peticion_img.blob();
            const objectURL = URL.createObjectURL(respuesta_img);

            asignar_dom_modal(nombre,simbolo,numeroAtomico,numeroMasico,grupo,periodo,propiedadesFisicas,propiedadesQuimicas,aplicaciones,descubrimiento,objectURL);

            }catch(error_){
                if(error_ == "json_found") asignar_error_dom(error_)
                else if(error_ == "img_found") asignar_error_dom(error_)
                else asignar_error_dom();
            }
        });

        element.addEventListener("mouseover",()=>{
            const computedStyle = window.getComputedStyle(element);
            let bg_color_li = computedStyle.getPropertyValue('background-color');
            document.body.setAttribute("style",`background: linear-gradient(180deg, #333 5%,  ${bg_color_li});`);

            let elemento_titulo = element.title;
            document.querySelector("footer").innerHTML = elemento_titulo;
            document.querySelector("footer").style.color = bg_color_li;
        })
    });

});
select temp, equipo, (puntosLocal+puntosVisitante) totalPuntos
from (select p.temporada temp, p.equipo_local equipo, sum(p.puntos_local) puntosLocal, (select sum(p2.puntos_visitante)
                                                                                        from partidos p2 
                                                                                        where p.equipo_local=p2.equipo_visitante
								                                                        and p.temporada=p2.temporada) puntosVisitante
	from partidos p
	group by p.temporada, p.equipo_local
	order by p.temporada, p.equipo_local) alias1;


select el.equipo, el.temporada, (el.tp+ev.tp) total
from el,ev
where el.equipo=ev.equipo and el.temporada=ev.temporada
group by el.equipo,el.temporada
having total = (select MIN(el.tp+ev.tp) from el,ev where el.equipo=ev.equipo and el.temporada=ev.temporada);


select avg(altura), posicion
from jugadores
group by posicion;
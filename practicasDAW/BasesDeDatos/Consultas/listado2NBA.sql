ALTER SESSION SET NLS_NUMERIC_CHARACTERS=',.';

TTITLE CENTER 'LISTADO DE SUMA DE PUNTOS COMO LOCAL Y COMO VISITANTE DE CADA EQUIPO EN CADA TEMPORADA' skip 2

SET HEADSEP |

COLUMN  TEMP HEADING 'TEMPORADA'  FORMAT A16
COLUMN  EQUIPO_LOCAL HEADING 'EQUIPO'  FORMAT A20
COLUMN  PUNTOSLOCAL HEADING 'Total|local' FORMAT 9G999G999D00
COLUMN  PUNTOSVISITANTE HEADING 'Total|visitante' FORMAT 9G999G999D00

BREAK ON temp SKIP 2
rem COMPUTE AVG LABEL 'Media' OF puntosLocal ON temp
rem COMPUTE AVG LABEL 'Media' OF puntosVisitante ON temp
compute avg label 'Media' of puntosLocal puntosVisitante on temp

SET LINESIZE 120
SET PAGESIZE 80
SET NEWPAGE 0


SELECT p1.temporada temp, p1.equipo_local, sum(p1.puntos_local) puntosLocal, (select sum(p2.puntos_visitante)
                                                                                from partidos p2
                                                                                where p1.equipo_local=p2.equipo_visitante
                                                                                        and p2.temporada=p1.temporada) puntosVisitante
from partidos p1
group by p1.equipo_local, p1.temporada
order by p1.temporada, p1.equipo_local;


TTITLE OFF
CLEAR BREAKS
CLEAR COMPUTES
CLEAR COLUMNS
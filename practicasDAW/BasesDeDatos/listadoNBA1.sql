REM ALTER SESSION SET NLS_NUMERIC_CHARACTERS=',.';

TTITLE CENTER 'LISTADO DE LAS MEDIAS ESTADISTICAS DE CADA EQUIPO'skip 2

SET HEADSEP |

COLUMN  CONFERENCIA  FORMAT A15
COLUMN  MEDIA1 HEADING 'Media de puntos|por partido' FORMAT 90D00
COLUMN MEDIA2 HEADING ' Media de asistencias|por partido ' FORMAT 90D00
COLUMN MEDIA3 HEADING ' Media de tapones|por partido ' FORMAT 90D00
COLUMN MEDIA4 HEADING ' Media de rebotes|por partido ' FORMAT 90D00

BREAK ON CONFERENCIA SKIP 2
REM COMPUTE AVG LABEL'Medias' OF MEDIA1 ON CONFERENCIA
REM COMPUTE AVG LABEL'Medias' OF MEDIA2 ON CONFERENCIA
REM COMPUTE AVG LABEL'Medias' OF MEDIA3 ON CONFERENCIA
REM COMPUTE AVG LABEL'Medias' OF MEDIA4 ON CONFERENCIA
COMPUTE AVG LABEL 'Medias' OF MEDIA1 MEDIA2 MEDIA3 MEDIA4 ON CONFERENCIA

SET LINESIZE 300
SET PAGESIZE 80
SET NEWPAGE 0
SET TRIMSPOOL ON

SPOOL 'D:\EJ\mediasPorConferenciaYPartido .LST'

select conferencia, equipos.nombre, avg(puntos_por_partido) media1, avg(asistencias_por_partido) media2, 
avg(rebotes_por_partido) media4, avg(tapones_por_partido) media3
from estadisticas, equipos, jugadores
where estadisticas.jugador=jugadores.codigo and
jugadores.nombre_equipo=equipos.nombre
group by conferencia, equipos.nombre
order by conferencia, equipos.nombre;

SPOOL OFF
TTITLE OFF
CLEAR BREAKS
CLEAR COMPUTES
CLEAR COLUMNS
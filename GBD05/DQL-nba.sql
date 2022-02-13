/**
 *  Fichero:  DQL-nba.sql
 *  Descripción: Consultas sobre la base de nba. SOLUCIONES
 *   
 *  Editor: MySQL Workbench Community (GPL) for Mac OS X version 6.2.4  revision 12437
 * 
 *  @author Ana Polo Arozamena
 *  @copyleft (c) 2015, Ana Polo Arozamena
 *  @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 o posterior
 *  @version 1.0
 */

use nba;

/*-- 1. Equipo y ciudad de los jugadores españoles de la NBA.
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    equipos.nombre, equipos.ciudad
FROM
    equipos, 
    jugadores 
WHERE
	equipos.nombre = jugadores.nombreEquipo
    AND UPPER( jugadores.procedencia ) LIKE "SPAIN";


    -- OPC 2: USANDO JOIN

SELECT 
    equipos.nombre, equipos.ciudad
FROM
    equipos
        INNER JOIN
    jugadores ON equipos.nombre = jugadores.nombreEquipo
WHERE
    LOWER( jugadores.procedencia ) = "spain";


/*
--  2. Equipos cuyo nombre comience por H y termine por S.     
*/


SELECT 
    equipos.nombre
FROM
    equipos
WHERE
    UCASE( equipos.nombre ) LIKE "H%S";


/*
-- 3. Puntos por partido de “Pau Gasol” en toda su carrera   
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "pau gasol";


    -- OPC 2: USANDO JOIN.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombre ) = "pau gasol";


/*
-- 4. Equipos pertenecientes a la conferencia oeste ( “West”  ) 
*/

SELECT 
    equipos.nombre
FROM
    equipos
WHERE
    UCASE( equipos.conferencia ) LIKE "WEST";


/*
-- 5. Jugadores de Arizona que pesen más de 100 kg y midan más de 1,82 m ( 6 pies ) 
*/

SELECT 
    jugadores.nombre, jugadores.altura
FROM
    jugadores
WHERE
    LOWER( jugadores.procedencia ) LIKE "arizona" 
        AND jugadores.peso > ( 100 * 0.4535 )
        AND jugadores.altura > "6"; 


/*
-- 6. Media de puntos por partido de los jugadores de los “Cavaliers” 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido, jugadores.nombre
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombreEquipo ) = "Cavaliers"
GROUP BY jugadores.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido, jugadores.nombre
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombreEquipo ) = "cavaliers"
GROUP BY jugadores.nombre;


/*
-- 7. Jugadores cuya tercera letra del nombre sea ‘v’ 
*/

SELECT 
    jugadores.nombre
FROM
    jugadores
WHERE
    lower( jugadores.nombre ) LIKE "__v%";


/*
-- 8. Número de jugadores que tienen cada equipo de la conferencia oeste 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND LCASE( equipos.conferencia ) = "west"
GROUP BY equipos.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    lower( equipos.conferencia ) = "west"
GROUP BY equipos.nombre;


/*
-- 9. Número de jugadores argentinos en la NBA               
*/

SELECT 
    COUNT( * ) AS cantidadJugadores
FROM
    jugadores
WHERE
    UPPER( jugadores.procedencia ) LIKE "ARGENTINA";


/*
-- 10. Máxima media de puntos de Lebron James en su carrera 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    MAX( estadisticas.puntosPorPartido ) AS maximaMediaPuntos
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LOWER( jugadores.nombre ) = "lebron james";


    -- OPC 2: USANDO JOIN

SELECT 
    MAX( estadisticas.puntosPorPartido ) AS maximaMediaPuntos
FROM
    estadisticas
        INNER JOIN
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) = "lebron james";


/*
-- 11. Asistencias por partido de José Calderon en la temporada 07/08 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    estadisticas.asistenciasPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "jose calderon"
        AND estadisticas.temporada = "06/07";


    -- OPC 2: USANDO JOIN

SELECT 
    estadisticas.asistenciasPorPartido
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombre ) LIKE 'jose calderon'
        AND estadisticas.temporada = '06/07';


/*
-- 12. Media de puntos por partido de Lebron James en las temporadas del 03/04 al 05/06 
*/

    -- OPC 1: SIN USAR JOIN, CON LIKE Y BETWEEN.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "lebron james"
        AND estadisticas.temporada BETWEEN "03/04" AND "05/06";


    -- OPC 1: SIN USAR JOIN, CON LIKE Y <=>, MENOS EFICIENTE.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "lebron james"
        AND estadisticas.temporada >= "03/04" 
        AND estadisticas.temporada <= "05/06";



    -- OPC 1: SIN USAR JOIN Y CON IGUALDADES, AÚN MENOS EFICIENTE.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "lebron james"
        AND ( estadisticas.temporada = "03/04"
            OR estadisticas.temporada = "04/05"
            OR estadisticas.temporada = "05/06" );



    -- OPC 1: SIN USAR JOIN Y CON IN, IGUAL DE EFICIENTE QUE LA ANTERIOR PERO MÁS FÁCIL DE LEER.

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "lebron james"
        AND estadisticas.temporada IN ( "03/04", "04/05", "05/06" );


    -- OPC 2: USANDO JOIN, LIKE Y BETWEEN

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombre ) LIKE "lebron james"
        AND Temporada BETWEEN "03/04" AND "05/06";


/*
-- 13. Número de jugadores que tiene cada equipo de la conferencia este ( “East”  ) 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND LCASE( equipos.conferencia ) = 'east'
GROUP BY equipos.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    COUNT(*) AS cantidadJugadores, equipos.nombre
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    LOWER( equipos.conferencia ) = 'east'
GROUP BY equipos.nombre;


/*
-- 14. Tapones por partido de los jugadores de los “Lakers” 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    AVG(estadisticas.taponesPorPartido) AS taponesPorPartido,
    jugadores.nombre
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LOWER( jugadores.nombreEquipo ) LIKE 'lakers'
GROUP BY jugadores.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    AVG(estadisticas.taponesPorPartido) AS taponesPorPartido,
    jugadores.nombre
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LCASE( jugadores.nombreEquipo ) = 'lakers'
GROUP BY jugadores.nombre;


/*
-- 15. Media de rebotes de los jugadores de la conferencia Este 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    AVG(estadisticas.rebotesPorPartido) AS rebotesPorPartido,
    jugadores.nombre
FROM
    estadisticas,
    jugadores,
    equipos
WHERE
    jugadores.codigo = estadisticas.jugador
        AND jugadores.nombreEquipo = equipos.nombre
        AND LOWER( equipos.conferencia ) LIKE 'east'
GROUP BY jugadores.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    AVG(estadisticas.rebotesPorPartido) AS rebotesPorPartido,
    jugadores.nombre
FROM
    (estadisticas
    INNER JOIN jugadores ON jugadores.codigo = estadisticas.jugador)
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    LCASE( equipos.conferencia ) LIKE 'east'
GROUP BY jugadores.nombre;


/*
-- 16. Rebotes por partido de los jugadores de los equipos de los Angeles 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    AVG(estadisticas.rebotesPorPartido) AS rebotesPorPartido,
    jugadores.nombre
FROM
    estadisticas,
    jugadores,
    equipos
WHERE
    jugadores.codigo = estadisticas.jugador
        AND jugadores.nombreEquipo = equipos.nombre
        AND LOWER( equipos.ciudad ) = 'los angeles'
GROUP BY jugadores.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    AVG(estadisticas.rebotesPorPartido) AS rebotesPorPartido,
    jugadores.nombre
FROM
    (estadisticas
    INNER JOIN jugadores ON jugadores.codigo = estadisticas.jugador)
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    LCASE( equipos.ciudad ) LIKE 'los angeles'
GROUP BY jugadores.nombre;


/*
-- 17. Número de jugadores que tiene cada equipo de la división North West 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    COUNT(*) AS cantidadJugadores, equipos.nombre
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND UPPER( equipos.division ) = 'NORTHWEST'
GROUP BY equipos.nombre;


    -- OPC 2: USANDO JOIN

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    LCASE( equipos.division ) = 'northwest'
GROUP BY equipos.nombre;


/*
-- 18. Número de jugadores de España y Francia en la NBA 
*/

SELECT 
    COUNT( * ) AS cantidadJugadores, jugadores.procedencia
FROM
    jugadores
WHERE
    LCASE( jugadores.procedencia ) = 'spain'
        OR LOWER( jugadores.procedencia ) = 'france'
GROUP BY jugadores.procedencia;


/*
-- 19. Número de pivots ‘C’ que tiene cada equipo 
*/

SELECT 
    COUNT( * ) AS cantidadPivots, jugadores.nombreEquipo
FROM
    jugadores
WHERE
    jugadores.posicion = '%C%'
GROUP BY jugadores.nombreEquipo;


/*
-- 20. ¿Cuánto mide el pivot más alto de la NBA? 
*/

SELECT 
    MAX( jugadores.altura ) AS alturaPivotMasAlto
FROM
    jugadores
WHERE jugadores.posicion = "%C%";


/*
-- 21. Número de jugadores cuyo nombre comienza por ‘Y’ 
*/

SELECT 
    COUNT( * ) AS cantidaJugadores
FROM
    jugadores
WHERE
    UPPER( jugadores.nombre ) LIKE "Y%";


/*
-- 22. Jugadores que NO metieron ningún punto en alguna temporada 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT DISTINCT
    jugadores.nombre
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND estadisticas.puntosPorPartido = 0;


    -- OPC 2: USANDO JOIN

SELECT DISTINCT
    jugadores.nombre
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    estadisticas.puntosPorPartido = 0;


/*
-- 23. Número total de jugadores de cada división 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    COUNT(*) AS totalJugadores, equipos.division
FROM
    jugadores,
    equipos
WHERE
    equipos.nombre = jugadores.nombreEquipo
GROUP BY equipos.division;


    -- OPC 2: USANDO JOIN

SELECT 
    COUNT(*) AS totalJugadores, equipos.division
FROM
    jugadores
        INNER JOIN
    equipos ON equipos.nombre = jugadores.nombreEquipo
GROUP BY equipos.division;


/*
-- 24. Peso medio en kilos y en libras de los jugadores de los “Raptors” 
*/

SELECT 
    AVG(jugadores.peso) AS MediaLibras,
    AVG(jugadores.peso * 0.4535) AS MediaKilos
FROM
    jugadores
WHERE
    LOWER( jugadores.nombreEquipo ) = 'raptors';


/*
-- 25. Mostrar un listado de jugadores con el formato Nombre( Equipo  ) en una sola columna 
*/

SELECT 
    CONCAT(jugadores.nombre,
            '( ',
            jugadores.nombreEquipo,
            ' )')
FROM
    jugadores;

 
/*
-- 26. Puntuación más baja de un partido de la NBA 
*/

SELECT 
    MIN(partidos.puntosLocal + partidos.puntosVisitante)
FROM
    partidos;


/*
-- 27. Primeros 10 jugadores ordenados alfabéticamente 
*/

SELECT 
    jugadores.nombre
FROM
    jugadores
ORDER BY jugadores.nombre
LIMIT 10;


/*
-- 28. Temporada con más puntos por partido de Kobe Bryant 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    estadisticas.temporada
FROM
    estadisticas,
    jugadores
WHERE
    estadisticas.jugador = jugadores.codigo
        AND LOWER( jugadores.nombre ) LIKE 'kobe bryant'
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;


    -- OPC 2: USANDO JOIN

SELECT 
    estadisticas.temporada
FROM
    estadisticas
        INNER JOIN
    jugadores ON estadisticas.jugador = jugadores.codigo
WHERE
    LCASE( jugadores.nombre ) LIKE 'kobe bryant'
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;



    -- OPC 1: SIN USAR JOIN Y UNA SUBCONSULTA, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    estadisticas.temporada
FROM
    estadisticas
WHERE
    estadisticas.puntosPorPartido = (SELECT 
            MAX(estadisticas.puntosPorPartido)
        FROM
            estadisticas,
            jugadores
        WHERE
            estadisticas.jugador = jugadores.codigo
                AND LOWER( jugadores.nombre ) LIKE 'kobe bryant';


    -- OPC 2: SIN USAR JOIN Y UNA SUBCONSULTA QUE LO USA, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    estadisticas.temporada
FROM
    estadisticas
WHERE
    estadisticas.puntosPorPartido = (SELECT 
            MAX(estadisticas.puntosPorPartido)
        FROM
            estadisticas
                INNER JOIN
            jugadores ON estadisticas.jugador = jugadores.codigo
        WHERE
            LOWER( jugadores.nombre ) LIKE 'kobe bryant';
   
   
/*
-- 29. Numero de bases ‘G’ que tiene cada equipo de la conferencia Este 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    COUNT(*) AS cantidadBases, jugadores.nombreEquipo
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND jugadores.posicion = '%G%'
        AND LCASE( equipos.conferencia ) LIKE 'east'
GROUP BY jugadores.nombreEquipo;


    -- OPC 2: USANDO JOIN

SELECT 
    COUNT(*) AS cantidadBases, jugadores.nombreEquipo
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    jugadores.posicion = '%G%'
        AND LOWER( equipos.conferencia ) LIKE 'East'
GROUP BY jugadores.nombreEquipo;


/*
-- 30. Número de equipos de cada conferencia 
*/

SELECT 
    COUNT(*) AS cantidadEquipos, equipos.conferencia
FROM
    equipos
GROUP BY equipos.conferencia;


/*
-- 31. Nombre de las divisiones de la conferencia este 
*/

SELECT DISTINCT
    equipos.division
FROM
    equipos
WHERE
    UCASE( equipos.conferencia ) LIKE 'EAST';


/*
-- 32. Máximo reboteador de los “Suns” 
*/

    -- OPC 1: SIN USAR JOIN.

SELECT 
    jugadores.nombre
FROM
    jugadores,
    estadisticas
WHERE
    estadisticas.jugador = jugadores.codigo
        AND UPPER( jugadores.nombreEquipo ) = 'SUNS'
ORDER BY estadisticas.rebotesPorPartido
LIMIT 1;


    -- OPC 2: USANDO JOIN

SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
WHERE
    UCASE( jugadores.nombreEquipo ) LIKE 'SUNS'
ORDER BY estadisticas.rebotesPorPartido
LIMIT 1;


    -- OPC 3: SIN USAR JOIN Y CON UNA SUBCONSULTA, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    jugadores.nombre
FROM
    jugadores,
    estadisticas
WHERE
    estadisticas.jugador = jugadores.codigo
        AND estadisticas.rebotesPorPartido = (SELECT 
            MAX(estadisticas.rebotesPorPartido)
        FROM
            estadisticas,
            jugadores
        WHERE
            estadisticas.jugador = jugadores.codigo
                AND UPPER( jugadores.nombreEquipo ) LIKE 'SUNS')
        AND LCASE( jugadores.nombreEquipo ) LIKE 'suns';


    -- OPC 4: USANDO JOIN Y UNA SUBCONSULTA SIN JOIN, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
WHERE
    estadisticas.rebotesPorPartido = (SELECT 
            MAX(estadisticas.rebotesPorPartido)
        FROM
            estadisticas,
            jugadores
        WHERE
            estadisticas.jugador = jugadores.codigo
                AND LOWER( jugadores.nombreEquipo ) = 'suns')
        AND UCASE( jugadores.nombreEquipo ) = 'SUNS';


    -- OPC 5: SIN USAR JOIN EN LA CONSULTA PRINCIPAL Y UNA SUBCONSULTA CON JOIN, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    jugadores.nombre
FROM
    jugadores,
    estadisticas
WHERE
    estadisticas.jugador = jugadores.codigo
        AND estadisticas.rebotesPorPartido = (SELECT 
            MAX(estadisticas.rebotesPorPartido)
        FROM
            estadisticasinner
                JOIN
            jugadores ON estadisticas.jugador = jugadores.codigo
        WHERE
            UPPER( jugadores.nombreEquipo ) LIKE 'SUNS')
        AND LOWER( jugadores.nombreEquipo ) = 'suns';


    -- OPC 6: USANDO JOIN EN LA CONSULTA PRINCIPAL Y EN LA SUBCONSULTA, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
WHERE
    estadisticas.rebotesPorPartido = (SELECT 
            MAX(estadisticas.rebotesPorPartido)
        FROM
            estadisticas
                INNER JOIN
            jugadores ON estadisticas.jugador = jugadores.codigo
        WHERE
            LCASE( jugadores.nombreEquipo ) = 'suns')
        AND UCASE( jugadores.nombreEquipo ) LIKE 'SUNS';


/*
-- 33. Máximo anotador de toda la BD en una temporada 
*/

    -- OPC 1: SIN USAR JOIN Y CON LIMIT.

SELECT 
    jugadores.nombre
FROM
    jugadores,
    estadisticas
WHERE
    estadisticas.jugador = jugadores.codigo
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;


    -- OPC 2: USANDO JOIN CON LIMIT

SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;
            

    -- OPC 3: SIN USAR JOIN Y UNA SUBCONSULTA, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).
            
SELECT 
    jugadores.nombre
FROM
    jugadores,
    estadisticas
WHERE
    estadisticas.jugador = jugadores.codigo
        AND estadisticas.puntosPorPartido = (SELECT 
            MAX(estadisticas.puntosPorPartido)
        FROM
            estadisticas);
            
            
    -- OPC 4: USANDO JOIN Y UNA SUBCONSULTA, MEJOR SI EVITAMOS LA SUBCONSULTA (NECESITA MUCHOS RECURSOS).

SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
WHERE
    estadisticas.puntosPorPartido = (SELECT 
            MAX(estadisticas.puntosPorPartido)
        FROM
            estadisticas);
  
/*
-- 34. ¿Cuántas letras tiene el nombre de cada jugador de los “Grizzlies”. ( Usar la función LENGTH ) 
*/

SELECT 
    LENGTH( jugadores.nombre) AS longNombre, jugadores.nombre
FROM
    jugadores
WHERE
    LCASE( jugadores.nombreEquipo ) LIKE 'grizzlies';


/*
-- 35. ¿Cuántas letras tiene el equipo con el nombre más largo de la NBA. ( Considerar Ciudad y nombre ) 
*/

SELECT 
    LENGTH(CONCAT(equipos.ciudad, ' ', equipos.nombre)),
    CONCAT(equipos.ciudad, ' ', equipos.nombre)
FROM
    equipos
WHERE
    LENGTH(CONCAT(equipos.ciudad, ' ', equipos.nombre)) = (SELECT 
            MAX(LENGTH(CONCAT(equipos.ciudad, ' ', equipos.nombre)))
        FROM
            equipos);



/*
-- 36. Peso en libras y en kilos del jugador mas alto de la  NBA 
*/

    -- OPC 1: SIN USAR SUBCONSULTA.

SELECT 
    jugadores.peso AS libras, jugadores.peso * 0.4535 AS kilos
FROM
    jugadores
ORDER BY jugadores.altura
LIMIT 1;


    -- OPC 2: USANDO UNA SUBCONSULTA. ES MENOS EFICIENTE
            
SELECT 
    jugadores.peso AS libras, jugadores.peso * 0.4535 AS kilos
FROM
    jugadores
WHERE
    jugadores.altura = (SELECT 
            MAX(jugadores.altura)
        FROM
            jugadores);



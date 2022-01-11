/**
 *  Fichero:  GBD_05_E01_nba_sol.sql
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

/*************************************************************/
/* a. Equipo y ciudad de los jugadores españoles de la NBA   */
/*************************************************************/

SELECT 
    equipos.nombre, equipos.ciudad
FROM
    equipos, 
    jugadores 
WHERE
	equipos.nombre = jugadores.nombreEquipo
    AND UPPER( jugadores.procedencia ) LIKE "SPAIN";


/* bis */

SELECT 
    equipos.nombre, equipos.ciudad
FROM
    equipos
        INNER JOIN
    jugadores ON equipos.nombre = jugadores.nombreEquipo
WHERE
    LOWER( jugadores.procedencia ) = "spain";


/*************************************************************/
/* b. Equipos cuyo nombre comience por H y termine por S     */
/*************************************************************/

SELECT 
    equipos.nombre
FROM
    equipos
WHERE
    UCASE( equipos.nombre ) LIKE "H%S";


/*************************************************************/
/* c. Puntos por partido de “Pau Gasol” en toda su carrera   */
/*************************************************************/

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "pau gasol";


/* bis */

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombre ) = "pau gasol";


/****************************************************************/
/* d. Equipos pertenecientes a la conferencia oeste ( “West”  ) */
/****************************************************************/

SELECT 
    equipos.nombre
FROM
    equipos
WHERE
    UCASE( equipos.conferencia ) LIKE "WEST";


/************************************************************************************/
/* e. Jugadores de Arizona que pesen más de 100 kg y midan más de 1,82 m ( 6 pies ) */
/************************************************************************************/

SELECT 
    jugadores.nombre, jugadores.altura
FROM
    jugadores
WHERE
    LOWER( jugadores.procedencia ) LIKE "arizona" 
        AND jugadores.peso > ( 100 * 0.4535 )
        AND jugadores.altura > "6";


/*************************************************************/
/* f. Media de puntos por partido de los jugadores de los “Cavaliers” */
/*************************************************************/

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido, jugadores.nombre
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombreEquipo ) = "Cavaliers"
GROUP BY jugadores.nombre;


/* bis */

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido, jugadores.nombre
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombreEquipo ) = "cavaliers"
GROUP BY jugadores.nombre;


/**********************************************************************/
/* g. Jugadores cuya tercera letra del nombre sea ‘v’ */
/**********************************************************************/

SELECT 
    jugadores.nombre
FROM
    jugadores
WHERE
    lower( jugadores.nombre ) LIKE "__v%";


/*************************************************************************/
/* h. Número de jugadores que tienen cada equipo de la conferencia oeste */
/*************************************************************************/

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND LCASE( equipos.conferencia ) = "west"
GROUP BY equipos.nombre;


/* bis */

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    lower( equipos.conferencia ) = "west"
GROUP BY equipos.nombre;


/*************************************************************/
/* i. Número de jugadores argentinos en la NBA               */
/*************************************************************/

SELECT 
    COUNT( * ) AS cantidadJugadores
FROM
    jugadores
WHERE
    UPPER( jugadores.procedencia ) LIKE "ARGENTINA";


/*************************************************************/
/* j. Máxima media de puntos de Lebron James en su carrera */
/*************************************************************/

SELECT 
    MAX( estadisticas.puntosPorPartido ) AS maximaMediaPuntos
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LOWER( jugadores.nombre ) = "lebron james";


/* bis */

SELECT 
    MAX( estadisticas.puntosPorPartido ) AS maximaMediaPuntos
FROM
    estadisticas
        INNER JOIN
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) = "lebron james";


/*********************************************************************/
/* k. Asistencias por partido de José Calderon en la temporada 07/08 */
/*********************************************************************/

SELECT 
    estadisticas.asistenciasPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "jose calderon"
        AND estadisticas.temporada = "06/07";


/* bis */

SELECT 
    estadisticas.asistenciasPorPartido
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombre ) LIKE 'jose calderon'
        AND estadisticas.temporada = '06/07';


/***************************************************************************/
/* Media de puntos por partido de Lebron James en las temporadas del 03/04 al 05/06 */
/***************************************************************************/

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "lebron james"
        AND estadisticas.temporada BETWEEN "03/04" AND "05/06";


/* bis */

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


/* bis */

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


/* bis */

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND LCASE( jugadores.nombre ) LIKE "lebron james"
        AND estadisticas.temporada IN ( "03/04", "04/05", "05/06" );


/* bis */

SELECT 
    AVG( estadisticas.puntosPorPartido ) AS puntosPorPartido
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    LOWER( jugadores.nombre ) LIKE "lebron james"
        AND Temporada BETWEEN "03/04" AND "05/06";


/***********************************************************************************/
/* m. Número de jugadores que tiene cada equipo de la conferencia este ( “East”  ) */
/***********************************************************************************/

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND LCASE( equipos.conferencia ) = 'east'
GROUP BY equipos.nombre;


/* bis */

SELECT 
    COUNT(*) AS cantidadJugadores, equipos.nombre
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    LOWER( equipos.conferencia ) = 'east'
GROUP BY equipos.nombre;


/*************************************************************/
/* n. Tapones por partido de los jugadores de los “Lakers” */
/*************************************************************/

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


/* bis */

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


/*************************************************************/
/* o. Media de rebotes de los jugadores de la conferencia Este */
/*************************************************************/

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


/* bis */

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


/*************************************************************/
/* p. Rebotes por partido de los jugadores de los equipos de los Angeles */
/*************************************************************/

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


/* bis */

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


/*************************************************************/
/* q. Número de jugadores que tiene cada equipo de la división North West */
/*************************************************************/

SELECT 
    COUNT(*) AS cantidadJugadores, equipos.nombre
FROM
    jugadores,
    equipos
WHERE
    jugadores.nombreEquipo = equipos.nombre
        AND UPPER( equipos.division ) = 'NORTHWEST'
GROUP BY equipos.nombre;


/* bis */

SELECT 
    COUNT( * ) AS cantidadJugadores, equipos.nombre
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.nombreEquipo = equipos.nombre
WHERE
    LCASE( equipos.division ) = 'northwest'
GROUP BY equipos.nombre;


/*************************************************************/
/* r. Número de jugadores de España y Francia en la NBA */
/*************************************************************/

SELECT 
    COUNT( * ) AS cantidadJugadores, jugadores.procedencia
FROM
    jugadores
WHERE
    LCASE( jugadores.procedencia ) = 'spain'
        OR LOWER( jugadores.procedencia ) = 'france'
GROUP BY jugadores.procedencia;


/*************************************************************/
/* s. Número de pivots ‘C’ que tiene cada equipo */
/*************************************************************/

SELECT 
    COUNT( * ) AS cantidadPivots, jugadores.nombreEquipo
FROM
    jugadores
WHERE
    jugadores.posicion = '%C%'
GROUP BY jugadores.nombreEquipo;


/*************************************************************/
/* t. ¿Cuánto mide el pivot más alto de la NBA? */
/*************************************************************/

SELECT 
    MAX( jugadores.altura ) AS alturaPivotMasAlto
FROM
    jugadores
WHERE jugadores.posicion = "%C%";


/*************************************************************/
/* u. Número de jugadores cuyo nombre comienza por ‘Y’ */
/*************************************************************/

SELECT 
    COUNT( * ) AS cantidaJugadores
FROM
    jugadores
WHERE
    UPPER( jugadores.nombre ) LIKE "Y%";


/*************************************************************/
/* v. Jugadores que NO metieron ningún punto en alguna temporada */
/*************************************************************/

SELECT DISTINCT
    jugadores.nombre
FROM
    estadisticas,
    jugadores
WHERE
    jugadores.codigo = estadisticas.jugador
        AND estadisticas.puntosPorPartido = 0;


/* bis */

SELECT DISTINCT
    jugadores.nombre
FROM
    estadisticas
        INNER JOIN
    jugadores ON jugadores.codigo = estadisticas.jugador
WHERE
    estadisticas.puntosPorPartido = 0;


/*************************************************************/
/* w. Número total de jugadores de cada división */
/*************************************************************/

SELECT 
    COUNT(*) AS totalJugadores, equipos.division
FROM
    jugadores,
    equipos
WHERE
    equipos.nombre = jugadores.nombreEquipo
GROUP BY equipos.division;


/* bis */

SELECT 
    COUNT(*) AS totalJugadores, equipos.division
FROM
    jugadores
        INNER JOIN
    equipos ON equipos.nombre = jugadores.nombreEquipo
GROUP BY equipos.division;


/*************************************************************/
/* x. Peso medio en kilos y en libras de los jugadores de los “Raptors” */
/*************************************************************/

SELECT 
    AVG(jugadores.peso) AS MediaLibras,
    AVG(jugadores.peso * 0.4535) AS MediaKilos
FROM
    jugadores
WHERE
    LOWER( jugadores.nombreEquipo ) = 'raptors';


/*************************************************************/
/* y. Mostrar un listado de jugadores con el formato Nombre( Equipo  ) en una sola columna */
/*************************************************************/

SELECT 
    CONCAT(jugadores.nombre,
            '( ',
            jugadores.nombreEquipo,
            ' )')
FROM
    jugadores;

 
/*************************************************************/
/* z. Puntuación más baja de un partido de la NBA */
/*************************************************************/

SELECT 
    MIN(partidos.puntosLocal + partidos.puntosVisitante)
FROM
    partidos;


/*************************************************************/
/* aa. Primeros 10 jugadores ordenados alfabéticamente */
/*************************************************************/

SELECT 
    jugadores.nombre
FROM
    jugadores
ORDER BY jugadores.nombre
LIMIT 10;


/*************************************************************/
/* bb. Temporada con más puntos por partido de Kobe Bryant */
/*************************************************************/
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


/* bis */

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


/* bis En este caso con subconsultas, aunque si es posible hacerlo sin ella es mejor*/

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

/* bis */

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
   
   
/*************************************************************/
/* cc. Numero de bases ‘G’ que tiene cada equipo de la conferencia Este */
/*************************************************************/

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


/* bis */

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


/*************************************************************/
/* dd. Número de equipos de cada conferencia */
/*************************************************************/

SELECT 
    COUNT(*) AS cantidadEquipos, equipos.conferencia
FROM
    equipos
GROUP BY equipos.conferencia;


/*************************************************************/
/* ee. Nombre de las divisiones de la conferencia este */
/*************************************************************/

SELECT DISTINCT
    equipos.division
FROM
    equipos
WHERE
    UCASE( equipos.conferencia ) LIKE 'EAST';


/*************************************************************/
/* ff. Máximo reboteador de los “Suns” */
/*************************************************************/

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


/* bis */

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


/* bis Con subconsultas, aunque es menos eficiente */
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


/* bis */

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


/* bis */

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


/* bis */

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


/*************************************************************/
/* gg. Máximo anotador de toda la BD en una temporada */
/*************************************************************/

SELECT 
    jugadores.nombre
FROM
    jugadores,
    estadisticas
WHERE
    estadisticas.jugador = jugadores.codigo
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;


/* bis */

SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;
            

/* bis Con subconsultas, aunque el codigo es menos eficiente */
            
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
            
            
/* bis */
            
SELECT 
    jugadores.nombre
FROM
    jugadores
        INNER JOIN
    estadisticas ON estadisticas.jugador = jugadores.codigo
ORDER BY estadisticas.puntosPorPartido
LIMIT 1;

  
/*************************************************************/
/* hh. ¿Cuántas letras tiene el nombre de cada jugador de los “Grizzlies”. ( Usar la función LENGTH ) */
/*************************************************************/

SELECT 
    LENGTH( jugadores.nombre) AS longNombre, jugadores.nombre
FROM
    jugadores
WHERE
    LCASE( jugadores.nombreEquipo ) LIKE 'grizzlies';


/*************************************************************/
/* ii. ¿Cuántas letras tiene el equipo con el nombre más largo de la NBA. ( Considerar Ciudad y nombre ) */
/*************************************************************/

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



/*************************************************************/
/* jj. Peso en libras y en kilos del jugador mas alto de la  NBA */
/*************************************************************/

SELECT 
    jugadores.peso AS libras, jugadores.peso * 0.4535 AS kilos
FROM
    jugadores
ORDER BY jugadores.altura
LIMIT 1;


/* bis Con subconsulta, aunque es menos eficiente */
            
SELECT 
    jugadores.peso AS libras, jugadores.peso * 0.4535 AS kilos
FROM
    jugadores
WHERE
    jugadores.altura = (SELECT 
            MAX(jugadores.altura)
        FROM
            jugadores);



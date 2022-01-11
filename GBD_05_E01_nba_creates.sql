/**
 *  Fichero:  nba_creates.sql
 *  Descripción: Consultas de creación de la base de nba
 *   
 *  Editor: MySQL Workbench Community (GPL) for Mac OS X version 6.2.4  revision 12437
 * 
 *  @author Ana Polo Arozamena
 *  @copyleft (c) 2015, Ana Polo Arozamena
 *  @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 o posterior
 *  @version 1.0
 */


DROP DATABASE IF EXISTS nba;

CREATE DATABASE IF NOT EXISTS nba CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;


/* Se selecciona la BD sobre la que se quiere trabajar */

use nba;


/* 
 * Creación de tablas 
 * 
 * RECORDAD que es necesario crear primero las tablas no referenciadas y luego las que las referencian 
 */


/* 
 * EQUIPOS
 */

CREATE TABLE equipos (

   /* Definicion de columnas */

   nombre varchar( 20 ) NOT NULL,
   ciudad varchar( 20 ) DEFAULT NULL,
   conferencia varchar( 4 ) DEFAULT NULL,
   division varchar( 9 ) DEFAULT NULL,
  
	 /* Definicion de restricciones de tabla */
     /* Clave primaria*/

   CONSTRAINT pk PRIMARY KEY ( nombre )
) engine=innodb;

/* 
 * JUGADORES
 */

CREATE TABLE jugadores (

	 /* Definicion de columnas */

    codigo int NOT NULL,
    nombre varchar( 30 ) DEFAULT NULL,
    procedencia varchar( 20 ) DEFAULT NULL,
    altura varchar( 4 ) DEFAULT NULL,
    peso int DEFAULT NULL,
    posicion varchar( 5 ) DEFAULT NULL,
    nombreEquipo varchar( 20 ) DEFAULT NULL,  
  
	  /* Definicion de restricciones de tabla */
    /* Clave primaria*/

    CONSTRAINT pk PRIMARY KEY ( codigo ),
    
    /* Claves ajenas */

    CONSTRAINT fkJugadEquip FOREIGN KEY ( nombreEquipo ) 
		REFERENCES equipos( nombre )
)engine=innodb;

/* 
 * ESTADISTICAS
 */


CREATE TABLE estadisticas (

	  /* Definicion de columnas */

    temporada varchar( 5 ) NOT NULL ,
    jugador int NOT NULL ,
    puntosPorPartido float DEFAULT NULL,
    asistenciasPorPartido float DEFAULT NULL,
    taponesPorPartido float DEFAULT NULL,
    rebotesPorPartido float DEFAULT NULL,  
  
	  /* Definicion de restricciones de tabla */
    /* Clave primaria*/

    CONSTRAINT pk PRIMARY KEY ( temporada, jugador ),
    
    /* Claves ajenas */

    CONSTRAINT fkJugarEstad FOREIGN KEY ( jugador ) 
        REFERENCES jugadores( codigo )
)engine=innodb;


/* 
 * PARTIDOS
 */

CREATE TABLE partidos (

   	/* Definicion de columnas */

    codigo int NOT NULL,
    equipoLocal varchar( 20 ) DEFAULT NULL,
    equipoVisitante varchar( 20 ) DEFAULT NULL,
    puntosLocal int DEFAULT NULL,
    puntosVisitante int DEFAULT NULL,
    temporada varchar( 5 ) DEFAULT NULL,  
  
	/* Definicion de restricciones de tabla */
    /* Clave primaria*/

    CONSTRAINT pk PRIMARY KEY ( codigo ),
    
    /* Claves ajenas */

    CONSTRAINT fkEquipLocalParti FOREIGN KEY ( equipoLocal ) 
        REFERENCES equipos( nombre ),
    CONSTRAINT fkEquiVisitpParti FOREIGN KEY ( equipoVisitante ) 
        REFERENCES equipos( nombre )
)engine=innodb;



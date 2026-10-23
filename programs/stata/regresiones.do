/*******************************************************************************
		El costo invisible de la fertilidad: la segunda jornada en el hogar

                          Universidad de San Andrés
		Exploraciones sobre Pobreza, Desarrollo Humano y Políticas Sociales
									2025

	Regresiones de los Apéndices B y C del trabajo.

	Antes de correr este do-file:
	  1) correr programs/python/construccion_bases_y_figuras.ipynb, que genera
	     las bases output/data/couples_panel.csv y output/data/women_panel.csv;
	  2) instalar outreg2 si no está instalado:  ssc install outreg2
	  3) cambiar el global main (abajo) por la ruta de la carpeta del proyecto.

	Salidas (output/tables):
	  tabla_B.doc  / .txt  -> Apéndice B   (ser padres)
	  tabla_C1.doc / .txt  -> Tabla C1     (trabajar)
	  tabla_C2.doc / .txt  -> Tabla C2     (salida del mercado laboral)
	  tabla_C3.doc / .txt  -> Tabla C3     (informalidad)
*******************************************************************************/

clear all
set more off

* directorio: cambiar por la ruta de la carpeta del proyecto
global main "/Users/catalinagallardo/Downloads/University/Cuarto Año/Pobreza II/El costo invisible de la fertilidad - la segunda jornada en el hogar"
global data   "$main/output/data"
global tables "$main/output/tables"

cap mkdir "$tables"

*==============================================================================*
*							PANEL DE PAREJAS								   *
*==============================================================================*

import delimited "$data/couples_panel.csv", varnames(1) clear

egen id = group(individual_id)
egen sid = group(spouse_id)

xtset sid year

*------------------------------------------------------------------------------*
* labels

label var parents "Ser Padres"
label var unequal "Trabaja Sola"
label var second_child "Tener Segundo Hijo"
label var cohabitation "Cohabitan"
label var spouse_age "Edad Pareja"
label var informality "Informalidad"
label var year "Año"
label var age "Edad"

label var education "Educación"
label define educationlabel 1 "Sin Instrucción" 2 "Primario" 3 "Secundario" 4 "Universidad" 5 "Posgrado"
label values education educationlabel

* tipo de unión (EDER p8_3); 10 = noviazgo (año previo al inicio de la unión, construido en Python)
label var union_type "Tipo de Unión"
label define union_typelabel 1 "Unión de hecho" 2 "Unión legal" 3 "Matrimonio civil" 4 "Matrimonio civil y religioso" 10 "Noviazgo"
label values union_type union_typelabel

label var status "Nivel Socioeconómico"
label define statuslabel 1 "1" 2 "2" 3 "3" 4 "4" 5 "5"
label values status statuslabel

label var life_story "Historia de Vida"
label define life_storylabel 1 "Single Partner Fertility" 2 "Repartnered" 3 "Multipartner Fertility"
label values life_story life_storylabel

*------------------------------------------------------------------------------*
* Apéndice B: la división doméstica como barrera para la maternidad

logit parents unequal year cohabitation age i.union_type i.life_story i.education if work == 1
outreg2 using "$tables/tabla_B.doc", replace label

*==============================================================================*
*							PANEL DE MUJERES								   *
*==============================================================================*

import delimited "$data/women_panel.csv", varnames(1) clear
egen ids = group(individual_id)

xtset ids year

*------------------------------------------------------------------------------*
* labels

gen unequal = 0
replace unequal = 1 if hh_work == 1

label var unequal "Trabaja Sola"
label var work "Trabajar"
label var informality "Informalidad"
label var year "Año"
label var age "Edad"
label var motherhood "Ser Madre"
label var years_motherhood "Años desde Maternidad"
label var t "Intervalo Post Maternidad"
label var hh_work "Trabajo del Hogar"
label var children_total "Cantidad de Hijos"
label var left_market "Salida del Mercado"

label var cohorte "Cohorte"
label define cohortelabel 1 "(1948-1952)" 2 "(1968-1972)" 3 "(1978-1982)"
label values cohorte cohortelabel

label var education "Educación"
label define educationlabel 1 "Sin Instrucción" 2 "Primario" 3 "Secundario" 4 "Universitario" 5 "Posgrado"
label values education educationlabel

label var status "Nivel Socioeconómico"
label define statuslabel 1 "1" 2 "2" 3 "3" 4 "4" 5 "5"
label values status statuslabel

label var life_story "Historia de Vida"
label define life_storylabel 1 "Single Partner Fertility" 2 "Repartnered" 3 "Multipartner Fertility"
label values life_story life_storylabel

*------------------------------------------------------------------------------*
* Tabla C1: probabilidad de trabajar alrededor de la maternidad
* (ventana de cinco años antes y después del nacimiento del primer hijo)

logit work motherhood unequal i.cohorte i.status i.life_story if years_motherhood <= 5 & years_motherhood >= -5
outreg2 using "$tables/tabla_C1.doc", replace label

*------------------------------------------------------------------------------*
* Tabla C2: efecto de ser informal (pre maternidad) en dejar el mercado post maternidad

logit left_market informality year unequal i.cohorte i.status age if years_motherhood < 0
outreg2 using "$tables/tabla_C2.doc", replace label

*------------------------------------------------------------------------------*
* Tabla C3: efecto de ser madre en la probabilidad de ser informal

logit informality motherhood t year unequal i.life_story
outreg2 using "$tables/tabla_C3.doc", replace label

*==============================================================================*

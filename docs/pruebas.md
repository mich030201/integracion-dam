# Pruebas

1. Objetivo:

El objetivo de este informe es documentar la detección de fallos cometidos en las etapas anteriores del proyecto y describir los planes de pruebas propuestos a distintos niveles: pruebas unitarias, pruebas de integración y pruebas con usuarios.

2. Detección de fallos:

Durante el desarrollo del proyecto, se identificaron los siguientes fallos en las etapas anteriores:

- **a) Incompatibilidad de dependencias**: Durante el desarrollo del proyecto se detectó una incompatibilidad de una de las dependencias con una dependencia que se quiso implemetar para cambiar el icono de la aplicación de una manera más cómoda. Pero al detectar dicha incompatibilidad se decidió por no implmentar dicha dependencia y cambair el icono de otra manera.

- **b) Fallo a la hora de cargar ciertas imágenes de los spots**: A la hora de visualizar las tarjetas de los spots o de actualizar su información en ciertas ocasiones, si este contaba con una imágen, esta deja de verse en pantalla y aparece la imagen por defecto que indica que un spots no tiene imágen guardada. Este fallo a día de hoy no se ha podido solucionar ya que no se ha encontrado la causa.

- **c) Carga de coordenadas de un spot**: En un momento del desarrollo se comprobó que al cargar los datos de un marcador en su correspondiente pantalla las coordenadas aparecían con el textop de null. Esto se debe a que a la hora de crear un marcador no es necesario declarar el atributo correspondiente a las coordenadas, y al mostralo por pantalla aparecia el texto de null. Pero se solucionó comprobando antes de cargar el dato si era nulo.

3. Planes de pruebas:

- **a) Pruebas con usuarios**: Se han llevado ha cabo pruebas con usuarios finales para evaluar la usabilidad, funcionalidad y rendimiento del sistema en un entorno real.Estas pruebas han sido llevadas a cabo por el propio desarrollador de la aplicación. En estas pruebas se comprobaron diferentes funcionalidades de la aplicación y con respecto a los resultados se realizaron las convenientes mejoras. 

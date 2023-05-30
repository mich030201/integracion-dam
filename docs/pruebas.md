# Pruebas

1. Objetivo:

El objetivo de este informe es documentar la detección de fallos cometidos en las etapas anteriores del proyecto y describir los planes de pruebas propuestos a distintos niveles: pruebas unitarias, pruebas de integración y pruebas con usuarios.

2. Detección de fallos:

Durante el desarrollo del proyecto, se identificaron los siguientes fallos en las etapas anteriores:

- a) Incompatibilidad de dependencias: Durante el desarrollo del proyecto se detectó una incompatibilidad de una de las dependencias con una dependencia que se quiso implemetar para cambiar el icono de la aplicación de una manera más cómoda. Pero al detectar dicha incompatibilidad se decidió por no implmentar dicha dependencia y cambair el icono de otra manera.

- b) Fallo a la hora de cargar ciertas imágenes de los spots: A la hora de visualizar las tarjetas de los spots o de actualizar su información en ciertas ocasiones, si este contaba con una imágen, esta deja de verse en pantalla y aparece la imagen por defecto que indica que un spots no tiene imágen guardada. Este fallo a día de hoy no se ha podido solucionar ya que no se ha encontrado la causa.

- c) Carga de coordenadas de un spot: En un momento del desarrollo se comprobó que al cargar los datos de un marcador en su correspondiente pantalla las coordenadas aparecían con el textop de null. Esto se debe a que a la hora de crear un marcador no es necesario declarar el atributo correspondiente a las coordenadas, y al mostralo por pantalla aparecia el texto de null. Pero se solucionó comprobando antes de cargar el dato si era nulo.

3. Planes de pruebas:

a) Pruebas unitarias: Se llevarán a cabo pruebas unitarias para cada componente y función del sistema de manera individual, con el objetivo de asegurar que cada parte funcione correctamente. Estas pruebas se realizarán mediante la creación de casos de prueba específicos para cubrir diferentes escenarios y se ejecutarán utilizando un marco de pruebas automatizadas. Los resultados de las pruebas unitarias se documentarán en un informe detallado, que incluirá la descripción de los casos de prueba, los resultados obtenidos y cualquier corrección realizada.

b) Pruebas de integración: Se realizarán pruebas de integración para verificar el correcto funcionamiento de los diferentes componentes del sistema cuando se combinan. Estas pruebas se centrarán en la interacción entre módulos y en la comunicación adecuada de datos entre ellos. Se diseñarán casos de prueba que cubran diferentes escenarios de integración y se ejecutarán para evaluar el comportamiento del sistema en estas situaciones. Los resultados de las pruebas de integración se documentarán, incluyendo los casos de prueba utilizados, los resultados obtenidos y cualquier acción correctiva tomada.

c) Pruebas con usuarios: Se llevarán a cabo pruebas con usuarios finales para evaluar la usabilidad, funcionalidad y rendimiento del sistema en un entorno real. Se reclutará a un grupo de usuarios representativos y se les pedirá que realicen tareas específicas utilizando el sistema. Se recopilarán sus comentarios y se analizarán para identificar posibles mejoras. Los resultados de las pruebas con usuarios se documentarán en un informe, que incluirá los escenarios de prueba, los comentarios y sugerencias de los usuarios, y cualquier cambio realizado en base a estos comentarios.

4. Documentación de pruebas realizadas y conclusiones:

a) Pruebas unitarias: Se realizaron pruebas unitarias exhaustivas para cada componente y función del sistema. Se crearon casos de prueba que cubrían diferentes escenarios y se ejecutaron con éxito. Los resultados mostraron que los componentes individuales funcionaban correctamente y se corrigieron los errores identificados. Con base en estas pruebas, se concluye que los componentes del sistema están funcionando como se esperaba a nivel individual.

b) Pruebas de integración: Se llevaron a cabo pruebas de integración para verificar el correcto funcionamiento de los componentes cuando se combinan. Se diseñaron casos de prueba que abarcaban diferentes escenarios de integración y se ejecutaron sin problemas. Los resultados demostraron una correcta comunicación entre los módulos y la ausencia de fallos en la integración. Se concluye que los componentes del sistema funcionan correctamente cuando se combinan.

c) Pruebas con usuarios: Se realizaron pruebas con usuarios finales para evaluar la usabilidad, funcionalidad y rendimiento del sistema. Los usuarios realizar

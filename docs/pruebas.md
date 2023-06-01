# Pruebas

**1. Objetivo:**

El objetivo de este informe es documentar la detección de fallos cometidos en las etapas anteriores del proyecto y describir los planes de pruebas propuestos a distintos niveles: pruebas unitarias, pruebas de integración y pruebas con usuarios.

**2. Detección de fallos:**

Durante el desarrollo del proyecto, se identificaron los siguientes fallos en las etapas anteriores:

- **a) Incompatibilidad de dependencias**: Durante el desarrollo del proyecto se detectó una incompatibilidad de una de las dependencias con una dependencia que se quiso implemetar para cambiar el icono de la aplicación de una manera más cómoda. Pero al detectar dicha incompatibilidad se decidió por no implmentar dicha dependencia y cambair el icono de otra manera.

- **b) Fallo a la hora de cargar ciertas imágenes de los spots**: A la hora de visualizar las tarjetas de los spots o de actualizar su información en ciertas ocasiones, si este contaba con una imágen, esta deja de verse en pantalla y aparece la imagen por defecto que indica que un spots no tiene imágen guardada. Este fallo a día de hoy no se ha podido solucionar ya que no se ha encontrado la causa.

- **c) Carga de coordenadas de un spot**: En un momento del desarrollo se comprobó que al cargar los datos de un marcador en su correspondiente pantalla las coordenadas aparecían con el textop de null. Esto se debe a que a la hora de crear un marcador no es necesario declarar el atributo correspondiente a las coordenadas, y al mostralo por pantalla aparecia el texto de null. Pero se solucionó comprobando antes de cargar el dato si era nulo.

- **d) Problema con el mapa de la pantalla principal**: Durante el desarrollo del proyecto hubo un erro que no se pudo resolver y que me obligó a modificar el aspecto y funcionamiento de la aplicación. Este error ocurría en la pantalla princiapl con el mapa, ya que este contaba con un atributo que recibe una colección de objetos tipo Marker, pero al pasarle una colección de objetos Marker con los datos que tenía guardados en la base de datos no me los cargaba. Por ello me vi obligado a cambiar el mapa por unas tarjetas que contuviesen esos datos: 


  Primera versión con el mapa:
<div>
<p style = 'text-align:center;'>
<img src="https://github.com/mich030201/integracion-dam/blob/main/docs/mapa_primera_versi%C3%B3n.jpg" alt="JuveYell" width="300px">
</p>
</div>
  
  
  Segunda versión con las tarjetas de los sitios guardados:
<div>
<p style = 'text-align:center;'>
<img src="https://github.com/mich030201/integracion-dam/blob/main/docs/tarjetas_pantalla_principal.jpg" alt="JuveYell" width="300px">
</p>
</div>


Además, para esta pantalla de mapa estaban desarrollados ya una SplashScreen donde se le pedía al usuario los permisos para accdeder a la ubicación del dispositivo y dependiendo de la elección del usuario le dejaba continuar a la pantalla de login y register o se cerraba la app. Y también se comprobaba si la función de GPS del dispositivo estaba activada, si lo estaba a la hora de entrar en la página del mapa este se creaba y se mostraba en la ubicación del usuario en tiempo real, pero si no lo estaba saltaba un mensaje que avisaba a el usuario que era necesario tener el GPS activado y le daba la opción de activarlo llevandole a los ajustes directamente. En caso de que no quisiera activar el GPS, en la pantalla del mapa se mostraba un mensaje donde indicaba que era necesario activar el GPS y un botón que al pulsarlo llevaba al usuario a las opciones para activar el GPS:


  SplashScreen solicitando permisos:
<div>
<p style = 'text-align:center;'>
<img src="https://github.com/mich030201/integracion-dam/blob/main/docs/splash_screen_permisos.jpg" alt="JuveYell" width="300px">
</p>
</div>


  Mensaje que sale para aceptar los permisos:
<div>
<p style = 'text-align:center;'>
<img src="https://github.com/mich030201/integracion-dam/blob/main/docs/aceptar_permisos.jpg" alt="JuveYell" width="300px">
</p>
</div>


  Mensaje que sale en la pantalla del mapa al detectar el GPS desactivado:
<div>
<p style = 'text-align:center;'>
<img src="https://github.com/mich030201/integracion-dam/blob/main/docs/deteccion_gps_desactivado.jpg" alt="JuveYell" width="300px">
</p>
</div>

De igual forma esta solución está pensada como una solución temporal, para en un futuro seguir desarrollando la versión definitiva con el mapa arreglando los errores existentes

**3. Planes de pruebas:**

- **a) Pruebas con usuarios**: Se han llevado ha cabo pruebas con usuarios finales para evaluar la usabilidad, funcionalidad y rendimiento del sistema en un entorno real.Estas pruebas han sido llevadas a cabo por el propio desarrollador de la aplicación. En estas pruebas se comprobaron diferentes funcionalidades de la aplicación y con respecto a los resultados se realizaron las convenientes mejoras. 

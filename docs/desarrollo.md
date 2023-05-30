# Desarrollo

El presente informe detalla las tecnologías utilizadas durante el desarrollo del proyecto PicSpots. Este proyecto tiene como objetivo dar a conocer entre los usuarios aficionados a la fotografía diferentes spots donde se pueden tomar buenas fotos. A continuación, se enumeran las tecnologías, herramientas, lenguajes y servicios utilizados, junto con las correspondientes referencias cuando sea necesario.

**1. Lenguajes de Programación:**

- **Dart**: Dart es un lenguaje de programación desarrollado por Google que se utiliza principalmente para la creación de aplicaciones móviles, aplicaciones web y servidores. Se utilizó Dart para el desarrollo de completo de aplicación junto con su framework Flutter. Con este lenguaje se ha desarrollado la logica de la aplicación, la gestión de eventos en Flutter y también la interfaz de esta mediante Flutter.

**2. Frameworks y Bibliotecas:**

- **Flutter**: Flutter es un framework de código abierto desarrollado por Google que se utiliza para crear aplicaciones móviles nativas de alta calidad en plataformas iOS y Android desde una sola base de código. He usado Flutter por su enfoque en la creación de interfaces de usuario atractivas, con rápido rendimineto y una apariencia nativa en ambas plataformas. En este proyecto he usado Flutter principalmente para desarrollar la interfaz de la aplicación.

A continuación nombraré algunas de las dependencias más importantes que he usadp en el proyecto:

- **cupertino_icons**: Es un conjunto de íconos diseñados específicamente para la plataforma iOS. Fue creado por Apple y se utiliza en sus propias aplicaciones y sistemas operativos..
- **flutter_secure_storage**: Es un paquete en Flutter que proporciona un mecanismo de almacenamiento seguro de clave-valor para almacenar información sensible, como tokens de acceso, claves de API o credenciales de usuario. Se asegura de que los datos estén encriptados y se almacenen de forma segura en el dispositivo.
- **provider**: Es un paquete que facilita la implementación del patrón de diseño de administración de estados en una aplicación Flutter. Proporciona una forma sencilla y eficiente de compartir y actualizar datos entre widgets de manera reactiva.
- **shared_preferences**: Es un paquete que permite almacenar y recuperar datos persistentes de manera sencilla. Se utiliza normalmente para guardar información no crítica en la aplicación, como configuraciones de usuario, preferencias o pequeños conjuntos de datos. En este caso se ha empleado para la función del tema oscuro.

**3. Base de Datos:**

- **Firebase**: Se utilizó Firebase] para almacenar y gestionar los datos del proyecto. Referencia: [Documentación de flutter](https://firebase.google.com/docs?hl=es-419).

**4. Herramientas de Desarrollo:**

- **Visual Studio Code**: Se utilizó Visual Studio Code como IDE para desarrollar el código del proyecto.
- **Postman**: Se utilizó Postman para hacer peticiones a la base de datos y comprobar si los datos son correctos.

**5. Servicios en la Nube:**

- **Cloudinary**: Se utilizó Cloudinary para alojar las imágenes de los spots que suben los usuarios. Referencia: [Cloudinary](https://cloudinary.com/).

**###### Conclusiones:**
Durante el desarrollo de este proyecto, se utilizaron diversas tecnologías, herramientas, lenguajes y servicios. Estas elecciones tecnológicas permitieron cumplir con los objetivos establecidos y lograr los resultados deseados. El uso de Flutter demostró ser efectivo para que la aplicación fuese atractiva visualmente y rápida. Además, la combinación de Firebase y Cloudinary contribuyó a hacer más fácil el almacenar los datos de la aplicación y las imágenes.

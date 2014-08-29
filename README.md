Diseño Detallado de Software 2014
=================================

## Framework en el que se desarrollará la aplicación

La aplicación será desarrollada en Ruby on Rails.

### Argumentos:

+ Framework que favorece el desarrollo ágil.

+ Manejado por la gran mayoría del curso.

+ Cubre sin problemas las exigencias del proyecto. Tiene buena integración con JavaScript y AJAX, haciendo que los requerimientos de asincronicidad del proyecto sean fáciles de implementar.

+ La gran gama de gemas reduce considerablemente el overhead de la implementación de servicios comunes, como por ejemplo, la autenticación de usuario. Esto permite que enfoquemos las fuerzas en lo que realmente genera valor de la aplicación.

+ Usado en desarrollo por varios años alrededor del mundo, por lo que cuenta con una extensa documentación.

## Sistema de control de versiones escogido

Se ha escogido Git para el manejo de versiones, y específicamente se ha elegido GitHub como el proveedor.

### Argumentos:

+ Git facilita inmensamente el trabajo de varias personas sobre el mismo código. Otras alternativas, como un repositorio común, no tienen forma de evitar que el trabajo de un miembro sobrescriba el trabajo del otro. Mucho menos la posibilidad de tener varias ramificaciones del trabajo. Git facilita esto y además entrega todas las facilidades para que modificaciones de distintas personas se combinen y resulte un código funcional.

+ Elegimos GitHub por ser el proveedor más completo de Git, además de ser gratis para estudiantes.

## Servidor de development y publish

Se ha elegido Heroku como el proveedor de servidores de development y publish. La razón de esto es que es gratuito, se acopla fácilmente con Ruby on Rails y la base de datos SQL, y permite la inclusión de una gran cantidad de Add-Ons como Rollbar, New Relic, SendGrid, etc.

## Estándar de codificación

+ Se programará en inglés.

+ Se usará REST para la exposición de servicios.

		Esto significa que para acceder a los recursos se usarán URIs base más el índice del recurso (por ejemplo /users/1); se responderán a los requests generando un JSON; y cada controlador tendrá métodos equivalentes a los requests HTTP GET, PUT, POST, DELETE.

+ Separar bien la lógica de modelos, vistas y controladores.

+ Dejar los algoritmos largos en los modelos, dejando que los controladores tengan la menor cantidad de código posible.

+ Interacción desde los controladores a las vistas en los `respond_to`.

+ Las vistas no cambian el estado de la aplicación.

+ Favorecer el uso de partials para no repetirse a sí mismo.

+ Convenciones de nomenclatura de variables, espacios de identación, etc. quedan a criterio de cada grupo. Favorecer sistemas de caja negra, donde se entienda claramente los input y output del sistema.

+ Testing es responsabilidad de cada grupo. Cada grupo es libre de elegir sus herramientas de testing.

+ Lenguajes como HAML y CoffeeScript son permitidos si hay acuerdo en el grupo.

### Documento fuente de los estándares:

[__https://gist.github.com/y8/958791__](https://gist.github.com/y8/958791)


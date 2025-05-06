# App Flutter: Consumo de API con Búsqueda en Tiempo Real

Esta aplicación Flutter muestra cómo consumir una API pública y presentar la información en una lista interactiva.

## Funcionalidades principales

- **Consumo de API pública:** La app obtiene datos de una API y los muestra en una lista.
- **Campo de búsqueda:** Permite filtrar los elementos de la lista en tiempo real según el criterio introducido (por ejemplo, por nombre). Los resultados se actualizan automáticamente mientras se escribe.
- **Manejo de errores:** Si ocurre un fallo de conexión o la API no responde correctamente, se muestra un mensaje de error al usuario.
- **Indicador de carga:** Mientras se obtienen los datos, se muestra un indicador visual (CircularProgressIndicator) para informar al usuario de que la información está cargando.

Esta estructura básica puede adaptarse a cualquier API pública y es ideal como ejemplo de buenas prácticas en Flutter para manejo de listas, búsqueda y estados de red.

## Sobre los ítems de Isaac y la API

La aplicación utiliza como fuente de datos una API pública relacionada con el videojuego "The Binding of Isaac". Los ítems de Isaac son objetos que el jugador puede encontrar durante la partida y que otorgan diferentes efectos, habilidades o mejoras al personaje principal. Cada ítem tiene un nombre, una descripción, una imagen, una cita y una calidad, entre otros atributos.

La API utilizada permite obtener información detallada de estos ítems, facilitando su visualización y búsqueda dentro de la app. Esto convierte la aplicación en una herramienta útil para jugadores que deseen consultar rápidamente las características de los ítems del juego.

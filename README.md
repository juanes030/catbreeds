# Catbreeds 🐱

Aplicación Flutter desarrollada como solución para la prueba técnica de Catbreeds.

La aplicación permite consultar, buscar y explorar diferentes razas de gatos utilizando The Cat API.

## ✨ Funcionalidades

- Splash screen nativo.
- Listado de razas de gatos.
- Paginación mediante infinite scroll.
- Pull to refresh.
- Búsqueda de razas.
- Debounce en la búsqueda para evitar peticiones innecesarias.
- Manejo de estados de carga, éxito y error.
- Manejo de errores durante la paginación.
- Pantalla de detalle de cada raza.
- Información de origen, esperanza de vida, temperamento, descripción e historia.
- Información de peso y altura.
- Indicadores de inteligencia y adaptabilidad.
- Carga progresiva de imágenes con transición suave.
- Manejo de imágenes inexistentes o con error.
- Icono personalizado de la aplicación.
- Splash screen personalizado.
- Tests automatizados para la lógica principal del BLoC.

## 🛠️ Tecnologías

- Flutter
- Dart
- BLoC / flutter_bloc
- Dio
- GetIt
- Injectable
- GoRouter
- Equatable
- bloc_test
- mocktail
- flutter_native_splash
- flutter_launcher_icons

## 📋 Requisitos

Para ejecutar el proyecto se recomienda utilizar:

- Flutter 3.47.1
- Dart compatible con Flutter 3.47.1
- Xcode para ejecutar en iOS
- Android Studio / Android SDK para Android

Verificar la versión instalada:

```bash
flutter --version

El proyecto fue desarrollado y validado utilizando Flutter 3.47.1.

🔑 API Key

La aplicación utiliza The Cat API.

Por seguridad, la API Key no está almacenada directamente en el código fuente.

La aplicación recibe la API Key mediante:

--dart-define=CAT_API_KEY

Ejecución desde terminal

Ejecutar:

flutter run --dart-define=CAT_API_KEY="API_KEY"
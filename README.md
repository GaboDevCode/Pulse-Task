
#  Pulse Task

<div align="center">

![Pulse Task](assets/icon/nueva.png)

**Una aplicación moderna de gestión de proyectos y tareas construida con Flutter**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.7.2-02569B?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-Private-red.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0+8-blue.svg)](pubspec.yaml)

[Descargar APK](#-descarga) • [Características](#-características) • [Instalación](#-instalación) • [Arquitectura](#-arquitectura)

</div>

---

## 📋 Descripción

**Pulse Task** es una aplicación completa de gestión de proyectos y tareas diseñada para ayudarte a mantener organizados tus proyectos personales y profesionales. Con una interfaz intuitiva y funciones potentes, puedes crear proyectos, añadir tareas individuales a cada proyecto, personalizar la apariencia de la aplicación y gestionar tu perfil con facilidad.

### ✨ Características Principales

- **📂 Gestión de Proyectos**: Organiza tu trabajo en proyectos independientes
- **✅ Tareas por Proyecto**: Añade, edita y completa tareas dentro de cada proyecto
- **🎨 Personalización de Temas**: Cambia entre diferentes temas para adaptar la app a tu estilo
- **👤 Foto de Perfil**: Personaliza tu experiencia con tu propia imagen de perfil
- **🔔 Notificaciones Locales**: Recibe recordatorios para no olvidar tus tareas importantes
- **💾 Almacenamiento Local**: Todos tus datos se guardan de forma segura en tu dispositivo
- **🎯 Interfaz Intuitiva**: Diseño limpio y fácil de usar con navegación fluida



---

## 🚀 Instalación para Desarrollo

### Prerrequisitos

- Flutter SDK 3.7.2 o superior
- Dart SDK
- Android Studio / Xcode (para desarrollo móvil)
- Un editor de código (VS Code, Android Studio, IntelliJ IDEA)

### Pasos de Instalación

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/TU_USUARIO/pulse_task.git
   cd pulse_task
   ```

2. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

3. **Configura las variables de entorno**
   
   Crea un archivo `.env` en la raíz del proyecto con las configuraciones necesarias:
   ```env
   # Añade tus configuraciones aquí
   ```

4. **Genera los iconos de la aplicación**
   ```bash
   flutter pub run flutter_launcher_icons
   ```

5. **Genera la pantalla de splash**
   ```bash
   flutter pub run flutter_native_splash:create
   ```

6. **Ejecuta la aplicación**
   ```bash
   flutter run
   ```

### Cambiar el Package Name (Opcional)

Si deseas cambiar el nombre del paquete de la aplicación:

```bash
dart run change_app_package_name:main com.tunombre.tunombreapp
```

---

## 🏗️ Arquitectura del Proyecto

La aplicación sigue una arquitectura limpia y organizada por capas:

```
lib/
├── configuration/          # Configuraciones de la app
│   ├── correo/            # Configuración de email
│   ├── notifications/     # Sistema de notificaciones
│   ├── router/            # Navegación y rutas
│   └── theme/             # Temas y estilos
├── domain/                # Lógica de negocio
│   ├── datasources/       # Fuentes de datos abstractas
│   ├── models/            # Modelos de datos
│   └── repositories/      # Repositorios abstractos
├── presentation/          # Capa de presentación
│   ├── providers/         # Gestión de estado (Provider)
│   ├── screens/           # Pantallas de la app
│   └── widgets/           # Widgets reutilizables
└── main.dart             # Punto de entrada
```

### Tecnologías Utilizadas

- **Framework**: Flutter 3.7.2
- **Gestión de Estado**: Provider
- **Navegación**: Go Router
- **Base de Datos Local**: SQLite (sqflite)
- **Notificaciones**: Flutter Local Notifications
- **Almacenamiento**: Shared Preferences
- **Selección de Imágenes**: Image Picker
- **Permisos**: Permission Handler

---

## 📦 Dependencias Principales

| Paquete | Versión | Descripción |
|---------|---------|-------------|
| `flutter` | SDK | Framework principal |
| `provider` | ^6.1.4 | Gestión de estado |
| `go_router` | ^15.0.0 | Enrutamiento y navegación |
| `sqflite` | ^2.4.2 | Base de datos SQLite |
| `shared_preferences` | ^2.5.3 | Almacenamiento clave-valor |
| `flutter_local_notifications` | ^19.1.0 | Notificaciones locales |
| `image_picker` | ^1.1.2 | Selección de imágenes |
| `flutter_slidable` | ^4.0.0 | Acciones deslizables |
| `google_mobile_ads` | ^6.0.0 | Integración de anuncios |
| `permission_handler` | ^12.0.0+1 | Gestión de permisos |

---

## 🛠️ Scripts de Desarrollo

### Generar iconos de la app
```bash
flutter pub run flutter_launcher_icons
```

### Generar splash screen
```bash
flutter pub run flutter_native_splash:create
```

### Limpiar el proyecto
```bash
flutter clean
flutter pub get
```

### Construir APK
```bash
flutter build apk --release
```

### Construir App Bundle
```bash
flutter build appbundle --release
```

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si deseas contribuir:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto es privado y no está disponible para uso público sin autorización.

---

## 👨‍💻 Autor

**Gabriel Eduardo**

- GitHub: [GaboDevCode](https://github.com/GaboDevCode)

---

## 📞 Soporte

Si encuentras algún problema o tienes alguna pregunta, por favor abre un [issue](https://github.com/TU_USUARIO/pulse_task/issues) en el repositorio.

---

<div align="center">

**Hecho con ❤️ usando Flutter**

⭐ Si te gusta este proyecto, no olvides darle una estrella en GitHub ⭐

</div>

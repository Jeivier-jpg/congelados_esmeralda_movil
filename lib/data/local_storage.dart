import 'package:congelados_esmeralda_movil/models/usuario.dart';

/// Datos locales (mientras no hay servidor). Se guardan en memoria, así que
/// se pierden al cerrar la app.
class LocalStorage {
  /// Usuarios registrados.
  static final List<Usuario> usuarios = [];

  /// Contraseña de cada usuario, por correo.
  static final Map<String, String> contrasenas = {};
}

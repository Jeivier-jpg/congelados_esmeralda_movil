import 'package:congelados_esmeralda_movil/data/local_storage.dart';
import 'package:congelados_esmeralda_movil/models/usuario.dart';

/// Registro e inicio de sesión local: los usuarios están en [LocalStorage].
class AuthService {
  static final RegExp _formatoCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Usuario con la sesión iniciada (null si no hay sesión).
  static Usuario? usuarioActual;

  /// Crea una cuenta nueva.
  /// Devuelve un mensaje de error, o null si el registro fue exitoso.
  Future<String?> registrar(
      String nombre, String correo, String contrasena) async {
    final n = nombre.trim();
    final c = correo.trim().toLowerCase();

    if (n.isEmpty) return 'Ingresa tu nombre';
    if (!_formatoCorreo.hasMatch(c)) return 'Ingresa un correo válido';
    if (contrasena.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (LocalStorage.usuarios.any((u) => u.correo == c)) {
      return 'Ya existe una cuenta con ese correo';
    }
    LocalStorage.usuarios.add(Usuario(nombre: n, correo: c));
    LocalStorage.contrasenas[c] = contrasena;
    return null;
  }

  /// Devuelve un mensaje de error, o null si el inicio de sesión fue exitoso.
  Future<String?> iniciarSesion(String correo, String contrasena) async {
    final c = correo.trim().toLowerCase();

    if (!_formatoCorreo.hasMatch(c)) return 'Ingresa un correo válido';
    if (contrasena.isEmpty) return 'Ingresa tu contraseña';

    await Future.delayed(const Duration(milliseconds: 500));

    final usuarios = LocalStorage.usuarios.where((u) => u.correo == c);
    if (usuarios.isEmpty || LocalStorage.contrasenas[c] != contrasena) {
      return 'Correo o contraseña incorrectos';
    }
    usuarioActual = usuarios.first;
    return null;
  }

  void cerrarSesion() {
    usuarioActual = null;
  }
}

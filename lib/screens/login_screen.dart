import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correo = TextEditingController();
  final _contrasena = TextEditingController();
  bool _ocultar = true;
  String? _error;

  @override
  void dispose() {
    _correo.dispose();
    _contrasena.dispose();
    super.dispose();
  }

  void _ingresar() {
    final correo = _correo.text.trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(correo)) {
      setState(() => _error = 'Ingresa un correo válido');
      return;
    }
    if (_contrasena.text.length < 6) {
      setState(() => _error = 'La contraseña debe tener al menos 6 caracteres');
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void _proximamente(String que) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$que estará disponible pronto')));
  }

  InputDecoration _decoracion(String hint, {Widget? sufijo}) {
    OutlineInputBorder borde(Color c) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c),
        );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF928EB9)),
      suffixIcon: sufijo,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      border: borde(const Color(0xFFE6E4F5)),
      enabledBorder: borde(const Color(0xFFE6E4F5)),
      focusedBorder: borde(const Color(0xFF4B0082)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.vertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B0082),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.ac_unit,
                          color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Text('Congelados Esmeralda',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E1E58))),
                  ],
                ),
                const SizedBox(height: 90),
                const Text('Iniciar sesión',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E58))),
                const SizedBox(height: 4),
                const Text('Ingresa con tu cuenta para hacer tu pedido',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B6890))),
                const SizedBox(height: 24),
                const Text('Correo electrónico',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E1E58))),
                const SizedBox(height: 6),
                TextField(
                  controller: _correo,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: _decoracion('nombre@correo.cl'),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Contraseña',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E1E58))),
                    GestureDetector(
                      onTap: () => _proximamente('Recuperar contraseña'),
                      child: const Text('¿La olvidaste?',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4B0082))),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _contrasena,
                  obscureText: _ocultar,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _ingresar(),
                  decoration: _decoracion(
                    'Ingresa tu contraseña',
                    sufijo: IconButton(
                      icon: Icon(
                          _ocultar
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF6B6890)),
                      onPressed: () => setState(() => _ocultar = !_ocultar),
                    ),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(_error!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFFD64545))),
                ],
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: _ingresar,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4B0082),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Ingresar',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 18),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFFE6E4F5))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('o',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF928EB9))),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE6E4F5))),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () => _proximamente('Acceso con Google'),
                    icon: const Icon(Icons.account_circle_outlined,
                        color: Color(0xFF4B0082), size: 20),
                    label: const Text('Continuar con Google',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E58))),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE6E4F5)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                Center(
                  child: GestureDetector(
                    onTap: () => _proximamente('Crear cuenta'),
                    child: const Text.rich(
                      TextSpan(
                        text: '¿No tienes cuenta? ',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF6B6890)),
                        children: [
                          TextSpan(
                            text: 'Crear cuenta',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E1E58)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

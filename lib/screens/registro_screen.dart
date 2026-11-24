import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/services/auth_service.dart';

/// Crea una cuenta. Al terminar vuelve al login devolviendo el correo
/// registrado.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _auth = AuthService();
  final _nombre = TextEditingController();
  final _correo = TextEditingController();
  final _contrasena = TextEditingController();
  final _confirmar = TextEditingController();
  bool _ocultar = true;
  bool _cargando = false;
  String? _error;

  @override
  void dispose() {
    _nombre.dispose();
    _correo.dispose();
    _contrasena.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (_cargando) return;
    if (_contrasena.text != _confirmar.text) {
      setState(() => _error = 'Las contraseñas no coinciden');
      return;
    }
    setState(() {
      _cargando = true;
      _error = null;
    });
    final error = await _auth.registrar(
        _nombre.text, _correo.text, _contrasena.text);
    if (!mounted) return;
    if (error != null) {
      setState(() {
        _cargando = false;
        _error = error;
      });
      return;
    }
    // Vuelve al login con el correo recién registrado.
    Navigator.of(context).pop(_correo.text.trim().toLowerCase());
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

  Widget _etiqueta(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 14),
        child: Text(texto,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E58))),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7FC),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E58)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Crear cuenta',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E58))),
              const SizedBox(height: 4),
              const Text('Regístrate para hacer tu pedido',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B6890))),
              const SizedBox(height: 10),
              _etiqueta('Nombre'),
              TextField(
                controller: _nombre,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: _decoracion('Tu nombre'),
              ),
              _etiqueta('Correo electrónico'),
              TextField(
                controller: _correo,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _decoracion('nombre@correo.cl'),
              ),
              _etiqueta('Contraseña'),
              TextField(
                controller: _contrasena,
                obscureText: _ocultar,
                textInputAction: TextInputAction.next,
                decoration: _decoracion(
                  'Mínimo 6 caracteres',
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
              _etiqueta('Confirmar contraseña'),
              TextField(
                controller: _confirmar,
                obscureText: _ocultar,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _registrar(),
                decoration: _decoracion('Repite tu contraseña'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFFD64545))),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _cargando ? null : _registrar,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF4B0082),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _cargando
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Crear cuenta',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

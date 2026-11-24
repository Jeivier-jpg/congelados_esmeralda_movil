import 'package:flutter/material.dart';

/// Botones  −  1  +  para cambiar la cantidad.
class SelectorCantidad extends StatelessWidget {
  final int cantidad;
  final ValueChanged<int> onCambiar;
  final int minimo;
  final int maximo;

  const SelectorCantidad({
    super.key,
    required this.cantidad,
    required this.onCambiar,
    this.minimo = 1,
    this.maximo = 10,
  });

  Widget _boton(IconData icono, bool activo, VoidCallback onTap) {
    return InkWell(
      onTap: activo ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icono,
          size: 16,
          color: activo ? const Color(0xFF1E1E58) : const Color(0xFFBDBAD9),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE6E4F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _boton(Icons.remove, cantidad > minimo,
              () => onCambiar(cantidad - 1)),
          SizedBox(
            width: 24,
            child: Text(
              '$cantidad',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E58),
              ),
            ),
          ),
          _boton(Icons.add, cantidad < maximo, () => onCambiar(cantidad + 1)),
        ],
      ),
    );
  }
}
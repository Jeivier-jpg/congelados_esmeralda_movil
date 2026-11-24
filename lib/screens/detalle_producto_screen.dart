import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/producto.dart';

class DetalleProductoScreen extends StatefulWidget {
  final Producto producto;

  const DetalleProductoScreen({super.key, required this.producto});

  @override
  State<DetalleProductoScreen> createState() => _DetalleProductoScreenState();
}

class _DetalleProductoScreenState extends State<DetalleProductoScreen> {
  static const int _maxPorPedido = 10;
  int cantidad = 1;

  Producto get p => widget.producto;

  /// "$29.740" -> 29740
  int _aEntero(String precio) =>
      int.tryParse(precio.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

  /// 29740 -> "$29.740"
  String _formato(int valor) {
    final s = valor.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return '\$$buf';
  }

  void _cambiarCantidad(int nueva) {
    setState(() => cantidad = nueva.clamp(1, _maxPorPedido));
  }

  void _agregar() {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('$cantidad × ${p.nombre} agregado al carrito'),
        duration: const Duration(seconds: 2),
      ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final total = _aEntero(p.precio) * cantidad;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E58)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detalle',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E1E58))),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 1.05,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: const Color(0xFFDFE8F1),
                    child: _imagen(),
                  ),
                  if (p.etiqueta != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE3C2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(p.etiqueta!,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB45F00))),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(p.nombre,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E58))),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(p.precio,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B0082))),
                  if (p.anterior != null)
                    Text(p.anterior!,
                        style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Color(0xFF928EB9))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('${p.marca} · ${p.detalle}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B6890))),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sobre este corte',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E58))),
                const SizedBox(height: 10),
                _fila(Icons.category_outlined, 'Categoría', p.categoria),
                _fila(Icons.star_outline, 'Calificación', p.rating),
                _fila(Icons.scale_outlined, 'Presentación', p.detalle),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          color: Colors.white,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E4F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.remove, color: Color(0xFF1E1E58)),
                      onPressed: () => _cambiarCantidad(cantidad - 1),
                    ),
                    Text('$cantidad',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E58))),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.add, color: Color(0xFF1E1E58)),
                      onPressed: () => _cambiarCantidad(cantidad + 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: _agregar,
                    icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                    label: Text('Agregar · ${_formato(total)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4B0082),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fila(IconData icono, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icono, size: 18, color: const Color(0xFF928EB9)),
          const SizedBox(width: 10),
          Text(titulo,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B6890))),
          const Spacer(),
          Text(valor,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1E58))),
        ],
      ),
    );
  }

  Widget _imagen() {
    final icono = Center(
        child: Icon(p.icono, size: 90, color: const Color(0xFF928EB9)));
    final url = p.imagenUrl;
    if (url == null || url.isEmpty) return icono;
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => icono,
    );
  }
}

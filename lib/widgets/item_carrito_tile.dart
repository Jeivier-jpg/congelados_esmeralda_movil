import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/item_carrito.dart';
import 'package:congelados_esmeralda_movil/services/carrito_service.dart';
import 'package:congelados_esmeralda_movil/utils/formato.dart';
import 'package:congelados_esmeralda_movil/widgets/selector_cantidad.dart';

/// Renglón del carrito: foto, nombre, precio, cantidad y botón de quitar.
class ItemCarritoTile extends StatelessWidget {
  final ItemCarrito item;
  final ValueChanged<int> onCambiarCantidad;
  final VoidCallback onQuitar;

  const ItemCarritoTile({
    super.key,
    required this.item,
    required this.onCambiarCantidad,
    required this.onQuitar,
  });

  Widget _imagen() {
    final p = item.producto;
    final icono = Center(
        child: Icon(p.icono, size: 32, color: const Color(0xFF928EB9)));
    final url = p.imagenUrl;
    if (url == null || url.isEmpty) return icono;
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => icono,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = item.producto;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 76,
              height: 76,
              color: const Color(0xFFDFE8F1),
              child: _imagen(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(p.nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E58))),
                    ),
                    InkWell(
                      onTap: onQuitar,
                      borderRadius: BorderRadius.circular(16),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Icons.delete_outline,
                            size: 20, color: Color(0xFF928EB9)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(p.detalle,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF928EB9))),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatearPrecio(item.subtotal),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E58))),
                    SelectorCantidad(
                      cantidad: item.cantidad,
                      maximo: CarritoService.maxPorProducto,
                      onCambiar: onCambiarCantidad,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
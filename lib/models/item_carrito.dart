import 'package:congelados_esmeralda_movil/models/producto.dart';
import 'package:congelados_esmeralda_movil/utils/formato.dart';

/// Un producto dentro del carrito con su cantidad.
class ItemCarrito {
  final Producto producto;
  int cantidad;

  ItemCarrito({required this.producto, this.cantidad = 1});

  int get precioUnitario => precioAEntero(producto.precio);

  int get subtotal => precioUnitario * cantidad;
}
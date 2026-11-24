import 'package:congelados_esmeralda_movil/models/estado_pedido.dart';

/// Un renglón del pedido (tabla `pedido_productos`).
class ProductoPedido {
  final String nombre;
  final int cantidad;
  final double precioUnitario;

  const ProductoPedido({
    required this.nombre,
    required this.cantidad,
    required this.precioUnitario,
  });

  double get subtotal => cantidad * precioUnitario;
}

/// Pedido del cliente (tabla `pedidos`).
class Pedido {
  final int id;
  final String folio;
  final DateTime fecha;
  final EstadoPedido estado;
  final List<ProductoPedido> productos;
  final String direccionEntrega;

  const Pedido({
    required this.id,
    required this.folio,
    required this.fecha,
    required this.estado,
    required this.productos,
    required this.direccionEntrega,
  });

  int get totalArticulos =>
      productos.fold(0, (suma, p) => suma + p.cantidad);

  double get total => productos.fold(0.0, (suma, p) => suma + p.subtotal);
}
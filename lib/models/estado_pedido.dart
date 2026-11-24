import 'package:flutter/material.dart';

/// Estados posibles de un pedido.
/// `valorApi` es el texto que se guarda en MySQL (columna `pedidos.estado`).
enum EstadoPedido {
  pendiente('pendiente', 'Pendiente', Color(0xFFFFF1D6), Color(0xFF8A5A00),
      Icons.schedule),
  requiereConfirmacion('requiere_confirmacion', 'Por confirmar',
      Color(0xFFFFF1D6), Color(0xFF8A5A00), Icons.help_outline),
  confirmado('confirmado', 'Confirmado', Color(0xFFE6E4F5), Color(0xFF4B0082),
      Icons.check_circle_outline),
  enCamino('en_camino', 'En camino', Color(0xFFDDEBFF), Color(0xFF1D4E89),
      Icons.local_shipping_outlined),
  entregado('entregado', 'Entregado', Color(0xFFDDF5E6), Color(0xFF1B6B3A),
      Icons.done_all),
  cancelado('cancelado', 'Cancelado', Color(0xFFFDE2E2), Color(0xFF9B1C1C),
      Icons.cancel_outlined),
  rechazado('rechazado', 'Rechazado', Color(0xFFFDE2E2), Color(0xFF9B1C1C),
      Icons.block);

  const EstadoPedido(
      this.valorApi, this.etiqueta, this.fondo, this.colorTexto, this.icono);

  final String valorApi;
  final String etiqueta;
  final Color fondo;
  final Color colorTexto;
  final IconData icono;

  /// Activos: los que todavía no terminan (van en la pestaña "Activos").
  bool get esActivo =>
      this == pendiente ||
      this == requiereConfirmacion ||
      this == confirmado ||
      this == enCamino;

  /// Convierte el texto que manda la API en un EstadoPedido.
  static EstadoPedido desdeApi(String valor) {
    return EstadoPedido.values.firstWhere(
      (e) => e.valorApi == valor,
      orElse: () => EstadoPedido.pendiente,
    );
  }
}
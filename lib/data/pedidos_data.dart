import 'package:congelados_esmeralda_movil/models/estado_pedido.dart';
import 'package:congelados_esmeralda_movil/models/pedido.dart';

/// Pedidos de prueba mientras no está conectada la API.
final List<Pedido> pedidosEjemplo = [
  Pedido(
    id: 1045,
    folio: 'CE-1045',
    fecha: DateTime(2026, 11, 24, 11, 20),
    estado: EstadoPedido.enCamino,
    direccionEntrega: 'Av. Tulum 230, SM 4, Cancún',
    productos: const [
      ProductoPedido(
          nombre: 'Tomahawk IQF', cantidad: 1, precioUnitario: 29740),
      ProductoPedido(
          nombre: 'Camarones Jumbo', cantidad: 2, precioUnitario: 20900),
    ],
  ),
  Pedido(
    id: 1044,
    folio: 'CE-1044',
    fecha: DateTime(2026, 11, 24, 9, 45),
    estado: EstadoPedido.pendiente,
    direccionEntrega: 'Calle Margaritas 15, SM 25, Cancún',
    productos: const [
      ProductoPedido(
          nombre: 'Burgers Wagyu', cantidad: 1, precioUnitario: 18990),
    ],
  ),
  Pedido(
    id: 1038,
    folio: 'CE-1038',
    fecha: DateTime(2026, 11, 20, 18, 10),
    estado: EstadoPedido.entregado,
    direccionEntrega: 'Av. Tulum 230, SM 4, Cancún',
    productos: const [
      ProductoPedido(
          nombre: 'Salmón Austral', cantidad: 2, precioUnitario: 16800),
      ProductoPedido(
          nombre: 'Bife de Chorizo', cantidad: 1, precioUnitario: 14990),
    ],
  ),
  Pedido(
    id: 1031,
    folio: 'CE-1031',
    fecha: DateTime(2026, 11, 15, 13, 30),
    estado: EstadoPedido.cancelado,
    direccionEntrega: 'Av. Tulum 230, SM 4, Cancún',
    productos: const [
      ProductoPedido(
          nombre: 'Costillar Ahumado', cantidad: 1, precioUnitario: 17490),
    ],
  ),
];
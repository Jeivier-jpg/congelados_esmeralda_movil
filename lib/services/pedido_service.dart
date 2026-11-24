import 'package:congelados_esmeralda_movil/data/pedidos_data.dart';
import 'package:congelados_esmeralda_movil/models/pedido.dart';

class PedidoService {
  /// true = datos de prueba de `data/pedidos_data.dart`.
  /// false = API real (falta conectarla).
  static const bool usarDatosDeEjemplo = true;

  /// Pedidos del cliente, del más reciente al más antiguo.
  static Future<List<Pedido>> obtenerMisPedidos() async {
    if (usarDatosDeEjemplo) {
      // Pequeña espera para simular la red.
      await Future.delayed(const Duration(milliseconds: 400));
      final lista = [...pedidosEjemplo];
      lista.sort((a, b) => b.fecha.compareTo(a.fecha));
      return lista;
    }

    // TODO: GET /api/pedidos/mis-pedidos con el token del cliente.
    throw UnimplementedError('Falta conectar la API de pedidos');
  }
}
import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/pedido.dart';
import 'package:congelados_esmeralda_movil/screens/catalogo_screen.dart';
import 'package:congelados_esmeralda_movil/screens/home_screen.dart';
import 'package:congelados_esmeralda_movil/services/pedido_service.dart';
import 'package:congelados_esmeralda_movil/widgets/pedido_card.dart';

class MisPedidosScreen extends StatefulWidget {
  const MisPedidosScreen({super.key});

  @override
  State<MisPedidosScreen> createState() => _MisPedidosScreenState();
}

class _MisPedidosScreenState extends State<MisPedidosScreen> {
  bool verActivos = true;
  late Future<List<Pedido>> _futuro = PedidoService.obtenerMisPedidos();

  Future<void> _recargar() async {
    setState(() => _futuro = PedidoService.obtenerMisPedidos());
    await _futuro;
  }

  void _verSeguimiento(Pedido pedido) {
    // TODO: abrir SeguimientoPedidoScreen cuando esté lista.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Seguimiento del pedido #${pedido.folio} (próximamente)')),
    );
  }

  PreferredSizeWidget _barraSuperior() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF4B0082),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.ac_unit, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Text('Congelados Esmeralda',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1E58))),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFE6E4F5),
            child: Icon(Icons.person_outline,
                color: Color(0xFF4B0082), size: 20),
          ),
        ),
      ],
    );
  }

  Widget _pestanas(int activos, int historial) {
    Widget pestana(String texto, bool seleccionada, VoidCallback onTap) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: seleccionada ? const Color(0xFF4B0082) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(texto,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: seleccionada
                        ? Colors.white
                        : const Color(0xFF1E1E58))),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          pestana('Activos ($activos)', verActivos,
              () => setState(() => verActivos = true)),
          pestana('Historial ($historial)', !verActivos,
              () => setState(() => verActivos = false)),
        ],
      ),
    );
  }

  Widget _mensaje(IconData icono, String titulo, String detalle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Icon(icono, size: 56, color: const Color(0xFF928EB9)),
          const SizedBox(height: 12),
          Text(titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E58))),
          const SizedBox(height: 4),
          Text(detalle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Color(0xFF928EB9))),
        ],
      ),
    );
  }

  Widget _barraInferior() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 2,
      onTap: (i) {
        if (i == 0) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else if (i == 1) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const CatalogoScreen()));
        }
      },
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF4B0082),
      unselectedItemColor: const Color(0xFF928EB9),
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Catálogo'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Pedidos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), label: 'Carrito'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: _barraSuperior(),
      body: FutureBuilder<List<Pedido>>(
        future: _futuro,
        builder: (context, snapshot) {
          final todos = snapshot.data ?? <Pedido>[];
          final activos = todos.where((p) => p.estado.esActivo).toList();
          final historial = todos.where((p) => !p.estado.esActivo).toList();
          final lista = verActivos ? activos : historial;

          Widget contenido;
          if (snapshot.connectionState != ConnectionState.done) {
            contenido = const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF4B0082)),
              ),
            );
          } else if (snapshot.hasError) {
            contenido = _mensaje(Icons.cloud_off, 'No pudimos cargar tus pedidos',
                'Desliza hacia abajo para intentar de nuevo');
          } else if (lista.isEmpty) {
            contenido = verActivos
                ? _mensaje(Icons.receipt_long, 'No tienes pedidos activos',
                    'Cuando hagas un pedido lo verás aquí')
                : _mensaje(Icons.history, 'Sin pedidos anteriores',
                    'Aquí aparecerán tus pedidos entregados o cancelados');
          } else {
            contenido = Column(
              children: [
                for (final p in lista)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PedidoCard(
                      pedido: p,
                      onVerSeguimiento: () => _verSeguimiento(p),
                    ),
                  ),
              ],
            );
          }

          return RefreshIndicator(
            onRefresh: _recargar,
            color: const Color(0xFF4B0082),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const Text('Mis pedidos',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E58))),
                const SizedBox(height: 4),
                const Text('Revisa el estado de tus compras',
                    style: TextStyle(fontSize: 13, color: Color(0xFF928EB9))),
                const SizedBox(height: 14),
                _pestanas(activos.length, historial.length),
                const SizedBox(height: 16),
                contenido,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _barraInferior(),
    );
  }
}
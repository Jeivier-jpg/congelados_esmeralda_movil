import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/screens/catalogo_screen.dart';
import 'package:congelados_esmeralda_movil/screens/home_screen.dart';
import 'package:congelados_esmeralda_movil/screens/mis_pedidos_screen.dart';
import 'package:congelados_esmeralda_movil/services/carrito_service.dart';
import 'package:congelados_esmeralda_movil/utils/formato.dart';
import 'package:congelados_esmeralda_movil/widgets/item_carrito_tile.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  CarritoService get _carrito => CarritoService.instancia;

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

  void _irA(BuildContext context, Widget pantalla) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => pantalla));
  }

  void _confirmarVaciar(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Vaciar carrito?'),
        content: const Text('Se quitarán todos los productos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _carrito.vaciar();
              Navigator.of(ctx).pop();
            },
            child: const Text('Vaciar',
                style: TextStyle(color: Color(0xFF9B1C1C))),
          ),
        ],
      ),
    );
  }

  void _continuar(BuildContext context) {
    // TODO: abrir ConfirmarPedidoScreen cuando esté lista.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Confirmar pedido (próximamente)')),
    );
  }

  Widget _vacio(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Icon(Icons.shopping_bag_outlined,
              size: 64, color: Color(0xFF928EB9)),
          const SizedBox(height: 12),
          const Text('Tu carrito está vacío',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E58))),
          const SizedBox(height: 4),
          const Text('Agrega cortes desde el catálogo',
              style: TextStyle(fontSize: 13, color: Color(0xFF928EB9))),
          const SizedBox(height: 18),
          SizedBox(
            height: 44,
            child: FilledButton(
              onPressed: () => _irA(context, const CatalogoScreen()),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4B0082),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Ver catálogo',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filaResumen(String titulo, String valor, {bool destacado = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo,
              style: TextStyle(
                  fontSize: destacado ? 16 : 13,
                  fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
                  color: destacado
                      ? const Color(0xFF1E1E58)
                      : const Color(0xFF6B6890))),
          Text(valor,
              style: TextStyle(
                  fontSize: destacado ? 18 : 13,
                  fontWeight: FontWeight.bold,
                  color: destacado
                      ? const Color(0xFF4B0082)
                      : const Color(0xFF1E1E58))),
        ],
      ),
    );
  }

  Widget _resumen() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _filaResumen('Subtotal', formatearPrecio(_carrito.subtotal)),
          _filaResumen(
              'Envío',
              _carrito.costoEnvio == 0
                  ? 'Gratis'
                  : formatearPrecio(_carrito.costoEnvio)),
          const Divider(height: 20, color: Color(0xFFE6E4F5)),
          _filaResumen('Total', formatearPrecio(_carrito.total),
              destacado: true),
        ],
      ),
    );
  }

  Widget _barraInferior(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      onTap: (i) {
        if (i == 0) {
          _irA(context, const HomeScreen());
        } else if (i == 1) {
          _irA(context, const CatalogoScreen());
        } else if (i == 2) {
          _irA(context, const MisPedidosScreen());
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
    return ListenableBuilder(
      listenable: _carrito,
      builder: (context, _) {
        final items = _carrito.items;
        final articulos = _carrito.totalArticulos == 1
            ? '1 artículo'
            : '${_carrito.totalArticulos} artículos';

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FB),
          appBar: _barraSuperior(),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Text('Mi carrito',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E58))),
                  ),
                  if (!_carrito.estaVacio)
                    TextButton(
                      onPressed: () => _confirmarVaciar(context),
                      child: const Text('Vaciar',
                          style: TextStyle(color: Color(0xFF9B1C1C))),
                    ),
                ],
              ),
              if (!_carrito.estaVacio)
                Text(articulos,
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF928EB9))),
              const SizedBox(height: 14),
              if (_carrito.estaVacio)
                _vacio(context)
              else ...[
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ItemCarritoTile(
                      item: item,
                      onCambiarCantidad: (n) =>
                          _carrito.cambiarCantidad(item.producto, n),
                      onQuitar: () => _carrito.quitar(item.producto),
                    ),
                  ),
                const SizedBox(height: 4),
                _resumen(),
              ],
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_carrito.estaVacio)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: () => _continuar(context),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF4B0082),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                          'Continuar · ${formatearPrecio(_carrito.total)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              _barraInferior(context),
            ],
          ),
        );
      },
    );
  }
}
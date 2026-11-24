import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/screens/carrito_screen.dart';
import 'package:congelados_esmeralda_movil/models/producto.dart';
import 'package:congelados_esmeralda_movil/screens/catalogo_screen.dart';
import 'package:congelados_esmeralda_movil/screens/detalle_producto_screen.dart';
import 'package:congelados_esmeralda_movil/screens/mis_pedidos_screen.dart';
import 'package:congelados_esmeralda_movil/widgets/producto_card.dart';
import 'package:congelados_esmeralda_movil/widgets/banner_promocion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String categoriaSeleccionada = 'Todos';

  final List<String> categorias = const [
    'Todos',
    'Vacuno',
    'Pork & Cerdo',
    'Mariscos',
  ];

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
        Icon(Icons.notifications_none, color: Color(0xFF1E1E58)),
        SizedBox(width: 12),
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

  Widget _buscador() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Color(0xFF1E1E58)),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Buscar cortes, salmón, burgers...',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, color: Color(0xFF928EB9))),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.tune, color: Color(0xFF1E1E58)),
        ),
      ],
    );
  }

  Widget _tituloSeccion(String texto, {VoidCallback? onVerTodo}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(texto,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E58))),
        if (onVerTodo != null)
          GestureDetector(
            onTap: onVerTodo,
            child: const Text('Ver todo',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4B0082))),
          ),
      ],
    );
  }

  Widget _chipsCategorias() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categorias[index];
          final activo = cat == categoriaSeleccionada;
          return GestureDetector(
            onTap: () => setState(() => categoriaSeleccionada = cat),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: activo
                    ? const Color(0xFF4B0082)
                    : const Color(0xFFE6E4F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(cat,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: activo ? Colors.white : const Color(0xFF1E1E58))),
            ),
          );
        },
      ),
    );
  }

  void _irACatalogo() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CatalogoScreen()));
  }

  Widget _barraInferior() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      onTap: (i) {
        if (i == 1) {
          _irACatalogo();
        } else if (i == 2) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MisPedidosScreen()));
        } else if (i == 3) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const CarritoScreen()));
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
    final lista = categoriaSeleccionada == 'Todos'
        ? productos
        : productos.where((p) => p.categoria == categoriaSeleccionada).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: _barraSuperior(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          // 1. Buscador
          _buscador(),
          const SizedBox(height: 18),

          // 2. Filtros (categorías)
          _tituloSeccion('Categorías', onVerTodo: _irACatalogo),
          const SizedBox(height: 10),
          _chipsCategorias(),
          const SizedBox(height: 16),

          // 3. Cuadro morado de descuentos
          BannerPromocion(
            etiqueta: '20% OFF primera compra',
            titulo: 'Selección Black Angus',
            subtitulo: 'Usa el cupón ESMERALDA20',
            onTap: _irACatalogo,
          ),
          const SizedBox(height: 20),

          // 4. Productos
          _tituloSeccion('Cortes destacados'),
          const SizedBox(height: 12),
          if (lista.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('No hay productos en esta categoría',
                    style: TextStyle(color: Color(0xFF928EB9))),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lista.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final p = lista[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DetalleProductoScreen(producto: p))),
                  child: ProductoCard(producto: p),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: _barraInferior(),
    );
  }
}
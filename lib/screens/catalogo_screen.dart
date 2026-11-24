import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/screens/carrito_screen.dart';
import 'package:congelados_esmeralda_movil/models/producto.dart';
import 'package:congelados_esmeralda_movil/screens/detalle_producto_screen.dart';
import 'package:congelados_esmeralda_movil/screens/home_screen.dart';
import 'package:congelados_esmeralda_movil/screens/mis_pedidos_screen.dart';
import 'package:congelados_esmeralda_movil/widgets/producto_card.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<String> categorias = const [
    'Todos',
    'Vacuno',
    'Pork & Cerdo',
    'Mariscos',
  ];

  String categoriaSeleccionada = 'Todos';
  String busqueda = '';

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

  Widget _barraInferior() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      onTap: (i) {
        // Inicio
        if (i == 0) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
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
    final q = busqueda.trim().toLowerCase();
    final lista = productos.where((p) {
      final okCategoria =
          categoriaSeleccionada == 'Todos' || p.categoria == categoriaSeleccionada;
      final okTexto = q.isEmpty ||
          p.nombre.toLowerCase().contains(q) ||
          p.marca.toLowerCase().contains(q);
      return okCategoria && okTexto;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: _barraSuperior(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const Text('Catálogo',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E58))),
          const SizedBox(height: 14),
          TextField(
            onChanged: (v) => setState(() => busqueda = v),
            style: const TextStyle(fontSize: 14, color: Color(0xFF1E1E58)),
            decoration: InputDecoration(
              hintText: 'Buscar cortes, salmón, camarones...',
              hintStyle:
                  const TextStyle(fontSize: 13, color: Color(0xFF928EB9)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF1E1E58)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _chipsCategorias(),
          const SizedBox(height: 14),
          if (lista.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('No encontramos productos',
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
                final Producto p = lista[index];
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
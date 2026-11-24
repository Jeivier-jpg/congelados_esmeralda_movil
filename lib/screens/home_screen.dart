import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/producto.dart';
import 'package:congelados_esmeralda_movil/widgets/producto_card.dart';

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
      title: const Row(
        children: [
          Icon(Icons.ac_unit, color: Color(0xFF4B0082)),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CONGELADOS ESMERALDA',
                  style: TextStyle(
                      fontSize: 9,
                      letterSpacing: 1,
                      color: Color(0xFF1E1E58))),
              Text('Catálogo',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E58))),
            ],
          ),
        ],
      ),
      actions: const [
        Icon(Icons.notifications_none, color: Color(0xFF1E1E58)),
        SizedBox(width: 12),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF4B0082),
            child: Icon(Icons.person_outline, color: Colors.white, size: 20),
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
                  child: Text('Buscar cortes ultra-congelados...',
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        children: [
          _buscador(),
          const SizedBox(height: 14),
          _chipsCategorias(),
          const SizedBox(height: 14),
          const SizedBox(height: 16),
          const SizedBox(height: 12),
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
            itemBuilder: (context, index) =>
                ProductoCard(producto: lista[index]),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: _barraInferior(),
    );
  }
}

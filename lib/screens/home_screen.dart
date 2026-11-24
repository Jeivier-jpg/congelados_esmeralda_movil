import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/producto.dart';
import 'package:congelados_esmeralda_movil/widgets/barra_inferior.dart';
import 'package:congelados_esmeralda_movil/widgets/buscador_filtro.dart';
import 'package:congelados_esmeralda_movil/widgets/catalogo_app_bar.dart';
import 'package:congelados_esmeralda_movil/widgets/categoria_chips.dart';
import 'package:congelados_esmeralda_movil/widgets/encabezado_lista.dart';
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

  @override
  Widget build(BuildContext context) {
    final lista = categoriaSeleccionada == 'Todos'
        ? productos
        : productos.where((p) => p.categoria == categoriaSeleccionada).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: const CatalogoAppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        children: [
          const BuscadorFiltro(),
          const SizedBox(height: 14),
          CategoriaChips(
            categorias: categorias,
            seleccionada: categoriaSeleccionada,
            onSeleccionar: (cat) =>
                setState(() => categoriaSeleccionada = cat),
          ),
          const SizedBox(height: 14),
          const SizedBox(height: 16),
          const EncabezadoLista(),
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
      bottomNavigationBar: const BarraInferior(),
    );
  }
}
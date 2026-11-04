import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> pedidos = const [
    {'destino': 'Plaza Las Américas', 'estado': 'En camino', 'precio': '\$85'},
    {'destino': 'Aeropuerto', 'estado': 'Entregado', 'precio': '\$220'},
    {'destino': 'Centro', 'estado': 'Cancelado', 'precio': '\$60'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis pedidos')),
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          final pedido = pedidos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.local_taxi),
              title: Text(pedido['destino']!),
              subtitle: Text(pedido['estado']!),
              trailing: Text(pedido['precio']!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Nuevo pedido'),
      ),
    );
  }
}
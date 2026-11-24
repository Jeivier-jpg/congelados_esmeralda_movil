import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/estado_pedido.dart';

class EstadoChip extends StatelessWidget {
  final EstadoPedido estado;

  const EstadoChip({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: estado.fondo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(estado.icono, size: 14, color: estado.colorTexto),
          const SizedBox(width: 4),
          Text(
            estado.etiqueta,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: estado.colorTexto,
            ),
          ),
        ],
      ),
    );
  }
}
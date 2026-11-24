import 'package:flutter/material.dart';
import 'package:congelados_esmeralda_movil/models/pedido.dart';
import 'package:congelados_esmeralda_movil/widgets/estado_chip.dart';

class PedidoCard extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback? onTap;
  final VoidCallback? onVerSeguimiento;

  const PedidoCard({
    super.key,
    required this.pedido,
    this.onTap,
    this.onVerSeguimiento,
  });

  static const _meses = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];

  String _fecha(DateTime f) {
    final hh = f.hour.toString().padLeft(2, '0');
    final mm = f.minute.toString().padLeft(2, '0');
    return '${f.day} ${_meses[f.month - 1]} ${f.year} · $hh:$mm';
  }

  /// 29740 -> $29.740 (mismo formato que los precios del catálogo).
  String _precio(double valor) {
    final entero = valor.round().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < entero.length; i++) {
      if (i > 0 && (entero.length - i) % 3 == 0) buffer.write('.');
      buffer.write(entero[i]);
    }
    return '\$$buffer';
  }

  @override
  Widget build(BuildContext context) {
    final p = pedido;
    final resumen =
        p.productos.map((item) => '${item.cantidad}× ${item.nombre}').join(', ');
    final articulos =
        p.totalArticulos == 1 ? '1 artículo' : '${p.totalArticulos} artículos';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado: ícono, folio, fecha y estado
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E4F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.receipt_long,
                      color: Color(0xFF4B0082)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pedido #${p.folio}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E58))),
                      const SizedBox(height: 2),
                      Text(_fecha(p.fecha),
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF928EB9))),
                    ],
                  ),
                ),
                EstadoChip(estado: p.estado),
              ],
            ),
            const SizedBox(height: 12),

            // Productos
            Text(
              resumen,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Color(0xFF1E1E58)),
            ),
            const SizedBox(height: 6),

            // Dirección
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: Color(0xFF928EB9)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    p.direccionEntrega,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF928EB9)),
                  ),
                ),
              ],
            ),
            const Divider(height: 24, color: Color(0xFFE6E4F5)),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(articulos,
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF928EB9))),
                Text(_precio(p.total),
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E58))),
              ],
            ),

            // Botón solo para pedidos activos
            if (p.estado.esActivo && onVerSeguimiento != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton.icon(
                  onPressed: onVerSeguimiento,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B0082),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.local_shipping_outlined, size: 18),
                  label: const Text('Ver seguimiento',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
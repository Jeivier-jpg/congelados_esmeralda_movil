import 'package:flutter/material.dart';

class BannerPromocion extends StatelessWidget {
  final String etiqueta;
  final String titulo;
  final String subtitulo;
  final String? imagenUrl; // foto de fondo opcional
  final VoidCallback? onTap;

  const BannerPromocion({
    super.key,
    this.etiqueta = '20% OFF primera compra',
    this.titulo = 'Promociones y paquetes',
    this.subtitulo = 'Usa el cupón ESMERALDA20',
    this.imagenUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF4B0082),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Foto de fondo (si hay) con capa morada encima
            if (imagenUrl != null && imagenUrl!.isNotEmpty)
              Image.network(
                imagenUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => const SizedBox(),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF4B0082).withValues(alpha: 0.95),
                    const Color(0xFF4B0082).withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
            // Texto
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD08A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      etiqueta,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B2A00),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitulo,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
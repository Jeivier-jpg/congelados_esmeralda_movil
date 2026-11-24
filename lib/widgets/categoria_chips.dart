import 'package:flutter/material.dart';

class CategoriaChips extends StatelessWidget {
  final List<String> categorias;
  final String seleccionada;
  final ValueChanged<String> onSeleccionar;

  const CategoriaChips({
    super.key,
    required this.categorias,
    required this.seleccionada,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categorias[index];
          final activo = cat == seleccionada;
          return GestureDetector(
            onTap: () => onSeleccionar(cat),
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
                      color:
                          activo ? Colors.white : const Color(0xFF1E1E58))),
            ),
          );
        },
      ),
    );
  }
}
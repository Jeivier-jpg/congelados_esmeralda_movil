import 'package:flutter/material.dart';

class BuscadorFiltro extends StatelessWidget {
  const BuscadorFiltro({super.key});

  @override
  Widget build(BuildContext context) {
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
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF928EB9))),
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
}
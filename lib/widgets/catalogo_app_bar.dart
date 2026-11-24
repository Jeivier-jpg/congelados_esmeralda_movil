import 'package:flutter/material.dart';

class CatalogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogoAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
}
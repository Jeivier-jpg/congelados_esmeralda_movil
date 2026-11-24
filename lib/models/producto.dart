import 'package:flutter/material.dart';

class Producto {
  final String marca;
  final String nombre;
  final String detalle;
  final String precio;
  final String? anterior;
  final String rating;
  final String? etiqueta;
  final String categoria;
  final IconData icono;
  final String? imagenUrl;

  const Producto({
    required this.marca,
    required this.nombre,
    required this.detalle,
    required this.precio,
    this.anterior,
    required this.rating,
    this.etiqueta,
    required this.categoria,
    required this.icono,
    this.imagenUrl,
  });
}

const List<Producto> productos = [
  Producto(
    marca: 'ANGUS BLACK',
    nombre: 'Tomahawk IQF',
    detalle: 'Aprox. 1.2 kg',
    precio: '$29.740',
    rating: '4.9',
    etiqueta: '-15%',
    categoria: 'Vacuno',
    icono: Icons.restaurant,
  ),
  Producto(
    marca: 'DRY AGED 45D',
    nombre: 'Bife de Chorizo',
    detalle: 'Porción 500 g',
    precio: '$14.990',
    rating: '4.9',
    categoria: 'Vacuno',
    icono: Icons.restaurant,
  ),
  Producto(
    marca: 'PATAGONIA IQF',
    nombre: 'Salmón Austral',
    detalle: 'Filete 600 g',
    precio: '$16.800',
    rating: '4.9',
    categoria: 'Mariscos',
    icono: Icons.set_meal,
  ),
  Producto(
    marca: 'WAGYU A5 GRADE',
    nombre: 'Burgers Wagyu',
    detalle: '4 uds x 180 g',
    precio: '$18.990',
    rating: '4.9',
    etiqueta: 'TOP SELLER',
    categoria: 'Vacuno',
    icono: Icons.lunch_dining,
  ),
  Producto(
    marca: 'CALIBRE 16/20',
    nombre: 'Camarones Jumbo',
    detalle: 'Bolsa IQF 1.0 kg',
    precio: '$20.900',
    anterior: '$23.500',
    rating: '4.8',
    categoria: 'Mariscos',
    icono: Icons.set_meal,
  ),
  Producto(
    marca: 'DUROC PORK',
    nombre: 'Costillar Ahumado',
    detalle: 'Pieza 1.5 kg',
    precio: '$17.490',
    rating: '4.9',
    categoria: 'Pork & Cerdo',
    icono: Icons.restaurant,
  ),
];
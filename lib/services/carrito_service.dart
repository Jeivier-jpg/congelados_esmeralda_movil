import 'package:flutter/foundation.dart';
import 'package:congelados_esmeralda_movil/models/item_carrito.dart';
import 'package:congelados_esmeraldamovil/models/producto.dart';

/// Carrito compartido por toda la app (se guarda en memoria).
/// Las pantallas lo escuchan con ListenableBuilder para redibujarse solas.
class CarritoService extends ChangeNotifier {
  CarritoService.();
  static final CarritoService instancia = CarritoService._();

  /// Máximo de unidades de un mismo producto por pedido.
  static const int maxPorProducto = 10;

  final List<ItemCarrito> _items = [];

  List<ItemCarrito> get items => List.unmodifiable(_items);

  bool get estaVacio => _items.isEmpty;

  int get totalArticulos =>
      _items.fold(0, (suma, item) => suma + item.cantidad);

  int get subtotal => _items.fold(0, (suma, item) => suma + item.subtotal);

  /// Por ahora el envío es gratis.
  int get costoEnvio => 0;

  int get total => subtotal + costoEnvio;

  ItemCarrito? _buscar(Producto producto) {
    for (final item in _items) {
      if (item.producto.nombre == producto.nombre) return item;
    }
    return null;
  }

  /// Agrega unidades. Si el producto ya estaba, suma a lo que había.
  /// Devuelve la cantidad final de ese producto en el carrito.
  int agregar(Producto producto, {int cantidad = 1}) {
    final existente = _buscar(producto);
    if (existente != null) {
      existente.cantidad =
          (existente.cantidad + cantidad).clamp(1, maxPorProducto);
      notifyListeners();
      return existente.cantidad;
    }
    final nuevo = ItemCarrito(
      producto: producto,
      cantidad: cantidad.clamp(1, maxPorProducto),
    );
    _items.add(nuevo);
    notifyListeners();
    return nuevo.cantidad;
  }

  /// Cambia la cantidad. Con 0 o menos se quita el producto.
  void cambiarCantidad(Producto producto, int cantidad) {
    final item = _buscar(producto);
    if (item == null) return;
    if (cantidad <= 0) {
      _items.remove(item);
    } else {
      item.cantidad = cantidad.clamp(1, maxPorProducto);
    }
    notifyListeners();
  }

  void quitar(Producto producto) {
    _items.removeWhere((item) => item.producto.nombre == producto.nombre);
    notifyListeners();
  }

  void vaciar() {
    _items.clear();
    notifyListeners();
  }
}
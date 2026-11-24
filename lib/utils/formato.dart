/// "$29.740" -> 29740
int precioAEntero(String precio) =>
    int.tryParse(precio.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

/// 29740 -> "$29.740"
String formatearPrecio(int valor) {
  final s = valor.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return '\$$buffer';
}

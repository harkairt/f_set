import 'dart:math' as math;

extension IterableExt<T> on Iterable<Iterable<T>> {
  List<T> flatten() => expand((_) => _).toList();
}

extension IntExt on int {
  double get degrees => this * math.pi / 180;
}

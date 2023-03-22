extension ListX<T> on List<T> {
  T? get firstOrNull {
    if (isNotEmpty) first;
    return null;
  }

  T? get lastOrNull {
    if (isNotEmpty) last;
    return null;
  }
}

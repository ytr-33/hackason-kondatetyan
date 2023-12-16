extension ListToggleExtension<T> on List<T> {
  void toggle(T element) {
    if (contains(element)) {
      remove(element);
    } else {
      add(element);
    }
  }
}

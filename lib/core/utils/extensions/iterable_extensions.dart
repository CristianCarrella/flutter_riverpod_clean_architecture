import 'dart:math';

extension UsefulIterable<T> on Iterable<T> {
  /// Restituisce l'elemento all'indice specificato o null se l'indice è fuori dai limiti.
  /// Evita l'eccezione RangeError.
  T? elementAtOrNull(int index) {
    if (index < 0) return null;
    int count = 0;
    for (var element in this) {
      if (count == index) return element;
      count++;
    }
    return null;
  }

  /// Inserisce un elemento separatore tra ogni elemento dell'iterable.
  /// utile per inserire spaziatori (SizedBox) tra i widget.
  Iterable<T> intersperse(T separator) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield separator;
        yield iterator.current;
      }
    }
  }

  /// Restituisce una nuova lista contenente solo elementi distinti in base a una proprietà specifica.
  List<T> distinctBy<K>(K Function(T) selector) {
    final seenKeys = <K>{};
    final result = <T>[];
    for (var element in this) {
      final key = selector(element);
      if (seenKeys.add(key)) {
        result.add(element);
      }
    }
    return result;
  }

  /// Converte l'Iterable in una Mappa usando una funzione per generare le chiavi.
  /// Se ci sono chiavi duplicate, l'ultimo elemento sovrascriverà i precedenti.
  Map<K, T> associateBy<K>(K Function(T) keySelector) {
    return {for (var element in this) keySelector(element): element};
  }

  /// Restituisce un elemento casuale dalla lista.
  T? get randomOrNull {
    if (isEmpty) return null;
    if (length == 1) return first;
    return elementAt(Random().nextInt(length));
  }

  /// Esegue un'azione su ogni elemento e restituisce l'iterable originale.
  /// Ottimo per il logging all'interno di una catena di metodi.
  Iterable<T> peek(void Function(T) action) {
    for (var element in this) {
      action(element);
    }
    return this;
  }
}

extension NumericIterable on Iterable<num> {
  num get sum => fold(0, (a, b) => a + b);

  double get average {
    if (isEmpty) return 0.0;
    return sum / length;
  }
}

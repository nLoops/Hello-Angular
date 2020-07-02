import 'hero.dart';
import 'mock_heroes.dart';
import 'dart:async';

class HeroService {
  List<Hero> getAll() => mockHeroes;

  Future<List<Hero>> getAllFuture() {
    return Future.delayed(Duration(seconds: 2), () => getAll());
  }

  Future<Hero> get(int id) async =>
      (await getAllFuture()).firstWhere((hero) => hero.id == id);
}

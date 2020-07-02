import 'package:angular/angular.dart';
import 'hero.dart';
import 'hero_service.dart';
import 'package:angular_router/angular_router.dart';
import 'route_paths.dart';

@Component(
    selector: 'my-heroes',
    templateUrl: 'hero_list_component.html',
    styleUrls: ['hero_list_component.css'],
    directives: [coreDirectives],
    pipes: [commonPipes])
class HeroListComponent implements OnInit {
  final HeroService _heroService;
  final Router _router;

  HeroListComponent(this._heroService, this._router);

  List<Hero> heroes;
  bool loading = true;

  Future<void> _getHeroes() async {
    heroes = await _heroService.getAll();
    loading = false;
  }

  Hero selected;

  void onSelect(Hero hero) => selected = hero;

  void ngOnInit() => _getHeroes();

  String _heroUrl(int id) =>
      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> gotoDetail() =>
      _router.navigate(_heroUrl(selected.id));

  Future<void> add(String name) async {
    name = name.trim();
    if (name.isEmpty) return null;
    heroes.add(await _heroService.create(name));
    selected = null;
  }

  Future<void> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    heroes.remove(hero);
    if (selected == hero) selected = null;
  }
}

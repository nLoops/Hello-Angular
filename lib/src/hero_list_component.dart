import 'package:angular/angular.dart';
import 'hero.dart';
import 'hero_component.dart';
import 'hero_service.dart';

@Component(
    selector: 'my-heroes',
    templateUrl: 'hero_list_component.html',
    styleUrls: ['hero_list_component.css'],
    directives: [coreDirectives, HeroComponent])
class HeroListComponent implements OnInit {
  final HeroService _heroService;

  HeroListComponent(this._heroService);

  List<Hero> heroes;
  bool loading = true;

  Future<void> _getHeroes() async {
    heroes = await _heroService.getAllFuture();
    loading = false;
  }

  Hero selected;

  void onSelect(Hero hero) => selected = hero;

  void ngOnInit() => _getHeroes();
}

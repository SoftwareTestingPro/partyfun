import '../models/player.dart';
import 'game_controller.dart';

class CardsController extends GameController {
  static final CardsController _instance = CardsController._internal();
  factory CardsController() => _instance;
  CardsController._internal();

  Player get lastActivePlayer {
    if (players.isEmpty) return Player(name: "Guest", gender: Gender.male);
    return players[(currentPlayerIndex - 1 + players.length) % players.length];
  }
}

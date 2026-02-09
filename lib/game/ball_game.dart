import 'package:flame/game.dart';
import 'game_state.dart';
import 'systems/timer_system.dart';
import 'package:ball_game/utils/constants.dart';


class BallGame extends FlameGame {
    late final GameState gameState;

    @override
    Future<void> onLoad() async {
        super.onLoad();

        final timer = TimerSystem( initialTime: initialGameTime );
        gameState = GameState( timer: timer );

        gameState.startGame();
    }

    @override
    void update( double dt ) {
        super.update( dt );

        gameState.update( dt );

        if ( gameState.isGameOver ) {
            pauseEngine();
            overlays.add( overlayGameOver );
        }

        if ( gameState.isVictory ) {
            pauseEngine();
            overlays.add( overlayVictory );
        }
    }
}
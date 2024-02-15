import 'package:flutter/material.dart';

import '../asteroids.dart';

class Tutorial extends StatefulWidget {

  const Tutorial({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<Tutorial> createState() => _TutorialState();
}

// TODO: resize this dynamically on mobile
// TODO: load in ship, scoreboard, and lives during tutorial
class _TutorialState extends State<Tutorial> {

  var _tutorialText = """Use WAD to steer the spaceship and SPACEBAR to shoot. Colliding with an asteroid will cost you a life. Be careful, since you only have three! Try to make it as high as you can on the leaderboard, but watch out: I've heard we're not alone in space...""";
  var _startText = "Press SPACE to start!";

  @override 
  Widget build(BuildContext context) {
    return Center( 
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.end,
        children: [ 
           Container( 
            constraints: const BoxConstraints(
              minWidth: 375,
              maxWidth: 1024,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.75),
              shape: const ContinuousRectangleBorder(
                side: BorderSide(
                  color: Colors.white, 
                  width: 2))),
            child: Center(
              child: Column( 
                children: [
                  Text(_tutorialText,
                    style: Theme.of(context).textTheme.bodyMedium),

                  Text(_startText,
                    style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ], 
      ),
    );
  }
}

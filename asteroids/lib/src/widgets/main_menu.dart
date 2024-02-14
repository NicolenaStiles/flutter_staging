import 'dart:ui';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class MainMenu extends StatefulWidget {

  const MainMenu({ 
    super.key,
    required this.game,
  });
  final Asteroids game;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

// TODO: resize this dynamically on mobile
class _MainMenuState extends State<MainMenu> {

  TextStyle _buttonTextStyle = TextStyle();

  @override
  void initState() {
    super.initState();

    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    if (width < 500) {
      _buttonTextStyle = Theme.of(context).textTheme.bodyMedium!;
    } else  {
      _buttonTextStyle = Theme.of(context).textTheme.titleMedium!;
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Center ( 
      child: Container( 
        constraints: const BoxConstraints(
          maxWidth: 512,
          maxHeight: 512,
        ),
        padding: const EdgeInsets.all(10),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
    
              Column( 
                mainAxisSize: MainAxisSize.min,
                children: [ 
                Text('(definitely not)',
                  style: Theme.of(context).textTheme.headlineSmall),

                Text('ASTEROIDS',
                  style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 

                // start button
                OutlinedButton(
                  onPressed: () {
                    widget.game.playState = PlayState.tutorial; 
                  },
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.white, 
                        width: 2))),
                  child: 
                    Text('start game',
                      style: _buttonTextStyle),
                    ),

                // leaderboard 
                OutlinedButton(
                  onPressed: () {
                    widget.game.playState = PlayState.leaderboard; 
                  },
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.white, 
                        width: 2))),
                  child: 
                    Text('leaderboard',
                      style: _buttonTextStyle),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

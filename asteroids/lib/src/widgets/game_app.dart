import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../asteroids.dart';

import '../theme.dart';

class GameApp extends StatefulWidget {

  const GameApp({
    super.key,
    required this.isMobile,
  });
  final bool isMobile;
  
  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: websiteTheme,
      home: Scaffold ( 
        body: GameWidget.controlled(
          gameFactory: Asteroids.new,
          overlayBuilderMap: { 
            PlayState.background.name: (context, game) =>
              Center(
                child: Text("animating background... "),
              ),
            PlayState.mainMenu.name: (BuildContext context, Asteroids game) => 
              Center ( 
                child: Container( 
                  constraints: const BoxConstraints(
                    minWidth: 375,
                    maxWidth: 512,
                    minHeight: 375,
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
                              game.playState = PlayState.background; 
                            },
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  color: Colors.white, 
                                  width: 2))),
                            child: 
                              Text('start game',
                                style: Theme.of(context).textTheme.titleMedium),
                              ),

                          // leaderboard 
                          OutlinedButton(
                            onPressed: () {}, 
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  color: Colors.white, 
                                  width: 2))),
                            child: 
                              Text('leaderboard',
                                style: Theme.of(context).textTheme.titleMedium),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            PlayState.tutorial.name: (context, game) =>
              Center( 
                child: Text("this is the tutorial menu"),
              ),
            PlayState.gameOver.name: (context, game) =>
              Center( 
                child: Text("this is the game over screen"),
              ),
          },
        ),
      ),
    );
  }
}

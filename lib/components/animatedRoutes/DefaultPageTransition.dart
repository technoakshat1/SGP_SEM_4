import 'package:flutter/Material.dart';

class DefaultPageTransition extends Route {
  DefaultPageTransition(this.screen);
  final Widget screen;

  Route createRoute() {
    return PageRouteBuilder(
        pageBuilder: (_, animation, anotherAnimation) {
          return screen;
        },
        transitionDuration: Duration(seconds: 1),
        transitionsBuilder: (_, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
            curve: Curves.easeInOut,
            parent: animation,
          );
          return Align(
              child: SlideTransition(
            position: Tween(
              begin: Offset(1.0, 0.0),
              end: Offset(
                0.0,
                0.0,
              ),
            ).animate(animation),
            child: child,
          ));
        });
  }
}

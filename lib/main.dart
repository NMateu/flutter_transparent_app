import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(RootWidget());

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: Locale('en'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Directionality(
        child: Navigator(
          onGenerateRoute: generate,
          onUnknownRoute: unKnownRoute,
          initialRoute: '/',
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }

  Route generate(RouteSettings settings) {
    Route page;
    switch (settings.name) {
      case "/":
        page = PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation<double> animation, Animation<double> secondaryAnimation) {
          return DialogWidget();
        }, transitionsBuilder: (_, Animation<double> animation,
            Animation<double> second, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(second),
              child: child,
            ),
          );
        });
        break;
    }
    return page;
  }

  Route unKnownRoute(RouteSettings settings) {
    return new PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation<double> animation, Animation<double> secondaryAnimation) {
      return DialogWidget();
    });
  }
}

class DialogWidget extends StatefulWidget {
  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Hello from flutter'),
        onPressed: _showDialog,
      ),
    );
  }

  void _showDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Builder(builder: (BuildContext context) {
            return MaterialApp(
              home: AlertDialog(
                backgroundColor: Colors.white,
                title: Text('Hello from flutter'),
                content: Text('That is the transparent dialog'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
        },
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 150),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          );
        });
  }
}
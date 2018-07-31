import 'package:cine_reel/Constants.dart';
import 'package:cine_reel/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
	MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
			: super(builder: builder, settings: settings);

	@override
	Widget buildTransitions(BuildContext context,
			Animation<double> animation,
			Animation<double> secondaryAnimation,
			Widget child) {
		if (settings.isInitialRoute)
			return child;
		// Fades between routes. (If you don't want any animation,
		// just return child.)
		return new FadeTransition(opacity: animation, child: child);
	}
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
	final title = APP_NAME;

	// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title,
      theme: new ThemeData(
				dividerColor: Colors.white,
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
				accentColor: Colors.deepOrange,
      ),
			home: HomePage(title: title),
    );
  }
}
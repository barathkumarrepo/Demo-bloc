import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/bloc/product_bloc.dart';
import 'package:sample/src/bloc/product_event.dart';
import 'package:sample/src/product.dart';
import 'package:sample/utils/bloc.dart';

import 'config/locator.dart';

void main() {
  Bloc.observer = EchoBlocDelegate();
  setupLocator();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<ProductBloc>(
              create: (context) =>
              ProductBloc(),
            ),

          ],
          child:MyApp()
      )
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  ProductPage(),
    );
  }
}



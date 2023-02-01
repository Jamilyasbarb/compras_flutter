import 'package:compras_vita_health/controllers/produto_controller.dart';
import 'package:compras_vita_health/pages/cadastro/cadastro_page.dart';
import 'package:compras_vita_health/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProdutoController(),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: const  ColorScheme.light(
            primary: Color.fromRGBO(255, 68, 56, 1),
            secondary: Color.fromRGBO(64, 64, 65, 0),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'MontserratAlternates'
            ),
          ),
          fontFamily: 'MontserratAlternates',
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => HomePage(),
          'cadastro':(context) => CadastroPage(),
        },
      ),
    );
  }
}
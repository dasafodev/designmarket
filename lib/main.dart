import 'package:desigmarket/features/auth/auth_view.dart';
import 'package:desigmarket/features/stocks/repository/stocks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => StocksRepository(token: "finnhub_token"),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DesignMarket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const AuthView(),
      ),
    );
  }
}

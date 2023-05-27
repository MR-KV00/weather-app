import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whater/feature/feature_whater/presentation/block/home_bloc.dart';
import 'package:whater/locator.dart';
import 'core/presentation/ui/mainWraper.dart';

void main() async {
  await setup();

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home:MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => locator<HomeBloc>() )
            ],
            child: const MainWrapper()),
      ));
}





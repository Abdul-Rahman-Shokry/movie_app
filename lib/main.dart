import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/api_client.dart';
import 'core/style/app_themes.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/search/cubit/search_cubit.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final ApiClient apiClient = ApiClient(Dio());

  runApp(MyApp(prefs: prefs, apiClient: apiClient));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final ApiClient apiClient;

  const MyApp({super.key, required this.prefs, required this.apiClient});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(apiClient)..fetchHomeMovies(),
        ),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit(apiClient)),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit(prefs)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Movie App',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRouter.homeRoute,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

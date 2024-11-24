import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/provider/recipes_provider.dart';
import 'package:recipe_book/screens/favorites_recipe.dart';
import 'package:recipe_book/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecipesProvider())],
      child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Recipe Book',
          home: RecipeBook()),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'Recipe Book',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorites',),
          ]),
        ),
        body: TabBarView(children: 
        [HomeScreen(),
        FavoritesRecipe()]),
      ),
    );
  }
}

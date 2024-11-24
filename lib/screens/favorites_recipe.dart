import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/provider/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FavoritesRecipe extends StatelessWidget {
  const FavoritesRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (BuildContext context, recipeProvider, child) {
          final favoriteRecipes = recipeProvider.favoriteRecipe;
          return favoriteRecipes.isEmpty ? 
            Center(child: Text(AppLocalizations.of(context)!.noFavorites))  
            : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index){
                 
                final recipe = favoriteRecipes[index];
                return favoriteRecipesCard(recipe: recipe);
              },
            );
        },   
      ),
    );
  }
}

class favoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;
  const favoriteRecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipesData: recipe),
          ),
        );
      },
      child: Semantics(
        label: 'Targeta de receta ${recipe.name}',
        hint: 'Toca para ver el detalle de la receta: ${recipe.name}',
        child: Card( 
        child: Row(children: [
          Container(
            height: 125,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe.imageLink,
                fit: BoxFit.cover,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite, color: Colors.orange,),
              Text(
                recipe.name,
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 4),
              Container(
                height: 2,
                width: 75,
                color: Colors.orange,
              ),
              Text(
                recipe.author,
                style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
              ),
              SizedBox(height: 4),
            ],
            ),
          ),
        ],
        ),
            ),
      ));
  }
}
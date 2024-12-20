import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:recipe_book/provider/recipes_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context, listen: false);
    recipesProvider.fetchRecipes();

    return Scaffold(
      body: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.recipes.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noRecipes),);
          } else {
            return ListView.builder(
              itemCount: provider.recipes.length,
              itemBuilder: (context, index) {
                return _RecipesCard(context, provider.recipes[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return RecipeForm();
      },
    );
  }

  Widget _RecipesCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipesData: recipe),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      recipe.imageLink ?? 'https://example.com/default_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.name ?? 'No Name',
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 75,
                      color: Colors.orange,
                    ),
                    Text(
                      recipe.author ?? 'No Author',
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  RecipeForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _authorNode = FocusNode();
  final FocusNode _imgNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();

  final TextEditingController _recipeName = TextEditingController();
  final TextEditingController _recipeAuthor = TextEditingController();
  final TextEditingController _recipeIMG = TextEditingController();
  final TextEditingController _recipeDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: GestureDetector(
        onTap: () {
          if (!FocusScope.of(context).hasPrimaryFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    'Add new Recipe',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      _BuildTextField(
                        label: 'Recipe Name',
                        controller: _recipeName,
                        focusNode: _nameNode,
                        nextFocusNode: _authorNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a recipe name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      _BuildTextField(
                        label: 'Author',
                        controller: _recipeAuthor,
                        focusNode: _authorNode,
                        nextFocusNode: _imgNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an author';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      _BuildTextField(
                        label: 'Image URL',
                        controller: _recipeIMG,
                        focusNode: _imgNode,
                        nextFocusNode: _descriptionNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      _BuildTextField(
                        label: 'Recipe',
                        maxLines: 4,
                        controller: _recipeDescription,
                        focusNode: _descriptionNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Save Recipe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _BuildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    int maxLines = 1,
    context
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.orange,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      maxLines: maxLines,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
    );
  }
}

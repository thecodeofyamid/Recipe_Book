import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _RecipesCard(context),
          _RecipesCard(context),
          _RecipesCard(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (contexto) => Container(
        width: MediaQuery.of(contexto).size.width,
        height: 500,
        color: Colors.white,
        child: RecipeForm(),
      ),
    );
  }

  Widget _RecipesCard(BuildContext context) {
    return Padding(
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
                  child: Image.asset('assets/images/lasagna-2.webp', fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 26,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('LASAGNA', style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),),
                  SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.orange,
                  ),
                  Text('Yamid Horacio Rodríguez', style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),),
                  SizedBox(height: 4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeIMG = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add new Recipe', 
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24,),),
              SizedBox(height: 16,),
              Column(
                children: [
                  _BuildTextField(label: 'Recipe Name', controller: _recipeName,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter a recipe name';
                    }else{
                      return null;
                    }
                  }),
                  SizedBox(height: 10,),
                  _BuildTextField(label: 'Author' , controller: _recipeAuthor,  
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter a  author recipe';
                    }else{
                      return null;
                    }
                  }),
                  SizedBox(height: 10,),
                  _BuildTextField(label : 'Image URL', controller: _recipeIMG,  
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter a image url';
                    }else{
                      return null;
                    }
                  }),
                  SizedBox(height: 10,),
                  _BuildTextField(label: 'Recipe' , 
                   maxLines: 4,
                   controller: _recipeDescription,
                   validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter a description';
                    }else{
                      return null;
                    }
                  }),
                  SizedBox(height: 10,),
                  Center(child: ElevatedButton(
                  onPressed : (){
                    if (_formKey.currentState!.validate()){
                    Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  child: Text('Save Recipe', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),),)
                ]
              )
          ],
        ),
      ),
    );
  }

  Widget _BuildTextField({
  required String label, 
  required  TextEditingController controller,
  required String? Function(String?) validator, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily:'Quicksand',
          color: Colors.orange
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        )  
      ),
      validator: validator,
      maxLines: maxLines,  
      );
  }
}
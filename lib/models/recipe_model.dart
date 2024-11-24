class Recipe{
  int id;
  String name;
  String author;
  String imageLink;
  List<String> description;

  Recipe({
    required this.id,
    required this.name,
    required this.author,
    required this.imageLink,
    required this.description,
  });


  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      imageLink: json['image_link'],
      description: List<String>.from(json['recipe']),
    );
  }

  get recipeSteps => null;

  Map<String, dynamic> toJson(){
  return{
    'id': id,
    'name': name,
    'author': author,
    'image_link': imageLink,
    'recipe': description,
    };
  }

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, author: $author, imageLink: $imageLink, description: $description)';
  }
}
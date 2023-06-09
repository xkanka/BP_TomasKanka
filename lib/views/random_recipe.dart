import 'package:flutter/material.dart';
import 'package:kanofit/classes/main_theme.dart';
import '../controllers/random_recipe_controller.dart';

import '../models/cooking.dart';

class RandomRecipePage extends StatefulWidget {
  @override
  _RandomRecipePageState createState() => _RandomRecipePageState();
}

class _RandomRecipePageState extends State<RandomRecipePage> {
  late Future<Recipe> _randomRecipe;
  final RandomRecipeController _controller = RandomRecipeController();

  @override
  void initState() {
    super.initState();
    _randomRecipe = _controller.fetchRecipes();
  }

  Widget buildTagPill(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFEE8B60),
      ),
      child: Text(tag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recept na chudnutie')),
      body: SingleChildScrollView(
        child: FutureBuilder<Recipe>(
          future: _randomRecipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recipe = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif', // Set your own local image or gif
                    image: recipe.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Wrap(
                          children: recipe.tags.map((tag) => buildTagPill(tag.split('-').join(' '))).toList(),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kalórie', style: TextStyle(fontSize: 14)),
                                Text('${recipe.nutrients.caloriesKCal} kcal',
                                    style: TextStyle(fontSize: 12, color: MainTheme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bielkoviny', style: TextStyle(fontSize: 14)),
                                Text('${recipe.nutrients.protein} g',
                                    style: TextStyle(fontSize: 12, color: MainTheme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tuky', style: TextStyle(fontSize: 14)),
                                Text('${recipe.nutrients.fat} g',
                                    style: TextStyle(fontSize: 12, color: MainTheme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sacharidy', style: TextStyle(fontSize: 14)),
                                Text('${recipe.nutrients.totalCarbs} g',
                                    style: TextStyle(fontSize: 12, color: MainTheme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Ako na to:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ...recipe.steps.map((step) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_right, size: 16, color: MainTheme.of(context).primaryColor),
                                  SizedBox(width: 8),
                                  Expanded(child: Text(step, style: TextStyle(fontSize: 14))),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: CircularProgressIndicator(), heightFactor: 2);
          },
        ),
      ),
    );
  }
}

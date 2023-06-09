import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/cooking.dart';
import 'package:google_translate/google_translate.dart';

class RandomRecipeController {
  // Move the fetchRecipes() function from the original StatefulWidget class to this controller
  Future<Recipe> fetchRecipes() async {
    var randomTags = pickTags();
    final response = await http.get(
      Uri.parse(
        'https://low-carb-recipes.p.rapidapi.com/search?tags=$randomTags&maxCalories=520&limit=20',
      ),
      headers: {
        'X-RapidAPI-Key': 'a96ed67c9cmshfc2bcc11e8d3494p177170jsn69c86a5cd2a7',
        'X-RapidAPI-Host': 'low-carb-recipes.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      jsonResponse.shuffle(); // Randomize the list, so it fetches new random item
      Recipe recipe = jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList()[0];
      recipe.name = await recipe.name.translate();
      for (int i = 0; i < recipe.steps.length; i++) {
        recipe.steps[i] = await recipe.steps[i].translate();
      }
      for (int i = 0; i < recipe.tags.length; i++) {
        recipe.tags[i] = await recipe.tags[i].translate();
      }

      return recipe;
    } else {
      // Log error
      print(response.body);
      throw Exception('Failed to load recipes');
    }
  }

// Add any other methods related to handling cooking recipes or fetching from API
}

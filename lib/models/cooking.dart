import 'dart:math';

const List<String> recipeTags = [
  "15-minute-meals",
  "3-ingredient-meals",
  "5-ingredient-meals",
  "appetizer",
  "beef-free",
  "beverages",
  "breakfast",
  "chicken-free",
  "dairy-free",
  "desserts",
  "egg-free",
  "eggs",
  "fish",
  "fish-free",
  "freezer-friendly",
  "french",
  "gluten-free",
  "good-for-leftovers",
  "grains",
  "high-protein",
  "keto",
  "kid-friendly",
  "lchf",
  "low-carb",
  "lunch",
  "main-dishes",
  "meal-plan-ok",
  "msg",
  "no-cooking-required",
  "one-pot-meals",
  "paleo",
  "pantry-recipes",
  "peanut-free",
  "peanuts",
  "pescatarian",
  "pork-free",
  "quick-easy",
  "relevant-meal--beverages",
  "relevant-meal--breakfast",
  "relevant-meal--desserts",
  "relevant-meal--lunch",
  "relevant-meal--main-dishes",
  "relevant-meal--salads",
  "relevant-meal--sides",
  "relevant-meal--snacks",
  "salads",
  "sheet-pan-dinners",
  "shellfish",
  "shellfish-free",
  "sides",
  "skillet",
  "snacks",
  "soy-free",
  "sulphites",
  "tree-nut-free",
  "vegan",
  "vegetarian",
  "wheat-free",
  "whole-30",
];

String pickTags() {
  Random random = Random();
  int numberOfTags = random.nextInt(1) + 1; // Picks a random number between 1 and 3.
  List<String> selectedTags = [];

  for (int i = 0; i < numberOfTags; i++) {
    int tagIndex = random.nextInt(recipeTags.length);
    String tag = recipeTags[tagIndex];

    // Check if the tag is already selected, if not, add it to the list.
    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag);
    } else {
      i--; // If the tag is already selected, decrement the counter to pick another one.
    }
  }

  return selectedTags.join(';');
}

class Recipe {
  String id;
  String name;
  List<String> tags;
  String description;
  int prepareTime;
  int cookTime;
  List<Ingredient> ingredients;
  List<String> steps;
  int servings;
  List<ServingSize> servingSizes;
  Nutrients nutrients;
  String imageUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.tags,
    required this.description,
    required this.prepareTime,
    required this.cookTime,
    required this.ingredients,
    required this.steps,
    required this.servings,
    required this.servingSizes,
    required this.nutrients,
    required this.imageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    Recipe recipe = Recipe(
      id: json['id'],
      name: json['name'],
      tags: List<String>.from(json['tags']),
      description: json['description'],
      prepareTime: json['prepareTime'],
      cookTime: json['cookTime'],
      ingredients: (json['ingredients'] as List).map((ingredient) => Ingredient.fromJson(ingredient)).toList(),
      steps: List<String>.from(json['steps']),
      servings: json['servings'],
      servingSizes: (json['servingSizes'] as List).map((servingSize) => ServingSize.fromJson(servingSize)).toList(),
      nutrients: Nutrients.fromJson(json['nutrients']),
      imageUrl: json['image'],
    );
    return recipe;
  }
}

class Ingredient {
  String name;
  IngredientServingSize servingSize;

  Ingredient({required this.name, required this.servingSize});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      servingSize: IngredientServingSize.fromJson(json['servingSize']),
    );
  }
}

class IngredientServingSize {
  String units;
  String? desc;
  double? qty;
  double? grams;
  double? scale;

  IngredientServingSize({
    required this.units,
    this.desc,
    required this.qty,
    required this.grams,
    required this.scale,
  });

  factory IngredientServingSize.fromJson(Map<String, dynamic> json) {
    return IngredientServingSize(
      units: json['units'],
      desc: json['desc'],
      qty: json['qty']?.toDouble(),
      grams: json['grams']?.toDouble(),
      scale: json['scale']?.toDouble(),
    );
  }
}

class ServingSize {
  double? scale;
  double? qty;
  double? grams;
  String units;
  double? originalWeight;
  String? originalWeightUnits;

  ServingSize({
    required this.scale,
    required this.qty,
    required this.grams,
    required this.units,
    this.originalWeight,
    this.originalWeightUnits,
  });

  factory ServingSize.fromJson(Map<String, dynamic> json) {
    return ServingSize(
      scale: json['scale']?.toDouble(),
      qty: json['qty']?.toDouble(),
      grams: json['grams']?.toDouble(),
      units: json['units'],
      originalWeight: json['originalWeight']?.toDouble(),
      originalWeightUnits: json['originalWeightUnits'],
    );
  }
}

class Nutrients {
  // Add all the nutrient properties from the JSON schema
  // For example:
  double? caloriesKCal;
  double? totalCarbs;
  double? protein;
  double? fat;

  Nutrients({
    required this.caloriesKCal,
    required this.totalCarbs,
    required this.protein,
    required this.fat,
    // Add the other nutrient properties here
  });

  factory Nutrients.fromJson(Map<String, dynamic> json) {
    return Nutrients(
      caloriesKCal: json['caloriesKCal']?.toDouble(),
      totalCarbs: json['totalCarbs']?.toDouble(),
      protein: json['protein']?.toDouble(),
      fat: json['fat']?.toDouble(),
      // Add the other nutrient properties here
    );
  }
}

import 'package:foodies/generated/assets.dart';
import 'package:foodies/model/recipe_model.dart';

class Database {
  static const List<String> preferences = [
    'Vegetarian',
    'Non-vegetarian',
    'Semi-vegetarian',
  ];

  static const List<String> cuisines = [
    'All Cuisines',
    'African Cuisine',
    'American Cuisine',
    'Argentinian Cuisine',
    'Bengali Cuisine',
    'Brazilian Cuisine',
    'Caribbean Cuisine',
    'Chinese Cuisine',
    'Cuban Cuisine',
    'East Indian Cuisine',
    'Ethiopian Cuisine',
    'Filipino Cuisine',
    'French Cuisine',
    'German Cuisine',
    'Goan Cuisine',
    'Greek Cuisine',
    'Gujarati Cuisine',
    'Hyderabadi Cuisine',
    'Indian Cuisine',
    'Iranian (Persian) Cuisine',
    'Italian Cuisine',
    'Japanese Cuisine',
    'Kashmiri Cuisine',
    'Kerala Cuisine',
    'Korean Cuisine',
    'Lebanese Cuisine',
    'Madhya Pradesh Cuisine',
    'Maharashtrian Cuisine',
    'Malaysian Cuisine',
    'Manipuri Cuisine',
    'Mediterranean Cuisine',
    'Mexican Cuisine',
    'Middle Eastern Cuisine',
    'Moroccan Cuisine',
    'North Indian Cuisine',
    'Northeast Indian Cuisine',
    'Odia Cuisine',
    'Peruvian Cuisine',
    'Portuguese Cuisine',
    'Punjabi Cuisine',
    'Rajasthani Cuisine',
    'Russian Cuisine',
    'South Indian Cuisine',
    'Spanish Cuisine',
    'Swedish Cuisine',
    'Tamil Cuisine',
    'Thai Cuisine',
    'Turkish Cuisine',
    'Uttar Pradesh Cuisine',
    'Vietnamese Cuisine',
    'West Indian Cuisine',
  ];

  static const List<String> categories = [
    'All Categories',
    'Appetizers/Starters',
    'Soups and Salads',
    'Main Courses/Entrees',
    'Pasta/Rice/Noodles',
    'Seafood',
    'Side Dishes',
    'Beverages',
    'Desserts',
    'Specials',
    'Kids Menu',
    'Breads',
  ];

  static List<RecipeModel> recipes = [
    RecipeModel(
      id: 000000,
      name: 'BBQ Chicken',
      cuisine: 'American Cuisine',
      description:
          'Barbecue chicken consists of chicken parts or entire chickens that are barbecued, grilled or smoked. There are many global and regional preparation techniques and cooking styles. Barbecue chicken is often seasoned or coated in a spice rub, barbecue sauce, or both.',
      time: '6-10 mins for boneless and 10-14 mins for bone-in',
      chef: null,
      veg: false,
      categories: [
        'Main Courses/Entrees',
      ],
      ingredients: [],
      steps: [],
      image: Assets.foodImagesBbqChicken,
    ),
    RecipeModel(
      id: 000001,
      name: 'Veggie Okonomiyaki',
      cuisine: 'Japanese Cuisine',
      description:
          'Okonomiyaki is a popular pan-fried dish that consists of batter and cabbage. Selected toppings and ingredients are added which can vary greatly (anything from meat and seafood to wasabi and cheese). This variability is reflected in the dish\'s name; "okonomi" literally means "to one\'s liking".',
      time:
          '5-7 mins in Griddle or Pan, 4-6 mins in Teppanyaki Grill and 10-15 mins in Oven at 350°F (175°C)',
      chef: null,
      veg: true,
      categories: [
        'Main Courses/Entrees',
      ],
      ingredients: [],
      steps: [],
      image: Assets.foodImagesVeggieOkonomiyaki,
    ),
    RecipeModel(
      id: 000002,
      name: 'Prawn Salad',
      cuisine: 'Spanish Cuisine',
      description:
          'This vibrant prawn salad is a great lunchtime option whether you’re on the go, at work or fancy a quick bite to eat in the sunshine at the weekend. It’s packed full of fresh, yummy goodness. King prawns are fried in garlic, chilli and lime before being tossed together in an aromatic salad and drizzled with a honey, soy and ginger dressing to add some ‘zing’ to your day.',
      time:
          '2-4 mins for Boiling, 3-5 mins for Grilling and 10-15 mins for Baking at 375°F (190°C)',
      chef: null,
      veg: false,
      categories: [
        'Soups and Salads',
        'Seafood',
      ],
      ingredients: [],
      steps: [],
      image: Assets.foodImagesPrawnSalad,
    ),
    RecipeModel(
      id: 000003,
      name: 'Prawn Yellow Rice',
      cuisine: 'Spanish Cuisine',
      description:
          '"Prawn Yellow Rice" is a flavorful and vibrant dish that combines the succulence of prawns with the aromatic and visually appealing hues of yellow rice. This dish is a culinary delight, often associated with various cultural cuisines that embrace the use of spices to infuse both color and taste.',
      time: '25-60 mins',
      chef: 'user_181',
      veg: false,
      categories: [
        'Main Courses/Entrees',
        'Seafood',
      ],
      ingredients: [],
      steps: [],
      image: Assets.foodImagesPrawnYellowRice,
    ),
  ];
}

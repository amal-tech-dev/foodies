class StringConstant {
  static const String appName = 'Foodies';
  static const String appNamePartOne = 'Food';
  static const String appNamePartTwo = 'ies';
  static const String welcomeTitle = 'Welcome to ${StringConstant.appName}';
  static const String welcomeSubtitle =
      'Welcome, fellow food enthusiasts! Get ready to embark on a delectable journey of flavors and culinary delights.';
  static const String carouselTitle1 = 'Find Recipes';
  static const String carouselTitle2 = 'Add Your Own Recipes';
  static const String carouselTitle3 = 'Cook with ${StringConstant.appName}';
  static const String carouselSubtitle1 =
      'Find Recipes that Suit Your Palate. Uncover a World of Culinary Delights with Our Easy-to-Use Recipe Search Platform.';
  static const String carouselSubtitle2 =
      'Add Your Own Recipes and Contribute to a Growing Community of Food Enthusiasts.';
  static const String carouselSubtitle3 =
      'Cook with ${StringConstant.appName} and Elevate Your Kitchen Skills with Step-by-Step Guidance and Tasty Results.';
  static const String login = 'Let\'s You In';
  static const String signup = 'Create New Account';
  static const String forgetPassword = 'Enter Your Registered Email Id';
  static const String selectDiet =
      'Indicate your preferred dietary choice. This will assist ${StringConstant.appName} in customizing your meals to suit your taste';
  static const String selectCuisine =
      'Choose one or more cuisines to help ${StringConstant.appName} to tailor recommendations and offerings to suit your taste.';
  static const String addRecipeGuest = 'You need an account to add recipes';
  static const String addRecipeUser =
      'Spice up your culinary journey on ${StringConstant.appName}. Share your favorite recipes, add your unique twist, and build a following of fellow food enthusiasts. Connect, inspire, and savor the delicious world of home cooking together!';
  static const String search =
      'Search Recipes by Name, Cuisines, Categories or Users';
  static const String noResults = 'No results found, check your spelling';
  static const String emptyMenu =
      'Your Menu is empty. Add your favourites Recipes to Kitchen for easy access.';
  static const String logoutAlert = 'Do you want to logout?';
  static const String logoutAlertGuest =
      'You are loggedin as guest. Data will be deleted after logging out. ${StringConstant.logoutAlert}';
  static const String addIngredients =
      'Try to add Ingredient name with required quantity.';
  static const String addSteps =
      'Try to add Steps precise and easy to understand.';
  static const String addImage =
      'Now add a clear image of your dish similar to below images.';
  static const String previewRecipe =
      'Thank you for sharing your recipe with ${StringConstant.appName}. Can\'t wait to try it out.';
  static const String saveRecipe =
      'Your recipe is ready. Smells good! Share your recipe with ${StringConstant.appName} and let other Food enthusiasts know about your Recipe.';
  static const String cookingPreparation =
      'Excellent choice. Now lets start with gathering ingredients.';
  static const String cookingPantry =
      'Let\'s gather the required ingredients one by one.';
  static const String serveRecipe =
      'Your recipe is ready to serve. Hope you like it.';
  static const String notificationTitle = 'Your food is overcooking!';
  static const String notificationBody =
      'Chef, your dish is at risk of overcooking or spoiling. It\'s time to take action and ensure the perfect meal. Check on it now!';

  static const List<String> diet = [
    'Vegetarian',
    'Non-Vegetarian',
    'Semi-Vegetarian',
  ];

  static const List<String> categories = [
    'All',
    'Appetizers/Starters',
    'Breads',
    'Beverages',
    'Desserts',
    'Kids Menu',
    'Main Courses/Entrees',
    'Pasta/Rice/Noodles',
    'Seafood',
    'Side Dishes',
    'Soups and Salads',
    'Specials',
  ];

  static const List<String> cuisines = [
    'All',
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
}

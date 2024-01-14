import 'package:foodies/generated/assets.dart';
import 'package:foodies/model/recipe_model.dart';

class Database {
  static const List<String> diet = [
    'Vegetarian',
    'Non-vegetarian',
    'Semi-vegetarian',
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

  static const List<String> categories = [
    'All',
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
      name: 'Barbecue Chicken',
      cuisine: 'American Cuisine',
      description:
          'Barbecue chicken consists of chicken parts or entire chickens that are barbecued, grilled or smoked.',
      time: '10-14 minutes.',
      image: Assets.foodImagesBbqChicken,
      chef: null,
      veg: false,
      categories: [
        'Main Courses/Entrees',
      ],
      ingredients: [
        '4 pounds bone-in, skin-on chicken parts (legs, thighs, wings, breasts).',
        'Kosher salt.',
        'Extra virgin olive oil or vegetable oil.',
        '1 cup barbecue sauce, store-bought or homemade.',
      ],
      steps: [
        'Coat the chicken pieces with olive oil and sprinkle salt over them on all sides.',
        'Prepare one side of your grill for high, direct heat.',
        'If you are using charcoal or wood, make sure there is a cool side to the grill where there are few to no coals.',
        'Lay the chicken pieces skin side down on the hottest side of the grill in order to sear the skin side well.',
        'Grill uncovered for 5 to 10 minutes, depending on how hot the grill is (you do not want the chicken to burn).',
        'Once you have a good sear on one side, turn the chicken pieces over and move them to the cooler side of the grill.',
        'If you are using a gas grill, maintain the flame on only one side of the grill, and move the chicken pieces to the cooler side, not directly over the flame.',
        'Reduce the temp to low or medium low (between 250°F and 275°F, no more than 300°F).',
        'Cover the grill and cook undisturbed for 20 to 30 minutes.',
        'Turn the chicken pieces over and baste them with your favorite barbecue sauce.',
        'Cover the grill again and allow to cook for another 15 to 20 minutes.',
        'Repeat, turning the chicken pieces over, basting them with sauce, covering, and cooking for another 10 to 30 minutes.',
        'The timing will depend on your grill set-up, the size of your chicken pieces, and how cold your chicken pieces are to start with!',
        'If you\'re grilling smaller pieces of chicken on a charcoal grill, they may be done much earlier.',
        'The goal is to maintain a low enough grill temp so that the chicken cooks "low and slow"',
        'The chicken is done when the internal temperature of the chicken pieces are 160°F for breasts and 170°F for thighs, when tested with a meat thermometer.',
        'Or if you insert the tip of a knife into the middle of the thickest piece and the juices run clear, the chicken is done.',
        'If the chicken isn\'t done, turn the pieces over and continue to cook at a low temperature.',
        'If you want, you can finish with a sear on the hot side of the grill.',
        'To do this, put the pieces, skin side down, on the hot side of the grill.',
        'Allow them to sear and blacken slightly for a minute or two.',
        'Use a clean brush to paint the cooked chicken with more barbecue sauce and serve.',
      ],
    ),
    RecipeModel(
      id: 000001,
      name: 'Veggie Okonomiyaki',
      cuisine: 'Japanese Cuisine',
      description:
          'Okonomiyaki is a popular pan-fried dish that consists of batter and cabbage. Selected toppings and ingredients are added which can vary greatly.',
      time: '5-7 minutes.',
      image: Assets.foodImagesVeggieOkonomiyaki,
      chef: null,
      veg: true,
      categories: [
        'Main Courses/Entrees',
      ],
      ingredients: [
        '4 eggs.',
        '80 g plain flour (~ ½ cup).',
        '1 tablespoon soy sauce.',
        '½ teaspoon pureed ginger.',
        'Black pepper.',
        '120 g finely shredded green cabbage (~ 2 cups).',
        '1 small carrot, grated.',
        '2 spring onions, thinly sliced.',
        '1 tablespoon oil.',
        'Mayonnaise or salad cream.',
        'Sriracha.',
        'Chopped spring onions',
        'Sesame seeds.',
      ],
      steps: [
        'Beat the eggs in a mixing bowl, and add the plain flour. Whisk together to form the pancake batter.',
        'Add the soy sauce, pureed ginger, and plenty of black pepper, then add the finely shredded cabbage, carrot and spring onions. Mix well to combine.',
        'Heat a small amount of oil in a frying pan, and spoon in ¼ of the pancake mixture.',
        'Cook over a medium-low heat for a few minutes, until the underside is golden brown, then carefully flip the pancake with a spatula, and cook for another couple of minutes, until fully cooked.',
        'Repeat with the remaining pancake mixture, to create four pancakes in total.',
        'Serve the vegetarian okonomiyaki with with salad cream (or mayonnaise), sriracha, sliced spring onions and sesame seeds.',
      ],
    ),
    RecipeModel(
      id: 000002,
      name: 'Prawn Salad',
      cuisine: 'Spanish Cuisine',
      description:
          'This vibrant prawn salad is a great lunchtime option whether you’re on the go, at work or fancy a quick bite to eat in the sunshine at the weekend.',
      time: '3-5 minutes',
      image: Assets.foodImagesPrawnSalad,
      chef: null,
      veg: false,
      categories: [
        'Soups and Salads',
        'Seafood',
      ],
      ingredients: [
        '400 g tiger or king prawns.',
        '1 packet or 180 g mixed salad leaves.',
        '20 slices cucumber, cut into halves.',
        '12 Roza or cherry tomatoes.',
        '1 beetroot, cut into julienne strips.',
        '6 spring onion sprigs, chopped.',
        '½ each red pepper, green pepper, yellow pepper, cut into small blocks.',
        '1-2 avocado\'s, cubed.',
        '1 handful fresh coriander leaves.',
        '50 ml freshly squeezed lime juice.',
        '150 ml olive oil.',
        '5 ml grated lime zest.',
        '30 ml fresh coriander leaves, chopped',
      ],
      steps: [
        'Wash the salad leaves and dry them.',
        'Assemble the rest of the salad ingredients to make it a colourful festive feast on the eye.',
        'Season the prawns(out of shell, or cut open with shell on) with the Robertsons Fish spice and fry until pink and cooked but not too dry.',
        'Add the prawns on top and garnish with a slice of lemon and more fresh coriander leaves.',
        'Combine all the ingredients in a jar and drizzle over salad.',
      ],
    ),
    RecipeModel(
      id: 000003,
      name: 'Prawn Yellow Rice',
      cuisine: 'Spanish Cuisine',
      description:
          'Prawn Yellow Rice is a flavorful and vibrant dish that combines the succulence of prawns with the aromatic and visually appealing hues of yellow rice.',
      time: '25-60 mins.',
      image: Assets.foodImagesPrawnYellowRice,
      chef: 'guest_181',
      veg: false,
      categories: [
        'Main Courses/Entrees',
        'Seafood',
      ],
      ingredients: [
        '4 garlic cloves, minced.',
        '2 tablespoons olive oil, divided.',
        '1 ½ teaspoons smoked paprika.',
        '½ teaspoon salt, divided.',
        '1 pound large prawn, peeled and deveined.',
        '½ cup finely chopped onion.',
        '3 cups uncooked quick-cooking brown rice.',
        '½ teaspoon ground turmeric.',
        '2 ½ cups cold water.',
        '½ cup frozen peas.',
        '2 tablespoons dry sherry (optional).',
        '1 tablespoon fresh chopped parsley.',
      ],
      steps: [
        'Combine garlic, 1 tablespoon olive oil, paprika, and ¼ teaspoon salt in a large bowl; stir with a whisk.',
        'Add prawn, and toss to coat. Set aside.',
        'Heat remaining 1 tablespoon oil in a 3-quart saucepan over medium-high heat.',
        'Add onion, and cook 2–3 minutes until soft.',
        'Add rice, remaining ¼ teaspoon salt, and turmeric.',
        'Add 2 ½ cups cold water; cover and reduce heat to low.',
        'Cook 4 minutes; remove from heat.',
        'Stir in peas, and let stand, covered, until ready to serve.',
        'Heat a large nonstick skillet over medium-high heat.',
        'Place prawns in center of pan.',
        'Cook 2–3 minutes on each side or until opaque.',
        'Add sherry, if desired, during the last minute of cooking, and toss to coat.',
        'Remove from heat.',
        'Fluff rice mixture, and place on a serving platter.',
        'Arrange prawns on top of rice mixture, sprinkle with parsley, and serve immediately,',
      ],
    ),
  ];
}

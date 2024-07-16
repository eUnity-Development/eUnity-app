class UserPrefsList {
  static List<Map<String, dynamic>> aboutList = [
    {
      'name': 'Pronouns',
      'options': ['He/him', 'She/hers', 'They/them', 'Other'],
      'question': 'Select your pronouns',
      'assetPath': 'assets/preferences/pronouns.svg',
      'cacheKey': 'pronouns',
      'multiSelect': false,
    },

    // If time, add a second prompt to let users type in school name.
    // Later on, add school email verification.
    {
      'name': 'Education',
      'options': ['High School', 'Associate\'s', 'Bachelor\'s', 'None'],
      'question': 'Select your education',
      'assetPath': 'assets/preferences/education.svg',
      'cacheKey': 'education',
      'multiSelect': false,
    },

    {
      'name': 'Job',
      'options': ['Full-Time', 'Part-Time', 'Other', 'None'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/job.svg',
      'cacheKey': 'job',
      'multiSelect': false,
    },

    // Need special menu for 30+ options. Allow multi select.
    {
      'name': 'Interests',
      'options': ['Unlimited Bacon', 'No More Games'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/interests.svg',
      'cacheKey': 'interests',
      'multiSelect': false,
    },

    // Will also need special menu? Allow multi select.
    {
      'name': 'Ethnicity',
      'options': ['Unlimited Bacon', 'No More Games'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/ethnicity.svg',
      'cacheKey': 'ethnicity',
      'multiSelect': false,
    },
    {
      'name': 'Politics',
      'options': ['Unlimited Bacon', 'No More Games'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/politics.svg',
      'cacheKey': 'politics',
      'multiSelect': false,
    },

    // Will also need a new menu. Around 14 options.
    {
      'name': 'Religion',
      'options': ['Unlimited Bacon', 'No More Games'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/religion.svg',
      'cacheKey': 'religion',
      'multiSelect': false,
    },

    // Have this based on the user's location.
    // Give them the choice to set their current location
    // as their 'main city' or have their city update based
    // on their current location (dynamic).
    {
      'name': 'City',
      'options': ['Unlimited Bacon', 'No More Games'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/city.svg',
      'cacheKey': 'city',
      'multiSelect': false,
    },

  ];

  static List<Map<String, dynamic>> lifestyleList = [
    {
      'name': 'Exercise',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'exercise',
      'multiSelect': false,
    },
    {
      'name': 'Drinking',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'drinking',
      'multiSelect': false,
    },
    {
      'name': 'Cannabis',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'cannabis',
      'multiSelect': false,
    },

    // Might make a special menu for this too.
    {
      'name': 'Height',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'height',
      'multiSelect': false,
    },
    {
      'name': 'Social Media',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/social-media.svg',
      'cacheKey': 'social-media',
      'multiSelect': false,
    },
    {
      'name': 'Pets',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'pets',
      'multiSelect': false,
    },

    // Will also have a longer list for this too.
    {
      'name': 'Dietary Preferences',
      'options': ['Very frequent', 'Frequent', 'Occasionally', 'None'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'diet',
      'multiSelect': false,
    },
  ];

  static List<Map<String, dynamic>> relationshipList = [

  ];
}


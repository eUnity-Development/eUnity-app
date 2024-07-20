class UserPrefsList {
  static List<Map<String, dynamic>> aboutList = [
    {
      'name': 'Pronouns',
      'options': ['He/him', 'She/hers', 'They/them', 'Other'],
      'question': 'Select your pronouns',
      'assetPath': 'assets/preferences/pronouns.svg',
      'cacheKey': 'pronouns',
      'multiSelect': false,
      'longList': false,
    },

    // If time, add a second prompt to let users type in school name.
    // Later on, add school email verification.
    {
      'name': 'Education',
      'options': [
        'High School',
        'Associate\'s Degree',
        'Bachelor\'s Degree',
        'Master\'s or PHD',
        'Trade School',
        'Other',
        'None'
      ],
      'question': 'Select your education',
      'assetPath': 'assets/preferences/education.svg',
      'cacheKey': 'education',
      'multiSelect': false,
      'longList': false,
    },

    {
      'name': 'Job',
      'options': ['Placeholder'],
      'question': 'Enter your job title',
      'assetPath': 'assets/preferences/job.svg',
      'cacheKey': 'job',
      'multiSelect': false,
      'longList': false,
    },

    // Need special menu for 30+ options. Allow multi select.
    {
      'name': 'Interests',
      'options': [
           'Reading',
    'Cooking',
    'Traveling',
    'Music',
    'Fitness',
    'Movies',
    'Sports',
    'Art',
    'Gardening',
    'Hiking',
    'Photography',
    'Gaming',
    'Writing',
    'Yoga',
    'Technology',
    'Fashion',
    'Cars',
    'Animals',
    'DIY Projects',
    'History',
    'Science',
    'Meditation',
    'Comedy',
    'Dancing',
    'Socializing',
    'Volunteering',
    'Crafts',
    'Cycling',
    'Baking',
    'Languages',
    'Astronomy',
    'Architecture',
    'Bird Watching',
    'Investing',
    'Fishing',
    'Theater'
      ],
      'question': 'Select up to 7 interests',
      'assetPath': 'assets/preferences/interests.svg',
      'cacheKey': 'interests',
      'multiSelect': true,
      'longList': true,
    },

    // Will also need special menu? Allow multi select.
    {
      'name': 'Ethnicity',
      'options': [
        'Black/African Descent',
        'Hispanic/Latino',
        'White/Caucasian',
        'Middle Eastern',
        'Native American',
        'Pacific Islander',
        'South Asian',
        'East Asian',
        'Southeast Asian',
        'West African',
        'East African',
        'North African',
        'Central African',
        'Southern African',
        'Caribbean',
        'Latin American',
        'Eastern European',
        'Western European',
        'Northern European',
        'Southern European',
        'Jewish',
        'Arab',
        'Persian',
        'Turkish',
        'Central Asian',
        'Other',
        'Prefer Not to Say'
      ],
      'question': 'Select your ethnicities',
      'assetPath': 'assets/preferences/ethnicity.svg',
      'cacheKey': 'ethnicity',
      'multiSelect': true,
      'longList': true,
    },
    {
      'name': 'Politics',
      'options': [
        'Liberal',
        'Moderate',
        'Conservative',
        'Other',
        'Prefer not to say'
      ],
      'question': 'What is your political alignment?',
      'assetPath': 'assets/preferences/politics.svg',
      'cacheKey': 'politics',
      'multiSelect': false,
      'longList': false,
    },

    // Will also need a new menu. Around 14 options.
    {
      'name': 'Religion',
      'options': [
        'Christian',
        'Catholic',
        'Protestant',
        'Jewish',
        'Muslim',
        'Buddhist',
        'Hindu',
        'Sikh',
        'Other specific religion',
        'Spiritual but not religious',
        'Agnostic',
        'Atheist',
        'Non-religious',
        'Prefer not to say'
      ],
      'question': 'Select your religion',
      'assetPath': 'assets/preferences/religion.svg',
      'cacheKey': 'religion',
      'multiSelect': true,
      'longList': true,
    },

    // Have this based on the user's location.
    // Give them the choice to set their current location
    // as their 'main city' or have their city update based
    // on their current location (dynamic).
    {
      'name': 'City',
      'options': ['Set location', 'Dynamic Location'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/city.svg',
      'cacheKey': 'city',
      'multiSelect': false,
      'longList': false,
    },
  ];

  static List<Map<String, dynamic>> lifestyleList = [
    {
      'name': 'Exercise',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you exercise?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'exercise',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Drinking',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you drink alcohol?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'drinking',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Cannabis',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you use cannabis?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'cannabis',
      'multiSelect': false,
      'longList': false,
    },

    // Might make a special menu for this too.
    {
      'name': 'Height',
      'options': ['Placeholder'],
      'question': 'What is your height?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'height',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Social Media',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you use social media?',
      'assetPath': 'assets/preferences/social-media.svg',
      'cacheKey': 'social-media',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Pets',
      'options': ['Yes', 'No'],
      'question': 'Do you have any pets?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'pets',
      'multiSelect': false,
      'longList': false,
    },

    // Will also have a longer list for this too.
    {
      'name': 'Dietary Preferences',
      'options': [
        'Omnivore',
        'Vegetarian',
        'Vegan',
        'Pescatarian',
        'Flexitarian',
        'Gluten-free',
        'Dairy-free',
        'Nut-free',
        'Paleo',
        'Keto',
        'Other'
      ],
      'question': 'Do you have any dietary preferences?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'diet',
      'multiSelect': true,
      'longList': true,
    },
  ];

  static List<Map<String, dynamic>> relationshipList = [];
}

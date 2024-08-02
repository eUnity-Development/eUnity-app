class UserPrefsList {
  static List<Map<String, dynamic>> aboutList = [
    {
      'name': 'Pronouns',
      'options': ['He/him', 'She/hers', 'They/them', 'Other'],
      'question': 'Select your pronouns',
      'assetPath': 'assets/preferences/pronouns.svg',
      'cacheKey': 'pronouns',
      'cacheObject': 'about',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Height',
      'options': ['Placeholder'],
      'question': 'What is your height?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'height',
      'cacheObject': 'about',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Education',
      'options': [
        'Associate\'s Degree',
        'Bachelor\'s Degree',
        'High School',
        'Master\'s or PHD',
        'Trade School',
        'None',
        'Other'
      ],
      'question': 'Select your education',
      'assetPath': 'assets/preferences/education.svg',
      'cacheKey': 'education',
      'cacheObject': 'about',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Job',
      'options': ['Placeholder'],
      'question': 'Enter your job title',
      'assetPath': 'assets/preferences/job.svg',
      'cacheKey': 'job',
      'cacheObject': 'about',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Interests',
      'options': [
        'Animals',
        'Architecture',
        'Art',
        'Astronomy',
        'Baking',
        'Bird Watching',
        'Cars',
        'Comedy',
        'Cooking',
        'Crafts',
        'Cycling',
        'Dancing',
        'DIY Projects',
        'Fashion',
        'Fishing',
        'Fitness',
        'Gaming',
        'Gardening',
        'Hiking',
        'History',
        'Investing',
        'Languages',
        'Meditation',
        'Movies',
        'Music',
        'Photography',
        'Reading',
        'Science',
        'Socializing',
        'Sports',
        'Technology',
        'Theater',
        'Traveling',
        'Volunteering',
        'Writing',
        'Yoga'
      ],
      'question': 'Select up to 7 interests',
      'assetPath': 'assets/preferences/interests.svg',
      'cacheKey': 'interests',
      'cacheObject': 'about',
      'multiSelect': true,
      'longList': true,
    },
    {
      'name': 'Ethnicity',
      'options': [
        'Arab',
        'Black/African Descent',
        'Caribbean',
        'Central African',
        'Central Asian',
        'East African',
        'East Asian',
        'Eastern European',
        'Hispanic/Latino',
        'Jewish',
        'Latin American',
        'Middle Eastern',
        'Native American',
        'North African',
        'Pacific Islander',
        'Persian',
        'South Asian',
        'Southeast Asian',
        'Southern African',
        'Southern European',
        'Turkish',
        'West African',
        'Western European',
        'White/Caucasian',
        'Northern European',
        'Other',
        'Prefer Not to Say'
      ],
      'question': 'Select your ethnicities',
      'assetPath': 'assets/preferences/ethnicity.svg',
      'cacheKey': 'ethnicity',
      'cacheObject': 'about',
      'multiSelect': true,
      'longList': true,
    },
    {
      'name': 'Politics',
      'options': [
        'Conservative',
        'Liberal',
        'Moderate',
        'Other',
        'Prefer not to say'
      ],
      'question': 'What is your political alignment?',
      'assetPath': 'assets/preferences/politics.svg',
      'cacheKey': 'politics',
      'cacheObject': 'about',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Religion',
      'options': [
        'Agnostic',
        'Atheist',
        'Buddhist',
        'Catholic',
        'Christian',
        'Hindu',
        'Jewish',
        'Muslim',
        'Protestant',
        'Sikh',
        'Spiritual but not religious',
        'Other specific religion',
        'Non-religious',
        'Prefer not to say'
      ],
      'question': 'Select your religion',
      'assetPath': 'assets/preferences/religion.svg',
      'cacheKey': 'religion',
      'cacheObject': 'about',
      'multiSelect': true,
      'longList': true,
    },
    {
      'name': 'City',
      'options': ['Set location', 'Dynamic Location'],
      'question': 'Select your job type',
      'assetPath': 'assets/preferences/city.svg',
      'cacheKey': 'city',
      'cacheObject': 'about',
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
      'cacheObject': 'lifestyle',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Drinking',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you drink alcohol?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'drinking',
      'cacheObject': 'lifestyle',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Cannabis',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you use cannabis?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'cannabis',
      'cacheObject': 'lifestyle',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Social Media',
      'options': ['Frequently', 'Occasionally', 'Rarely', 'Never'],
      'question': 'How much do you use social media?',
      'assetPath': 'assets/preferences/social-media.svg',
      'cacheKey': 'social_media',
      'cacheObject': 'lifestyle',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Pets',
      'options': ['Yes', 'No'],
      'question': 'Do you have any pets?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'pets',
      'cacheObject': 'lifestyle',
      'multiSelect': false,
      'longList': false,
    },
    {
      'name': 'Dietary Preferences',
      'options': [
        'Dairy-free',
        'Flexitarian',
        'Gluten-free',
        'Keto',
        'Nut-free',
        'Omnivore',
        'Paleo',
        'Pescatarian',
        'Vegan',
        'Vegetarian',
        'Other',
        'None'
      ],
      'question': 'Do you have any dietary preferences?',
      'assetPath': 'assets/preferences/placeholder.svg',
      'cacheKey': 'diet',
      'cacheObject': 'lifestyle',
      'multiSelect': true,
      'longList': true,
    },
  ];

  static List<Map<String, dynamic>> relationshipList = [];
}

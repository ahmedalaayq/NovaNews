class OnboardingModel {
  OnboardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image;
  final String title;
  final String subTitle;

  static List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Trending News',
      subTitle:
          'Stay in the loop with the biggest breaking stories in a stunning visual slider. Just swipe to explore what’s trending right now!',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Pick What You Love',
      subTitle:
          'No more endless scrolling! Tap into your favorite topics like Tech, Politics, or Sports and get personalized news in seconds',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Save It. Read It Later. Stay Smart.',
      subTitle:
          'Found something interesting? Tap the bookmark and come back to it anytime. Never lose a great read again!',
    ),
  ];
}

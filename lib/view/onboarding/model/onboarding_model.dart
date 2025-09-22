class OnboardingModel {
  final String image;
  final String title;
  final String description;
   final bool isLottie;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
     this.isLottie = false,
  });
}
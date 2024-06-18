class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Discover Nearby Parking',
      image: 'lib/images/animation 2.json',
      description:
          "Easily locate available parking spots around you. Our app provides real-time updates on parking availability to save you time and hassle"),
  UnbordingContent(
      title: 'Navigate with Ease',
      image: 'lib/images/animation 1.json',
      description:
          "Find your perfect parking spot effortlessly. Use our app to get step-by-step directions to the nearest available parking, ensuring a smooth and stress-free experience."),
  UnbordingContent(
      title: 'Enjoy Seamless Parking',
      image: 'lib/images/animation 3.json',
      description:
          "Park your car with confidence and convenience. Watch as cars arrive and leave in real-time, and celebrate the ease of finding parking with our app. Let's get started with a burst of excitement!"),
];

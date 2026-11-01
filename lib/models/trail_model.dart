class Trail {
  final String id;
  final String name;
  final String description;
  final String category;

  Trail({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  String get imagePath {
    switch (category) {
      case 'Bosque':
        return 'assets/images/bosque_sendero.jpg';
      case 'Barranco':
        return 'assets/images/barranco_sendero.jpg';
      case 'Costa':
      default:
        return 'assets/images/costa_sendero.jpg';
    }
  }
}
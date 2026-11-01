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

  // Vinculamos la categoría a una imagen de red para cumplir el requisito 6
  String get imageUrl {
    switch (category) {
      case 'Bosque':
        return 'https://imgur.com/ZyWV2nt';
      case 'Barranco':
        return 'https://imgur.com/U9NPIo3';
      case 'Costa':
      default:
        return 'https://imgur.com/TofKWki';
    }
  }
}
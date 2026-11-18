// Definición de la clase Trail que actúa como un "molde" para nuestros objetos de senderos.
class Trail {
  // Declaramos las propiedades como 'final' porque una vez creado el objeto en memoria, 
  // sus atributos directos no van a cambiar (si editamos, crearemos un objeto nuevo).
  final String id;
  final String name;
  final String description;
  final String category;

  // Constructor de la clase. 
  // Usamos 'required' y parámetros nombrados (entre llaves {}) para obligar a que 
  // siempre que se cree un Trail, haya que pasarle todos estos datos obligatoriamente.
  Trail({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  // Getter dinámico: Es una función que simula ser una variable.
  // En lugar de guardar la ruta de la imagen en la base de datos, 
  // calculamos qué imagen mostrar en tiempo real basándonos en la categoría elegida.
  String get imagePath {
    switch (category) {
      case 'Bosque':
        return 'assets/images/bosque_sendero.jpg';
      case 'Barranco':
        return 'assets/images/barranco_sendero.jpg';
      case 'Costa':
      default: // El 'default' actúa como salvavidas por si falla la categoría o no coincide
        return 'assets/images/costa_sendero.jpg';
    }
  }
}
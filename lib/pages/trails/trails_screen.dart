import 'package:flutter/material.dart'; // Importa la librería base de componentes visuales (Material Design) de Flutter.

import '../../shared/widgets/app_drawer.dart'; // Importa el widget personalizado del menú lateral.
import '../../shared/theme/app_colors.dart'; // Importa la paleta de colores global de la aplicación.
import '../../models/trail_model.dart'; // Importa el modelo de datos Trail que define la estructura de cada sendero.

// Define la clase TrailsScreen como un StatefulWidget, ya que su interfaz cambiará al añadir, editar o borrar senderos.
class TrailsScreen extends StatefulWidget {
  // Constructor constante de la clase, usando super.key para identificar el widget en el árbol de Flutter.
  const TrailsScreen({super.key});

  // Sobrescribe el método createState para vincular esta pantalla con su clase de estado (la que guarda los datos).
  @override
  State<TrailsScreen> createState() => _TrailsScreenState();
}

// Define la clase de estado privado _TrailsScreenState, donde residirá la lógica CRUD y las variables que cambian.
class _TrailsScreenState extends State<TrailsScreen> {
  // Declara e inicializa una lista final llamada _trails, que actuará como nuestra base de datos local en memoria.
  final List<Trail> _trails = [
    // Crea la primera instancia de la clase Trail pasándole sus parámetros obligatorios.
    Trail(
      id: '1', // Asigna el identificador único '1'.
      name: 'Bosque de Anaga', // Asigna el nombre del sendero.
      description: 'Dificultad: alta', // Asigna la descripción.
      category: 'Bosque', // Asigna la categoría para luego sacar su imagen.
    ),
    // Crea la segunda instancia de Trail.
    Trail(
      id: '2', // Asigna el identificador '2'.
      name: 'Barranco de Masca', // Asigna el nombre.
      description: 'Dificultad: media', // Asigna su dificultad.
      category: 'Barranco', // Categoría Barranco.
    ),
    // Crea la tercera instancia de Trail.
    Trail(
      id: '3', // Asigna el identificador '3'.
      name: 'Lanzarote', // Asigna el nombre.
      description: 'Dificultad: baja', // Dificultad baja.
      category: 'Costa', // Categoría Costa.
    ),
  ];

  // Instancia un controlador (TextEditingController) para leer y escribir texto en el input del nombre de los formularios.
  final TextEditingController _nameController = TextEditingController();
  
  // Declara una variable nullable (?) para almacenar la dificultad seleccionada; inicia en 'Desconocida'.
  String? _selectedDifficulty = 'Desconocida';
  // Lista constante de Strings con las opciones válidas para la dificultad del Dropdown.
  final List<String> _difficulties = ['baja', 'media', 'alta'];
  
  // Declara una variable nullable (?) para almacenar la categoría elegida; inicia en 'Desconocida'.
  String? _selectedCategory = 'Desconocida';
  // Lista constante de opciones válidas para el Dropdown de categorías.
  final List<String> _categories = ['Bosque', 'Barranco', 'Costa'];

  // Método privado para eliminar un sendero basado en su identificador único (id).
  void _deleteTrail(String id) {
    // Llama a setState para notificar a Flutter que una variable cambió y debe repintar la pantalla.
    setState(() {
      // Utiliza removeWhere para iterar la lista y borrar el elemento cuyo id coincida con el que pasamos por parámetro.
      _trails.removeWhere((trail) => trail.id == id);
    });
  }

  // Método privado que abre una ventana emergente (modal) para añadir un nuevo sendero a la lista.
  void _showAddTrailDialog() {
    // Limpia cualquier texto previo que hubiera quedado en el campo del nombre.
    _nameController.clear();
    // Restablece la dificultad seleccionada a null para que el selector arranque vacío (o mostrando el hint).
    _selectedDifficulty = null;
    // Restablece la categoría seleccionada a null.
    _selectedCategory = null;

    // Función nativa de Flutter para pintar un cuadro de diálogo sobre la vista actual.
    showDialog(
      // Pasa el contexto actual de la pantalla para ubicar el modal.
      context: context,
      // Función constructora que define los widgets que se van a dibujar dentro de la ventana.
      builder: (context) {
        // Retorna un StatefulBuilder: esto es clave para aislar el repintado de los Dropdowns sin recargar toda la app entera.
        return StatefulBuilder(
          // Proporciona la función especial setStateModal para actualizar exclusivamente el interior de este diálogo.
          builder: (context, setStateModal) {
            // Retorna la ventana de diálogo típica de Material Design.
            return AlertDialog(
              // Título superior de la ventana.
              title: const Text('Añadir Sendero'),
              // Envuelve el formulario en un SingleChildScrollView para evitar que la app dé error si el teclado del móvil tapa la ventana.
              content: SingleChildScrollView(
                // Usa una columna para apilar componentes de arriba a abajo.
                child: Column(
                  // mainAxisSize.min hace que la columna no ocupe toda la pantalla, solo lo que midan sus componentes hijos.
                  mainAxisSize: MainAxisSize.min,
                  // Lista de widgets hijos dentro de la columna.
                  children: [
                    // Campo de entrada de texto (input).
                    TextField(
                      // Conecta el controlador para ir guardando el texto a medida que el usuario teclea.
                      controller: _nameController,
                      // Decoración para agregar la etiqueta flotante 'Nombre del sendero'.
                      decoration: const InputDecoration(
                        labelText: 'Nombre del sendero',
                      ),
                    ),
                    // Añade una separación en blanco de 15 píxeles de alto.
                    const SizedBox(height: 15),
                    
                    // Selector desplegable (Dropdown) con tipo String.
                    DropdownButtonFormField<String>(
                      // Define con qué valor arranca el selector.
                      initialValue: _selectedDifficulty,
                      // Texto gris transparente (hint) si el initialValue es null.
                      hint: const Text('Desconocida'),
                      // Etiqueta flotante del input 'Dificultad'.
                      decoration: const InputDecoration(labelText: 'Dificultad'),
                      // Convierte (mapea) la lista _difficulties en un array de widgets tipo DropdownMenuItem.
                      items: _difficulties.map((diff) {
                        // Construye cada ítem, dándole el valor lógico (diff) y el texto visual que verá el usuario Text(diff).
                        return DropdownMenuItem(
                          value: diff, 
                          child: Text(diff),
                        );
                      }).toList(), // Cierra el map convirtiéndolo de nuevo a una lista real.
                      // Evento disparado cada vez que el usuario toca un elemento de la lista desplegable.
                      onChanged: (val) {
                        // Comprueba que no hayamos devuelto nulo accidentalmente.
                        if (val != null) {
                          // Llama a setStateModal para repintar SOLO este modal con la nueva opción seleccionada visible.
                          setStateModal(() => _selectedDifficulty = val);
                        }
                      },
                    ),
                    // Otra caja de separación de 15 píxeles.
                    const SizedBox(height: 15),
                    
                    // Selector desplegable para elegir la categoría del sendero (misma estructura que el anterior).
                    DropdownButtonFormField<String>(
                      // Inicia con la categoría seleccionada.
                      initialValue: _selectedCategory,
                      hint: const Text('Desconocida'),
                      decoration: const InputDecoration(labelText: 'Categoría'),
                      // Mapea la lista de categorías.
                      items: _categories.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                      // Evento de selección.
                      onChanged: (val) {
                        // Actualiza visualmente el modal con el nuevo dato de categoría.
                        if (val != null) {
                          setStateModal(() => _selectedCategory = val);
                        }
                      },
                    ),
                  ],
                ),
              ),
              // Conjunto de botones de acción en la base del diálogo.
              actions: [
                // Botón plano y sin fondo.
                TextButton(
                  // Navigator.pop cierra la ventana superpuesta (destruye la capa superior actual de navegación).
                  onPressed: () => Navigator.pop(context),
                  // Etiqueta del botón.
                  child: const Text('Cancelar'),
                ),
                // Botón con relieve y fondo sólido.
                ElevatedButton(
                  // Le aplica el color principal morado a través de su estilo interno.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  // Acción de guardado (Insert).
                  onPressed: () {
                    // Validamos que el cuadro de texto del nombre no esté vacío.
                    if (_nameController.text.isNotEmpty) {
                      // Usamos setState global para avisar a la pantalla base (TrailsScreen) que debe actualizar la lista mostrada.
                      setState(() {
                        // Inyecta el nuevo objeto al final de la matriz _trails.
                        _trails.add(
                          // Construye un nuevo objeto modelo Trail.
                          Trail(
                            // Crea un id "falso" convirtiendo la fecha y hora exactas del clic en texto (String).
                            id: DateTime.now().toString(),
                            // Coge lo escrito por el usuario en el controlador.
                            name: _nameController.text,
                            // Combina texto con la variable interpolada. Si _selectedDifficulty es nulo, los símbolos ?? insertan la palabra 'Desconocida'.
                            description: 'Dificultad: ${_selectedDifficulty ?? 'Desconocida'}',
                            // Hace lo mismo con la categoría elegida.
                            category: 'Categoría: ${_selectedCategory ?? 'Desconocida'}',
                          ),
                        );
                      });
                      // Finalizado el guardado, cierra el modal.
                      Navigator.pop(context);
                    }
                  },
                  // Texto blanco del botón para destacar.
                  child: const Text(
                    'Añadir',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Método privado para abrir la ventana modal enfocada en actualizar (Editar) un registro previo existente.
  void _showEditTrailDialog(Trail trail) {
    // Rellena automáticamente el controlador del input con el nombre que ya tenía el sendero.
    _nameController.text = trail.name;

    // Extrae y limpia el string. En tu código original guardabas "Categoría: Bosque" (esto es un bug tipográfico tuyo usando description).
    String currentCategory = trail.description.replaceAll('Dificultad: ', '');
    // Verifica si la palabra extraída coincide con alguna opción válida de tu lista _categories.
    if (_categories.contains(currentCategory)) {
      // Si la encuentra, la deja seleccionada por defecto.
      _selectedCategory = currentCategory;
    } else {
      // Si falla, lo devuelve a nulo para no crashear la UI.
      _selectedCategory = null;
    }

    // Aplica el mismo proceso de limpieza de strings para recuperar la dificultad.
    String currentDiff = trail.description.replaceAll('Dificultad: ', '');
    // Verifica validez de la cadena.
    if (_difficulties.contains(currentDiff)) {
      _selectedDifficulty = currentDiff;
    } else {
      _selectedDifficulty = null;
    }

    // Muestra el diálogo en pantalla.
    showDialog(
      context: context,
      builder: (context) {
        // Usa StatefulBuilder de nuevo.
        return StatefulBuilder(
          builder: (context, setStateModal) {
            // Retorna la ventana de diálogo para edición.
            return AlertDialog(
              title: const Text('Editar Sendero'), // Título distinto indicando edición.
              content: SingleChildScrollView( // Protección contra el teclado móvil.
                child: Column( // Apilado vertical de los inputs.
                  mainAxisSize: MainAxisSize.min, // Espacio comprimido.
                  children: [
                    // Campo de texto ya lleno con el nombre a editar.
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre del sendero'),
                    ),
                    const SizedBox(height: 15), // Margen.
                    
                    // Dropdown de dificultad con la opción antigua pre-seleccionada (initialValue).
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDifficulty,
                      hint: const Text('Desconocida'),
                      decoration: const InputDecoration(labelText: 'Dificultad'),
                      // Renderiza la lista de opciones posibles.
                      items: _difficulties.map((diff) {
                        return DropdownMenuItem(value: diff, child: Text(diff));
                      }).toList(),
                      // Evento de refresco visual dentro de esta ventana flotante.
                      onChanged: (val) {
                        if (val != null) setStateModal(() => _selectedDifficulty = val);
                      },
                    ),
                    const SizedBox(height: 15), // Margen.
                    
                    // Dropdown de categoría.
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      hint: const Text('Desconocida'),
                      decoration: const InputDecoration(labelText: 'Categoría'),
                      items: _categories.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setStateModal(() => _selectedCategory = val);
                      },
                    )
                  ],
                ),
              ),
              // Botones para el modal de edición.
              actions: [
                // Botón cancelar igual que en el otro modal.
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                // Botón para ejecutar el Update a la lista.
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: () {
                    // Valida que el campo nombre no esté vacío.
                    if (_nameController.text.isNotEmpty) {
                      // Dispara la reconstrucción de la pantalla base.
                      setState(() {
                        // La función indexWhere recorre la base de datos hasta encontrar en qué número de fila está nuestro sendero guiándose por su ID único.
                        final index = _trails.indexWhere((t) => t.id == trail.id);
                        // indexWhere devuelve -1 si no encuentra el objeto, comprobamos que sí lo encontró.
                        if (index != -1) {
                          // Sobrescribimos la posición antigua (index) con un nuevo Trail instanciado desde cero.
                          _trails[index] = Trail(
                            // Crucial: le pasamos el ID antiguo que trajimos como parámetro para que no cambie su DNI digital.
                            id: trail.id, 
                            // Leemos el nuevo nombre escrito por el usuario.
                            name: _nameController.text,
                            // Asignamos descripciones combinadas.
                            description: 'Dificultad: ${_selectedDifficulty ?? 'Desconocida'}',
                            category: 'Categoría: ${_selectedCategory ?? 'Desconocida'}',
                          );
                        }
                      });
                      // Cierra el modal de edición.
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }
        );
      },
    );
  }

  // Método Build principal donde se dibuja todo lo que el usuario ve de fondo.
  @override
  Widget build(BuildContext context) {
    // Scaffold provee la estructura básica de material design (cabecera, cajón lateral, cuerpo, botón flotante...).
    return Scaffold(
      // Aplica el color gris claro a toda la pantalla por detrás.
      backgroundColor: AppColors.headerBackground,
      // Construye la barra de navegación superior.
      appBar: AppBar(
        // Añade el título a la barra.
        title: const Text(
          'Gestión de Senderos',
          style: TextStyle(color: Colors.white),
        ),
        // Le da el fondo morado oscuro.
        backgroundColor: AppColors.primary,
        // Obliga a que los botones e iconos de esta barra sean blancos.
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Instancia el widget personalizado que trajiste por importación para el menú lateral tipo hamburguesa.
      drawer: const AppDrawer(),
      // El cuerpo general de la app es una columna gigante para poner el buscador arriba y la lista debajo.
      body: Column(
        children: [
          // Padding genera márgenes de 12px alrededor del cuadro de búsqueda para que no se pegue a la pantalla.
          Padding(
            padding: const EdgeInsets.all(12.0),
            // Input decorativo del buscador.
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscador', // Texto sugerido.
                fillColor: Colors.white, // Color de relleno del interior del cuadro.
                filled: true, // Activa el relleno de color sólido.
                // Borra la línea negra del borde y pone los cantos circulares de grado 8.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Padding para los textos informativos.
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0, // Margen izquierdo y derecho de 16.
              vertical: 8.0, // Margen superior e inferior de 8.
            ),
            // Pone el texto en fila horizontal.
            child: Row(
              children: [
                // Separa un pelín el texto del margen izquierdo usando una caja vacía (SizedBox).
                const SizedBox(width: 8),
                // Interpola la longitud real actual del array _trails para mantener el conteo exacto en todo momento.
                Text(
                  'Total de senderos en lista: ${_trails.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold, // Texto en negrita.
                  ),
                ),
              ],
            ),
          ),

          // LISTA EN PANTALLA:
          // Expanded obliga a su hijo (ListView) a estirarse para rellenar todo el alto sobrante de la pantalla.
          Expanded(
            // ListView.builder es la forma optimizada y pro de crear listas. No pinta los componentes ocultos ahorrando RAM.
            child: ListView.builder(
              // Limita el renderizado al tamaño exacto que tiene nuestro array.
              itemCount: _trails.length,
              // Función obligatoria que se repetirá por cada iteración. (Devuelve el diseño individual de cada fila).
              itemBuilder: (context, index) {
                // Guarda en una variable "trail" el objeto de turno usando su posición [index].
                final trail = _trails[index];
                
                // Retorna un bloque Card para que parezca una tarjeta física con pequeña sombra.
                return Card(
                  // Da separación entre las diferentes tarjetas generadas.
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  // Redondea todas las esquinas de la tarjeta.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Agrupa foto e información poniéndolos uno al lado de otro (Row).
                  child: Row(
                    children: [
                      // ClipRRect sirve para recortar cosas rebeldes (como fotos cuadradas) a una forma con esquinas redondeadas.
                      ClipRRect(
                        // Como la foto está pegada al borde izquierdo de la tarjeta, solo redondea esos dos picos.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        // Dibuja la foto solicitándola a la carpeta local assets.
                        child: Image.asset(
                          // Ejecuta el método getter "imagePath" que configuraste en tu modelo para saber qué foto devolver.
                          trail.imagePath,
                          width: 100, // Alto estático.
                          height: 100, // Ancho estático.
                          fit: BoxFit.cover, // Evita que la foto se estire, cortándola inteligentemente para que rellene su hueco.
                          // errorBuilder es un listener interno. Si la foto especificada falla al cargar...
                          errorBuilder: (context, error, stackTrace) {
                            // ...devuelve un rectángulo gris de fallo con el icono de "imagen rota".
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      // Expanded en este caso le indica al bloque de texto que puede devorarse todo el espacio derecho que la foto no esté usando.
                      Expanded(
                        // Margen para que las letras no se pisen con el borde de la imagen.
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          // Columna para listar nombre, descripción y botones (de arriba abajo).
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Alinea todo a la izquierda.
                            children: [
                              // Pinta el nombre del trail.
                              Text(
                                trail.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              // Separador vertical.
                              const SizedBox(height: 4),
                              // Pinta el string concatenado de la descripción en gris claro.
                              Text(
                                trail.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              // Separador de los textos con los botones de abajo.
                              const SizedBox(height: 8),
                              
                              // Fila interna de los botones.
                              Row(
                                // mainAxisAlignment.end empuja y ancla a los hijos contra la pared derecha del contenedor.
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Contenedor que decora el botón de edición dibujándole un pequeño fondo cuadrado color azul celeste suave.
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(6), // Redondea ese recuadro azul.
                                    ),
                                    // IconButton permite pulsar sobre su icono interno.
                                    child: IconButton(
                                      // Dibuja el lápiz de edición de color grafito/negro.
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                      // Si lo pulsas, lanza _showEditTrailDialog transfiriéndole toda la variable "trail" (que incluye id, nombre y resto de info) de la fila actual iterada.
                                      onPressed: () => _showEditTrailDialog(trail),
                                      // Fuerza a que el botón mida obligatoriamente un minímo de 40x40 para que sea pulsable por un dedo fácilmente en móviles.
                                      constraints: const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                    ),
                                  ),
                                  // Separación vacía entre el botón de editar y el de borrar.
                                  const SizedBox(width: 8),
                                  // Contenedor rojo suave para el botón de borrar.
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    // Icono con capacidad táctil.
                                    child: IconButton(
                                      // Dibuja la papelera en blanco.
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      // Al pulsar no necesita todo el objeto "trail", solo lee "trail.id" y se lo manda por parámetros a la función _deleteTrail.
                                      onPressed: () => _deleteTrail(trail.id),
                                      // Limita sus dimensiones.
                                      constraints: const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }, // Fin del itemBuilder que construye las cartas.
            ),
          ),
        ], // Fin de la lista base central del widget.
      ),
      // Atributo especial de Scaffold que pinta un botón flotante superpuesto (z-index mayor). Extended permite mezclar icono y texto.
      floatingActionButton: FloatingActionButton.extended(
        // Apunta directamente al nombre de la función que despliega el modal para inserción.
        onPressed: _showAddTrailDialog,
        // Adjudica el morado puro de la app.
        backgroundColor: AppColors.primary,
        // Dibuja una cruz con forma de más (+).
        icon: const Icon(Icons.add, color: Colors.white),
        // Texto visible que acompaña a la cruz del botón.
        label: const Text(
          'Añadir Sendero',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // Mueve el botón flotante (por defecto a la derecha abajo) hacia el centro de la base de la pantalla.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  } // Fin del bloque de pintado build().
} // Fin del estado del widget.
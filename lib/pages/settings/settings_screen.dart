import 'package:flutter/material.dart';
import '../../shared/widgets/app_drawer.dart';
import '../../shared/theme/app_colors.dart';
import '../../services/local_storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- VARIABLES DE ESTADO ---
  
  // Variable para almacenar la isla seleccionada (puede ser null al principio)
  String? _selectedIsland;
  
  // Lista fija con las opciones que aparecerán en el Dropdown (selector)
  final List<String> _islands = [
    'Tenerife', 
    'Gran Canaria', 
    'La Palma', 
    'Lanzarote', 
    'Fuerteventura', 
    'La Gomera', 
    'El Hierro'
  ];
  
  // Controlador para leer y escribir el texto en el input de notas personales
  final TextEditingController _notesController = TextEditingController();

  // --- CICLO DE VIDA ---
  
  @override
  void initState() {
    super.initState();
    // initState se ejecuta una única vez cuando la pantalla se abre.
    // Llamamos a la función que carga los datos guardados para que aparezcan automáticamente.
    _loadSavedData();
  }

  // --- MÉTODOS DE LÓGICA ---

  // Función para recuperar los datos de la memoria del teléfono
  void _loadSavedData() {
    setState(() {
      // Recupera la isla guardada. Si existe, actualiza la variable.
      _selectedIsland = LocalStorageService.getString('preferred_island');
      
      // Recupera el texto de las notas. Si es null (no hay nada guardado), pone un texto vacío ('').
      _notesController.text = LocalStorageService.getString('user_notes') ?? '';
    });
  }

  // Función asíncrona para guardar los datos al pulsar el botón
  void _saveData() async {
    // Solo guarda la isla si el usuario ha seleccionado alguna
    if (_selectedIsland != null) {
      await LocalStorageService.saveString('preferred_island', _selectedIsland!);
    }
    
    // Guarda el texto actual que haya en el input de notas
    await LocalStorageService.saveString('user_notes', _notesController.text);
    
    // Muestra un mensaje emergente (SnackBar) en la parte inferior para confirmar el guardado
    // 'mounted' comprueba que la pantalla sigue abierta antes de mostrar el mensaje
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ajustes guardados en memoria')),
      );
    }
  }

  // --- INTERFAZ GRÁFICA (UI) ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Color de fondo general
      
      // Barra superior
      appBar: AppBar(
        title: const Text('Ajustes', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary, // Color morado principal
        iconTheme: const IconThemeData(color: Colors.white), // Icono del menú en blanco
      ),
      
      // Conecta el menú lateral para poder navegar a otras pantallas
      drawer: const AppDrawer(),
      
      // Padding añade un margen de 20 píxeles alrededor de todo el contenido
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
          children: [
            // Título para el selector de islas
            const Text(
              'Isla de preferencia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 10), // Separación vertical
            
            // Selector desplegable (Dropdown)
            DropdownButtonFormField<String>(
              initialValue: _selectedIsland, // Muestra el valor guardado o null
              hint: const Text('Selecciona una isla'), // Texto por defecto si es null
              decoration: const InputDecoration(border: OutlineInputBorder()), // Borde cuadrado
              items: _islands.map((island) {
                // Genera las opciones del menú a partir de la lista _islands
                return DropdownMenuItem(value: island, child: Text(island));
              }).toList(),
              onChanged: (val) {
                // Actualiza la variable cuando el usuario elige una nueva opción
                setState(() {
                  _selectedIsland = val;
                });
              },
            ),
            
            const SizedBox(height: 30), // Separación grande
            
            // Título para el input de texto
            const Text(
              'Notas personales',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 10),
            
            // Campo de texto para escribir
            TextField(
              controller: _notesController, // Conectamos el controlador
              maxLines: 4, // Hace que la caja de texto sea más grande (4 líneas de alto)
              decoration: const InputDecoration(
                hintText: 'Escribe tus notas, equipamiento necesario, etc.', // Texto de ayuda
                border: OutlineInputBorder(), // Borde cuadrado
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Botón de guardar centrado
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Tamaño del botón
                ),
                onPressed: _saveData, // Llama a la función de guardado al hacer clic
                icon: const Icon(Icons.save, color: Colors.white), // Icono de disquete
                label: const Text('Guardar Ajustes', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
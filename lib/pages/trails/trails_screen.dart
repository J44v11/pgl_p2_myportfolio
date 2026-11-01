import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import '../../shared/theme/app_colors.dart';
import '../../models/trail_model.dart';

class TrailsScreen extends StatefulWidget {
  const TrailsScreen({super.key});

  @override
  State<TrailsScreen> createState() => _TrailsScreenState();
}

class _TrailsScreenState extends State<TrailsScreen> {
  // Lista dinámica con datos iniciales basados en tu diseño
  final List<Trail> _trails = [
    Trail(
      id: '1',
      name: 'Bosque de Anaga',
      description: 'Dificultad: alta',
      category: 'Bosque',
    ),
    Trail(
      id: '2',
      name: 'Barranco de Masca',
      description: 'Dificultad: media',
      category: 'Barranco',
    ),
    Trail(
      id: '3',
      name: 'Lanzarote',
      description: 'Dificultad: baja',
      category: 'Costa',
    ),
  ];

  // Controladores para el Modal
  final TextEditingController _nameController = TextEditingController();
  String? _selectedDifficulty = 'Desconocida';
  final List<String> _difficulties = ['baja', 'media', 'alta'];
  String? _selectedCategory = 'Desconocida';
  final List<String> _categories = ['Bosque', 'Barranco', 'Costa'];

  // Función para borrar elemento
  void _deleteTrail(String id) {
    setState(() {
      _trails.removeWhere((trail) => trail.id == id);
    });
  }

  // Función para mostrar el modal y añadir elemento
  void _showAddTrailDialog() {
    _nameController.clear();
    _selectedDifficulty = null;
    _selectedCategory = null;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Para poder actualizar el Dropdown dentro del modal
          builder: (context, setStateModal) {
            return AlertDialog(
              title: const Text('Añadir Sendero'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  //Añadir Nombre del Sendero
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del sendero',
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Selector de Dificultad del Sendero
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDifficulty,
                      hint: const Text('Desconocida'),
                      decoration: const InputDecoration(labelText: 'Dificultad'),
                      items: _difficulties.map((diff) {
                        return DropdownMenuItem(
                          value: diff, 
                          child: Text(diff),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateModal(() => _selectedDifficulty = val);
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    // Selector de Categoría
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      hint: const Text('Desconocida'),
                      decoration: const InputDecoration(labelText: 'Categoría'),
                      items: _categories.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateModal(() => _selectedCategory = val);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      setState(() {
                        _trails.add(
                          Trail(
                            id: DateTime.now().toString(),
                            name: _nameController.text,
                            description: 'Dificultad: ${_selectedDifficulty ?? 'Desconocida'}',
                            category: 'Categoría: ${_selectedCategory ?? 'Desconocida'}',
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
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

  void _showEditTrailDialog(Trail trail) {
    //Rellenar los controladores con los datos actuales
    _nameController.text = trail.name;

    //Extraer la categoria del texto "Bosque, costa, barranco" 
    String currentCategory = trail.description.replaceAll('Dificultad: ', '');
    if (_categories.contains(currentCategory)) {
      _selectedCategory = currentCategory;
    } else {
      _selectedCategory = null;
    }

    //Extraer la dificultad del texto "Dificultad: alta, baja, media"
    String currentDiff = trail.description.replaceAll('Dificultad: ', '');
    if (_difficulties.contains(currentDiff)) {
      _selectedDifficulty = currentDiff;
    } else {
      _selectedDifficulty = null;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return AlertDialog(
              title: const Text('Editar Sendero'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre del sendero'),
                    ),
                    const SizedBox(height: 15),
                    
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDifficulty,
                      hint: const Text('Desconocida'),
                      decoration: const InputDecoration(labelText: 'Dificultad'),
                      items: _difficulties.map((diff) {
                        return DropdownMenuItem(value: diff, child: Text(diff));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setStateModal(() => _selectedDifficulty = val);
                      },
                    ),
                    const SizedBox(height: 15),
                    
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
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      setState(() {
                        //Buscar el índice del sendero a editar y sustituirlo
                        final index = _trails.indexWhere((t) => t.id == trail.id);
                        if (index != -1) {
                          _trails[index] = Trail(
                            id: trail.id, // Se mantiene su ID original
                            name: _nameController.text,
                            description: 'Dificultad: ${_selectedDifficulty ?? 'Desconocida'}',
                            category: 'Categoría: ${_selectedCategory ?? 'Desconocida'}',
                          );
                        }
                      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerBackground,
      appBar: AppBar(
        title: const Text(
          'Gestión de Senderos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Buscador visual
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscador',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Marcador de total de elementos
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'Total de senderos en lista: ${_trails.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Lista Dinámica
          Expanded(
            child: ListView.builder(
              itemCount: _trails.length,
              itemBuilder: (context, index) {
                final trail = _trails[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Imagen según categoría
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Image.asset(
                          trail.imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trail.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                trail.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Botón Editar
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                      onPressed: () => _showEditTrailDialog(trail),
                                      constraints: const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Botón Borrar (Requisito 7)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () => _deleteTrail(trail.id),
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
              },
            ),
          ),
        ],
      ),
      // Botón añadir
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTrailDialog,
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Añadir Sendero',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

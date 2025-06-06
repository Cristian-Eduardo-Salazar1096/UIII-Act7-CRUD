import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi CRUD OXXO"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 115, 74),
        elevation: 4,
        shadowColor: Colors.black54,
      ),
      body: FutureBuilder<List>(
        future: getProducto(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay productos disponibles"));
          }

          final productos = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {}); // recarga la lista
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: Colors.black38,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: Text(
                      producto['nombre'] ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text("Id: ${producto['id_producto'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Precio: \$${producto['precio'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Cantidad: ${producto['cantidad'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Descripcion: ${producto['descripcion'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Categoría: ${producto['categoria'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Caduca: ${producto['fecha_de_cad'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("¿Eliminar '${producto['nombre']}'?"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text("Cancelar")),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Eliminar")),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await deleteProducto(producto["uid"]);
                          setState(() {});
                        }
                      },
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(context, "/edit", arguments: {
                        "uid": producto["uid"],
                        "id_producto": producto["id_producto"],
                        "nombre": producto["nombre"],
                        "precio": producto["precio"],
                        "cantidad": producto["cantidad"],
                        "descripcion": producto["descripcion"],
                        "categoria": producto["categoria"],
                        "fecha_de_cad": producto["fecha_de_cad"],
                      });
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 250, 115, 74),
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

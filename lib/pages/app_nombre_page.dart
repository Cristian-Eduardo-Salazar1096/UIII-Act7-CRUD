import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController idProductoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController fechaCadController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idProductoController.dispose();
    nombreController.dispose();
    precioController.dispose();
    cantidadController.dispose();
    descripcionController.dispose();
    categoriaController.dispose();
    fechaCadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Producto"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 115, 74),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField("ID Producto", idProductoController),
              buildTextField("Nombre", nombreController),
              buildTextField("Precio", precioController, keyboard: TextInputType.number),
              buildTextField("Cantidad", cantidadController, keyboard: TextInputType.number),
              buildTextField("Descripción", descripcionController),
              buildTextField("Categoría", categoriaController),
              buildTextField("Fecha de Caducidad", fechaCadController, hint: "YYYY-MM-DD"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final producto = {
                      "id_producto": idProductoController.text,
                      "nombre": nombreController.text,
                      "precio": double.tryParse(precioController.text) ?? 0.0,
                      "cantidad": int.tryParse(cantidadController.text) ?? 0,
                      "descripcion": descripcionController.text,
                      "categoria": categoriaController.text,
                      "fecha_de_cad": fechaCadController.text,
                    };
                    await db.collection("producto").add(producto);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 250, 115, 74),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text, String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (value) => value == null || value.isEmpty ? "Campo obligatorio" : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

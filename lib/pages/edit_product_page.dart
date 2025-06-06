import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController idProductoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController fechaCadController = TextEditingController();

  late String uid;

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
uid = (arguments["uid"] ?? "") as String;


  idProductoController.text = (arguments["id_producto"] ?? "").toString();
  nombreController.text = (arguments["nombre"] ?? "").toString();
  precioController.text = (arguments["precio"] ?? "").toString();
  cantidadController.text = (arguments["cantidad"] ?? "").toString();
  descripcionController.text = (arguments["descripcion"] ?? "").toString();
  categoriaController.text = (arguments["categoria"] ?? "").toString();
  fechaCadController.text = (arguments["fecha_de_cad"] ?? "").toString();
}

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
        title: const Text("Editar Producto"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 115, 74),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
    await updateProducto(uid, {
      "id_producto": idProductoController.text,
      "nombre": nombreController.text,
      "precio": double.tryParse(precioController.text) ?? 0.0,
      "cantidad": int.tryParse(cantidadController.text) ?? 0,
      "descripcion": descripcionController.text,
      "categoria": categoriaController.text,
      "fecha_de_cad": fechaCadController.text,
    });
    Navigator.pop(context);
  },
  child: const Text("Actualizar"),
),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text, String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

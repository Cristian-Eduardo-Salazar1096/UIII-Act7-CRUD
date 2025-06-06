import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProducto() async {
  List producto = [];
  CollectionReference collectionReferenceProducto = db.collection("producto");
  QuerySnapshot queryProducto = await collectionReferenceProducto.get();

  for (var doc in queryProducto.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      ...data,       
      "uid": doc.id, 
    };
    producto.add(person);
  }
  return producto;
}


Future<void> addNombre(String nombre) async {
  await db.collection("producto").add({"nombre":nombre});
}

Future<void> updateProducto(String uid, Map<String, dynamic> data) async {
  await db.collection("producto").doc(uid).update(data);
}

Future<void> deleteProducto(String uid) async {
  await db.collection("producto").doc(uid).delete();
}
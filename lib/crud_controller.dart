// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class CRUDController extends GetxController {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   // Stream to listen for real-time updates from Firestore
//   Stream<QuerySnapshot> getItemsStream() {
//     return firestore.collection('items').snapshots();
//   }
//
//   // Add a new item to Firestore
//   Future<void> addItem(String name) async {
//     try {
//       await firestore.collection('items').add({'name': name});
//       Get.snackbar("Success", "Item added successfully");
//     } catch (e) {
//       Get.snackbar("Error", "Failed to add item: $e");
//     }
//   }
//
//   // Update an existing item in Firestore
//   Future<void> updateItem(String id, String name) async {
//     try {
//       await firestore.collection('items').doc(id).update({'name': name});
//       Get.snackbar("Success", "Item updated successfully");
//     } catch (e) {
//       Get.snackbar("Error", "Failed to update item: $e");
//     }
//   }
//
//   // Delete an item from Firestore
//   Future<void> deleteItem(String id) async {
//     try {
//       await firestore.collection('items').doc(id).delete();
//       Get.snackbar("Success", "Item deleted successfully");
//     } catch (e) {
//       Get.snackbar("Error", "Failed to delete item: $e");
//     }
//   }
// }

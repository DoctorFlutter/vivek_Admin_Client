import 'package:admin/AdminLoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                addItem(itemNameController.text.trim());
                itemNameController.clear();
              },
              child: Text('Add Item'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: firestore.collection('items').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text(doc['name']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showUpdateDialog(context, doc.id, doc['name']);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDeleteConfirmationDialog(context, doc.id);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addItem(String itemName) async {
    if (itemName.isNotEmpty) {
      try {
        await firestore.collection('items').add({
          'name': itemName,
          'timestamp': FieldValue.serverTimestamp(),
        });
        Get.snackbar("Success", "Item added successfully",backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
      } catch (e) {
        Get.snackbar("Error", "Failed to add item: $e",backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
      }
    }
  }

  void updateItem(String id, String name) async {
    if (name.isNotEmpty) {
      try {
        await firestore.collection('items').doc(id).update({
          'name': name,
        });
        Get.snackbar("Success", "Item updated successfully",backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
      } catch (e) {
        Get.snackbar("Error", "Failed to update item: $e",backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
      }
    }
  }

  void deleteItem(String id) async {
    try {
      await firestore.collection('items').doc(id).delete();
      Get.snackbar("Success", "Item deleted successfully",backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete item: $e",backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
    }
  }

  void showUpdateDialog(BuildContext context, String id, String currentName) {
    final TextEditingController nameController = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Item'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                updateItem(id, nameController.text.trim());
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteItem(id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => AdminLoginScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:vendorapp/admin/adminmodels/CategoryList.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:vendorapp/admin/pages/viewcategories.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

class AdminViewSubcategory extends StatefulWidget {
  final AdminCatagoryListModel category;
  AdminViewSubcategory({required this.category});

  @override
  State<AdminViewSubcategory> createState() => _AdminViewSubcategoryState();
}

class _AdminViewSubcategoryState extends State<AdminViewSubcategory> {
  bool gettingdata = true;
  TextEditingController subcategoryname = TextEditingController();
  TextEditingController newsubcategoryname = TextEditingController();
  void getAdminAllcategories() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    try {
      Response<Map> response = await Dio()
          .get("https://api.semer.dev/api/admin/category", options: options);

      var success = response.data!['status'];
      if (success == "success") {
        List<dynamic> allcategories = response.data!['data'];
        adminallcategories = allcategories
            .map((e) => AdminCatagoryListModel.fromMap(e))
            .toList();
        setState(() {
          // gettindata = true;
        });
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  void requestdeleteSubcategory(BuildContext context, int itemtodelete) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    try {
      Response<Map> response = await Dio().post(
          'https://api.semer.dev/api/admin/subcategory/delete/${itemtodelete}',
          options: options);

      var success = response.data!['status'];
      if (success == "success") {
        Get.snackbar("Message", "Item Successfully deleted");
        getAdminAllcategories();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => AdminViewCategories())));
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  void requestupdateSubcategory(BuildContext context, int itemtoupdate,
      String newname, int parentid) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );

    var senddata = {"name": newsubcategoryname.text, "parent_id": parentid};
    try {
      Response<Map> response = await Dio().post(
          'https://api.semer.dev/api/admin/subcategory/update/${itemtoupdate}',
          data: senddata,
          options: options);

      var success = response.data!['status'];
      if (success == "success") {
        Get.snackbar("Message", "Item Successfully updated");
        getAdminAllcategories();
        newsubcategoryname.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => AdminViewCategories())));
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  void requestCreateSubCategory(BuildContext context) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    try {
      var formData = FormData.fromMap({
        "name": subcategoryname.text,
        "parent_id": widget.category.id,
      });
      Response<Map> response = await Dio().post(
          "https://api.semer.dev/api/admin/subcategory/create",
          data: formData,
          options: options);

      var success = response.data!['status'];
      if (success == "success") {
        Get.snackbar("Sucess", "Subcategory Successtully created");
        Navigator.of(context).pop();

        setState(() {
          // gettindata = false;
        });
        subcategoryname.clear();
        getAdminAllcategories();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => AdminViewCategories())));
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "SubCategory Setting",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: widget.category.subcategory.length > 0
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                    child: ListView.builder(
                      itemCount: widget.category.subcategory.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              '${widget.category.subcategory[index].name}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            trailing: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Add this to prevent overflow
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.black),
                                  onPressed: () {
                                    updateSubCategory(
                                        context,
                                        widget.category.subcategory[index].id,
                                        widget.category.subcategory[index].name,
                                        widget.category.id);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.black), // Changed icon
                                  onPressed: () {
                                    deleteSubCategory(context,
                                        widget.category.subcategory[index].id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        createCategory(context);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 40,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    "No SubCategories Found",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        createCategory(context);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 40,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  createCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create SubCategory'),
            content: TextField(
              controller: subcategoryname,
              decoration: InputDecoration(
                hintText: 'Your subcategory name',
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.teal),
                ),
                onPressed: () {
                  if (subcategoryname.text != "") {
                    requestCreateSubCategory(context);
                  } else {
                    Get.snackbar("Message", "SubCategory name is required");
                  }
                },
              ),
              TextButton(
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        });
  }

  deleteSubCategory(BuildContext context, int itemindex) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete SubCategory'),
            content: Text("Are you sure you want to delete?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  requestdeleteSubcategory(context, itemindex);
                },
              ),
              TextButton(
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.teal),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  updateSubCategory(
      BuildContext context, int itemindex, String name, int parentid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update ${name}'),
            content: TextField(
              controller: newsubcategoryname,
              decoration:
                  InputDecoration(hintText: 'Your new subcategory name'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  if (newsubcategoryname.text.trim != "") {
                    if (newsubcategoryname.text == name) {
                      Get.snackbar("Error", "THis name is already used");
                    } else {
                      requestupdateSubcategory(
                          context, itemindex, name, parentid);
                    }
                  } else {
                    Get.snackbar("Error", "The new name is required");
                  }
                },
              ),
            ],
          );
        });
  }
}

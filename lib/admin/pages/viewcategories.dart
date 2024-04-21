import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:vendorapp/admin/adminmodels/CategoryList.dart';
import 'package:vendorapp/admin/pages/viewsubcategory.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

class AdminViewCategories extends StatefulWidget {
  const AdminViewCategories({super.key});

  @override
  State<AdminViewCategories> createState() => _AdminViewCategoriesState();
}

class _AdminViewCategoriesState extends State<AdminViewCategories>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool gettindata = false;
  TextEditingController categoryname = TextEditingController();
  TextEditingController newcategoryname = TextEditingController();
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
          gettindata = true;
        });
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  void requestupdatecategory(
      BuildContext context, int itemtoupdate, String newname) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );

    var senddata = {"name": newcategoryname.text};
    try {
      Response<Map> response = await Dio().post(
          'https://api.semer.dev/api/admin/category/update/${itemtoupdate}',
          data: senddata,
          options: options);

      var success = response.data!['status'];
      if (success == "success") {
        Get.snackbar("Message", "Item Successfully updated");
        setState(() {
          gettindata = false;
        });
        newcategoryname.clear();
        Navigator.pop(context);
        getAdminAllcategories();
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  void requestCreateCategory(BuildContext context) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    try {
      var formData = FormData.fromMap({
        "name": categoryname.text,
      });
      Response<Map> response = await Dio().post(
          "https://api.semer.dev/api/admin/category/create",
          data: formData,
          options: options);

      var success = response.data!['status'];
      if (success == "success") {
        Navigator.of(context).pop();
        setState(() {
          gettindata = false;
        });
        categoryname.clear();
        getAdminAllcategories();
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  void requestdeletecategory(int itemtodelete) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');

    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    try {
      Response<Map> response = await Dio().post(
          'https://api.semer.dev/api/admin/category/delete/${itemtodelete}',
          options: options);

      var success = response.data!['status'];
      if (success == "success") {
        Get.snackbar("Message", "Item Successfully deleted");
        getAdminAllcategories();
      } else {
        Get.snackbar("Error", response.data!['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }

  @override
  void initState() {
    super.initState();
    getAdminAllcategories();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          "Categories Setting",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: gettindata
          ? Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                    child: ListView.builder(
                      itemCount: adminallcategories.length,
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminViewSubcategory(
                                            category: adminallcategories[index],
                                          )));
                            },
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${adminallcategories[index].name}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            updateCategory(
                                                context,
                                                adminallcategories[index].id,
                                                adminallcategories[index].name);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 25,
                                            color: Colors.black,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            deleteCategory(
                                              context,
                                              adminallcategories[index].id,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 25,
                                            color: Colors.black,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey),
                              onTap: () {
                                print("Clicked");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdminViewSubcategory(
                                              category:
                                                  adminallcategories[index],
                                            )));
                              },
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
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              ),
            ),
    );
  }

  createCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create Category'),
            content: TextField(
              controller: categoryname,
              decoration: InputDecoration(
                hintText: 'Your category name',
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.teal),
                ),
                onPressed: () {
                  if (categoryname.text != "") {
                    requestCreateCategory(context);
                  } else {
                    Get.snackbar("Message", "Category name is required");
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

  deleteCategory(BuildContext context, int itemindex) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Category'),
            content: Text("Are you sure you want to delete?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  requestdeletecategory(itemindex);
                  Navigator.pop(context);
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

  updateCategory(BuildContext context, int itemindex, String name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update ${name}'),
            content: TextField(
              controller: newcategoryname,
              decoration: InputDecoration(hintText: 'Your new category name'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  if (newcategoryname.text.trim != "") {
                    if (newcategoryname.text == name) {
                      Get.snackbar("Error", "This name is already used");
                    } else {
                      requestupdatecategory(context, itemindex, name);
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

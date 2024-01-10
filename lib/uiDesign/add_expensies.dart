import 'package:flutter/material.dart';
import 'package:flutter_application_budget_app_using_sqflite/DBHelper/DBHelper.dart';
import 'package:flutter_application_budget_app_using_sqflite/UserModel/user.dart';
import 'package:flutter_application_budget_app_using_sqflite/uiDesign/home.dart';
import 'package:flutter_application_budget_app_using_sqflite/utils/utils.dart';

class Add_expensies extends StatefulWidget {
  const Add_expensies({super.key});

  @override
  State<Add_expensies> createState() => _Add_expensiesState();
}

class _Add_expensiesState extends State<Add_expensies> {
  final add_category = TextEditingController();
  final add_expensies = TextEditingController();
  final KeyForm = GlobalKey<FormState>();
  final db = DBHelper();
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    db.initDatabase();
  }

  void dispose() {
    super.dispose();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff4E4E4E),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff3C3C3C),
          title: Text(
            'Add Expensies',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Column(
            children: [
              Form(
                  key: KeyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: add_category,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: 'Add Category',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Category';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: add_expensies,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Add Expensies',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Expensies';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() async {
                              if (KeyForm.currentState!.validate()) {
                                double amount =
                                    double.parse(add_expensies.text);
                                await db
                                    .insertData(UserModel(
                                        title: add_category.text,
                                        amount: amount,
                                        date: DateTime.now().toString()))
                                    .then((value) {
                                  Utils().toastMessage(
                                      'Expensies Add Successfully');
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            });
                          },
                          child: Text('Add Expensies'))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

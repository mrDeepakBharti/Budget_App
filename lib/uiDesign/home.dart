import 'package:flutter/material.dart';
import 'package:flutter_application_budget_app_using_sqflite/DBHelper/DBHelper.dart';
import 'package:flutter_application_budget_app_using_sqflite/UserModel/user.dart';
import 'package:flutter_application_budget_app_using_sqflite/uiDesign/add_expensies.dart';
import 'package:flutter_application_budget_app_using_sqflite/uiDesign/update_data.dart';
import 'package:flutter_application_budget_app_using_sqflite/uiDesign/userBudget.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final balance = TextEditingController();
  DBHelper? db;
  late Future<List<UserModel>> userlist;
  @override
  void initState() {
    super.initState();
    db = DBHelper();
    load();
    balance.clear();
  }

  load() {
    userlist = db!.getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff3C3C3C),
          appBar: AppBar(
            backgroundColor: const Color(0xfff3C3C3C),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: TabBar(
              isScrollable: true,
              tabs: [
                for (int i = 1; i <= 12; i++)
                  Tab(
                    text: getMonth(i),
                  )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
            ),
            child: TabBarView(
              children: [
                for (int i = 1; i <= 12; i++)
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                            color: Color(0xfff4E4E4E),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.02,
                                  vertical: 3,
                                ),
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Budget',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.0),
                                      child: UserBudget(),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 45.0,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: balance,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      hintText: 'Amount',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      suffixIcon: Icon(Icons.attach_money),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ListTile(
                            title: Text(
                              'Create a new Category',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Add_expensies()));
                                },
                                icon: Icon(Icons.add))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 500.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0))),
                            child: Column(
                              children: [
                                // ignore: avoid_types_as_parameter_names
                                Expanded(
                                  child: FutureBuilder<List<UserModel>>(
                                      future: userlist,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<UserModel>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 60.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xfff3C3C3C)),
                                                  child: Dismissible(
                                                    direction: DismissDirection
                                                        .endToStart,
                                                    key: ValueKey<int>(snapshot
                                                        .data![index].id!),
                                                    onDismissed: (direction) {
                                                      setState(() {
                                                        db!.deleteData(snapshot
                                                            .data![index].id!);
                                                        userlist =
                                                            db!.getData();
                                                        snapshot.data!.remove(
                                                            snapshot
                                                                .data![index]);
                                                      });
                                                    },
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const update_data()));
                                                      },
                                                      child: Card(
                                                        child: ListTile(
                                                          title: Text(snapshot
                                                              .data![index]
                                                              .title
                                                              .toString()),
                                                          trailing: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .amount
                                                                  .toString()),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        } else {
                                          return Wrap(children: [
                                            CircularProgressIndicator()
                                          ]);
                                        }
                                      }),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getMonth(int month) {
    DateTime date = DateTime(DateTime.now().year, month);
    return DateFormat('yMMMM').format(date);
  }
}

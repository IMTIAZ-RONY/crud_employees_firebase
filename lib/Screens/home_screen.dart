import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Service/data_base.dart';
import 'employee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameTEController = TextEditingController();
  TextEditingController ageTEController = TextEditingController();
  TextEditingController locationTEController = TextEditingController();

  Stream? employeeStream;

  getontheloads() async {
    employeeStream = await DataBaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheloads();
    // TODO: implement initState
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: employeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(

                              children: [
                                Text(
                                  "Name: " + ds["Name"],
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                 Spacer(),
                                 GestureDetector(
                                   onTap:(){
                                     nameTEController.text=ds["Name"];
                                     ageTEController.text=ds["Age"];
                                     locationTEController.text=ds["Location"];
                                     editEmployeeDetail(ds['Id']);
                                   }
                                     ,child:  const Icon(Icons.edit,size:22,color:Colors.green  ,)),
                                SizedBox(width:10,),
                                GestureDetector(
                                  onTap: ()async{
                                    await DataBaseMethods().deleteEmployeeDetails(ds["Id"]);
                                    }
                                    ,child: Icon(Icons.delete,size: 20,color:Colors.red ,)),
                              ],
                            ),
                            Text(
                              "Age: " + ds["Age"],
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Location: " + ds["Location"],
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Employee()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            backgroundColor: Colors.cyanAccent,
            foregroundColor: Colors.deepPurple,
            centerTitle: true,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("CRUD APP ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
                Text("Firebase ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    )),
              ],
            ),
          )),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 30,
          ),
          child: Column(children: [Expanded(child: allEmployeeDetails())]),
        ),
      ),
    );
  }
  Future editEmployeeDetail(String id)=>showDialog(context: context,
      builder:(context)=>AlertDialog(
        content:SingleChildScrollView(
           child: Container(

            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pop(context);},
                        child: Icon(Icons.cancel,size:20,color:Colors.red ,)),
                    SizedBox(width:40,),
                    Text("Edit ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )),
                    Text("Details ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        )),
                  ],
                ),
                SizedBox(height:20 ,),
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: nameTEController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Age",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: ageTEController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: locationTEController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width:200 ,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,

                    ),
                    onPressed: ()async {
                      Map<String,dynamic>updateInfo={
                        "Name":nameTEController.text,
                        "Age":ageTEController.text,
                        "Id":id,
                        "Location":locationTEController.text,
                      };
                      await DataBaseMethods().updateEmployeeDetails(id, updateInfo).then((value){
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ) ,
      ));
}

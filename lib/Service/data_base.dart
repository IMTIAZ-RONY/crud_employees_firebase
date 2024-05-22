import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  //CREATE
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }
  //READ

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
//UPDATE
  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
 return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(updateInfo);
  }
//DELETE
  Future deleteEmployeeDetails(String id,) async {
    return  await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }

}

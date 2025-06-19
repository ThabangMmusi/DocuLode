// part of app_constants;

// // current date
// final String currentYYYY = DateFormat("yyyy").format(DateTime.now());
// final String currentMM = DateFormat("MM").format(DateTime.now());
// final String currentDD = DateFormat("dd").format(DateTime.now());

// DocumentReference<Map<String, dynamic>> orgDoc() => FirebaseFirestore.instance
//     .collection(DBKeys.keyBusiness)
//     .doc(OrgController.to.orgInfo.value.oid!);

// CollectionReference<Map<String, dynamic>> orgMoreCollection() =>
//     FirebaseFirestore.instance
//         .collection(DBKeys.keyBusiness)
//         .doc(OrgController.to.orgInfo.value.oid!)
//         .collection(DBKeys.keyMore);

// CollectionReference<Map<String, dynamic>> counterCollection() =>
//     orgDoc().collection(DBKeys.keyCounters);

// DocumentReference<Map<String, dynamic>> currentDayCurrentEmployeeCounterDoc() =>
//     counterCollection()
//         .doc("$currentYYYY-$currentMM")
//         .collection(currentDD)
//         .doc(AuthController.to.firestoreUser.value!.uid);

// CollectionReference<Map<String, dynamic>> verifiedCounterCollection() =>
//     orgDoc().collection(DBKeys.keyVerifiedCounters);

// CollectionReference<Map<String, dynamic>> employeesCollection() =>
//     orgDoc().collection(DBKeys.keyEmployees);

// CollectionReference<Map<String, dynamic>> paymentsCollection() =>
//     orgDoc().collection(DBKeys.keyPayments);

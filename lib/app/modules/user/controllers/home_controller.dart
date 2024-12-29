import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rxn<User> currentUser = Rxn<User>();
  Rxn<DocumentSnapshot> userData = Rxn<DocumentSnapshot>();
  RxList<QueryDocumentSnapshot> recommendedJobs = <QueryDocumentSnapshot>[].obs;
  RxList<QueryDocumentSnapshot> recentJobs = <QueryDocumentSnapshot>[].obs;
  RxList<QueryDocumentSnapshot> searchResults = <QueryDocumentSnapshot>[].obs;
  RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.value = user;

    if (user != null) {
      _fetchUserData();
      _fetchRecommendedJobs();
      _fetchRecentJobs();
    }

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        currentUser.value = user;
        _fetchUserData();
      }
    });
  }

  void _fetchUserData() {
    _firestore
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((snapshot) {
      userData.value = snapshot;
    });
  }

  void _fetchRecommendedJobs() {
    _firestore
        .collection('jobs')
        .where('status', isEqualTo: 1)
        .snapshots()
        .listen((snapshot) {
      var jobs = snapshot.docs;
      String userSkill = _getUserSkill();
      var recommended = jobs.where((job) {
        var jobSkills = job['skills'] is List
            ? List<String>.from(
                (job['skills'] as List).map((e) => e.toString()))
            : <String>[];
        return jobSkills.contains(userSkill);
      }).toList();

      if (recommended.isEmpty) {
        recommended = jobs.take(3).toList();
      }

      recommendedJobs.assignAll(recommended);
    });
  }

  void _fetchRecentJobs() {
    _firestore
        .collection('jobs')
        .where('status', isEqualTo: 1)
        .limit(5)
        .snapshots()
        .listen((snapshot) {
      recentJobs.assignAll(snapshot.docs);
    });
  }

  String _getUserSkill() {
    if (userData.value == null) return '';
    if (userData.value!['skills'] is List) {
      return (userData.value!['skills'] as List).join(', ');
    }
    return userData.value!['skills'] ?? '';
  }

  void searchJobs(String query) {
    searchText.value = query.trim().toLowerCase();

    if (searchText.isEmpty) {
      searchResults.clear();
      return;
    }

    _firestore.collection('jobs').
    where('status', isEqualTo: 1).
    snapshots().listen((snapshot) {
      var jobs = snapshot.docs.where((job) {
        var jobName = job['jobName']?.toString().toLowerCase() ?? '';
        return jobName.contains(searchText.value);
      }).toList();

      searchResults.assignAll(jobs);
    });
  }
}

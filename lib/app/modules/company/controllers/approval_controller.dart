import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo/app/modules/company/views/company_bottom_nav.dart';
import 'package:empleo/app/modules/company/views/company_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ApprovalController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var status = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToStatus();
  }

  void _listenToStatus() {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      _firestore
          .collection('companies')
          .doc(uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          int? updatedStatus = snapshot.data()?['status'];
          if (updatedStatus != null) {
            status.value = updatedStatus;
            _handleStatusChange(updatedStatus);
          }
        }
      });
    }
  }

  void _handleStatusChange(int updatedStatus) {
    if (updatedStatus == 1) {
      Get.offAll(() => CompanyNav());
    } else if (updatedStatus == -1) {
      _showRejectionDialog();
    }
  }

  void _showRejectionDialog() async {
    String? uid = _auth.currentUser?.uid;
    await _firestore.collection('companies').doc(uid).delete();

    await FirebaseAuth.instance.currentUser?.delete();
    await FirebaseAuth.instance.signOut();
    Get.defaultDialog(
      backgroundColor: Colors.white,
      buttonColor: HexColor('4CA6A8'),
      middleTextStyle: GoogleFonts.poppins(),
      titleStyle: GoogleFonts.poppins(),
      title: 'Request Rejected',
      middleText: 'Your registration request has been rejected by the admin.',
      textConfirm: 'OK',
      onConfirm: () {
        Get.offAll(() => CompanyLogin());
      },
    );
  }
}

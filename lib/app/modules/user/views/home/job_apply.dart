import 'package:empleo/app/modules/user/views/user_bottom_nav.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class JobApply extends StatefulWidget {
  const JobApply({super.key});

  @override
  _JobApplyState createState() => _JobApplyState();
}

class _JobApplyState extends State<JobApply> {
  String selectedState = '';
  String selectedCV = '';

  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi',
    'Puducherry'
  ];

  List<String> filteredStates = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStates = states;
    searchController.addListener(_filterStates);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterStates);
    searchController.dispose();
    super.dispose();
  }

  void _filterStates() {
    setState(() {
      filteredStates = states
          .where((state) =>
              state.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.arrow_circle_left,
                        size: 30.sp,
                        color: Colors.black,
                      ),
                      100.w.horizontalSpace,
                      Text(
                        'Job Apply',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  30.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextField('First Name', width: 150.w),
                      _buildTextField('Last Name', width: 150.w),
                    ],
                  ),
                  40.h.verticalSpace,
                  _buildTextField('Your Email'),
                  40.h.verticalSpace,
                  _buildStatePicker(context),
                  40.h.verticalSpace,
                  _buildTextField('Message', maxLines: 4),
                  40.h.verticalSpace,
                  _buildCVPicker(),
                  30.h.verticalSpace,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => BottomNav());
                      },
                      child: Container(
                        width: 330.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: HexColor('4CA6A8'),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Apply Now',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {double? width, int maxLines = 1}) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('4CA6A8')),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('4CA6A8')),
          ),
        ),
      ),
    );
  }

  Widget _buildStatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _showStateSelectionModal(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: HexColor('4CA6A8')),
          borderRadius: BorderRadius.circular(5.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedState.isEmpty ? 'Select your state' : selectedState,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: selectedState.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
            Icon(Iconsax.arrow_down5, size: 20.sp, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildCVPicker() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: HexColor('4CA6A8')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedCV.isEmpty ? 'Upload Here' : selectedCV,
                style: GoogleFonts.poppins(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              Icon(Iconsax.document5, color: HexColor('4CA6A8'), size: 30.sp),
            ],
          ),
        ),
      ),
    );
  }

  void _showStateSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 400.h,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search state',
                  border: OutlineInputBorder(),
                ),
              ),
              10.h.verticalSpace,
              Expanded(
                child: ListView.builder(
                  itemCount: filteredStates.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredStates[index],
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      onTap: () {
                        setState(() {
                          selectedState = filteredStates[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        selectedCV = result.files.single.name;
      });
    }
  }
}

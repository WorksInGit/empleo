import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: Column(
          children: [
            15.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Applications',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            30.h.verticalSpace,
            Row(
              children: [
                20.w.horizontalSpace,
                Text(
                  'Your Applications',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
            30.h.verticalSpace,
            TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                    color: HexColor('4CA6A8'),
                    borderRadius: BorderRadius.circular(15.r)),
                labelStyle: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Short Listed',
                      )),
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Hired',
                      )),
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Applied',
                      )),
                ]),
            20.h.verticalSpace,
            Expanded(
                child:
                    TabBarView(children: [ShortListed(), Hired(), Applied()]))
          ],
        ),
      ),
    );
  }
}

class ShortListed extends StatefulWidget {
  const ShortListed({super.key});

  @override
  State<ShortListed> createState() => _ShortListedState();
}

class _ShortListedState extends State<ShortListed> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Container(
            width: 300.w,
            height: 120.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              children: [
                Row(
                  children: [
                    20.w.horizontalSpace,
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/facebook.png'))),
                    ),
                    20.w.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.h.verticalSpace,
                        Text(
                          'Facebook',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'Ui/Ux Designer',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Andheri, Mumbai',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.currency_rupee_sharp,
                      size: 13.sp,
                    ),
                    Text('20000/Monthly'),
                    20.w.horizontalSpace
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Hired extends StatefulWidget {
  const Hired({super.key});

  @override
  State<Hired> createState() => _HiredState();
}

class _HiredState extends State<Hired> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Container(
            width: 300.w,
            height: 140.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              children: [
                Row(
                  children: [
                    20.w.horizontalSpace,
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/facebook.png'))),
                    ),
                    20.w.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.h.verticalSpace,
                        Text(
                          'Facebook',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'Ui/Ux Designer',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Andheri, Mumbai',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                        Container(
                          width: 70.r,
                          height: 30.h,
                          decoration: BoxDecoration(
                              color: HexColor('4CA6A8'),
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Center(
                              child: Text(
                            'Hired',
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.currency_rupee_sharp,
                      size: 13.sp,
                    ),
                    Text('20000/Monthly'),
                    20.w.horizontalSpace
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Applied extends StatefulWidget {
  const Applied({super.key});

  @override
  State<Applied> createState() => _AppliedState();
}

class _AppliedState extends State<Applied> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Container(
            width: 300.w,
            height: 120.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              children: [
                Row(
                  children: [
                    20.w.horizontalSpace,
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/facebook.png'))),
                    ),
                    20.w.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.h.verticalSpace,
                        Text(
                          'Facebook',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'Ui/Ux Designer',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Andheri, Mumbai',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w200),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.currency_rupee_sharp,
                      size: 13.sp,
                    ),
                    Text('20000/Monthly'),
                    20.w.horizontalSpace
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

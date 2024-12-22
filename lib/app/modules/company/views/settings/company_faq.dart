import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyFaq extends StatelessWidget {
  final List<FAQ> companyFaqList = [
    FAQ(
      question: "How can I post a job?",
      answer:
          "To post a job, log in to your company account, navigate to the 'Posts' section, and click on the add icon and fill the required fields.",
    ),
    FAQ(
      question: "What are the costs associated with job postings?",
      answer:
          "Our application doesn't ask you for any money, because it's completely free of cost.",
    ),
    FAQ(
      question: "How can I manage applications?",
      answer:
          "You can manage applications by going to the 'Posts' section. Here, you can view, delete, and contact applicants for each job posting after shortlisting and hiring.",
    ),
    FAQ(
      question: "Can I edit or delete a job posting?",
      answer:
          "Once posted you can't edit it but you can delete it and post it again with the corrected post.",
    ),
    FAQ(
      question: "How do I access insights about my job postings?",
      answer:
          "Go to the 'Analytics' section on your dashboard to view insights, such as the number of applications, and your job postings.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Company FAQ',
                style: GoogleFonts.poppins(
                    fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: ListView.builder(
                itemCount: companyFaqList.length,
                itemBuilder: (context, index) {
                  return FAQTile(faq: companyFaqList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQTile extends StatefulWidget {
  final FAQ faq;

  const FAQTile({Key? key, required this.faq}) : super(key: key);

  @override
  _FAQTileState createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.h),
      child: ExpansionTile(
        title: Text(
          widget.faq.question,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Text(
              widget.faq.answer,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        ),
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

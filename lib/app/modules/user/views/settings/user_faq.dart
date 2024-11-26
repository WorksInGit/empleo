import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class UserFaq extends StatelessWidget {
  final List<FAQ> faqList = [
    FAQ(
      question: "How do I apply for a job?",
      answer:
          "To apply for a job, click on the job listing you're interested in. Fill in the required details and upload your CV before submitting your application.",
    ),
    FAQ(
      question: "What file formats are accepted for CV uploads?",
      answer:
          "We accept PDF and DOC/DOCX formats for CV uploads. Make sure your file size does not exceed 5 MB.",
    ),
    FAQ(
      question: "Can I edit my application after submitting it?",
      answer:
          "Unfortunately, once an application is submitted, it cannot be edited. Make sure all your details are accurate before submitting.",
    ),
    FAQ(
      question: "How can I check the status of my application?",
      answer:
          "You can check your application status by going to the 'My Applications' section in your profile.",
    ),
    FAQ(
      question: "What should I do if I encounter an issue?",
      answer:
          "If you face any issues, please contact our support team via the 'Help & Support' section in the app.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 15.h), 
          Row(
            children: [
              SizedBox(width: 20.w), 
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Iconsax.arrow_circle_left,
                  size: 30.sp, 
                ),
              ),
              SizedBox(width: 125.w), 
              Text(
                'FAQ',
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
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return FAQTile(faq: faqList[index]);
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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanySupport extends StatelessWidget {
  final String supportEmail = "zannank856@gmail.com";
  final String supportPhone = "+91 7012330941";

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      query: 'subject=Support Assistance&body=Describe your issue here...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: supportPhone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Support & Assistance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.email_outlined, color: Colors.blue),
              title: Text('Email Support'),
              subtitle: Text('Send us an email for assistance.'),
              onTap: _sendEmail,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone_outlined, color: Colors.green),
              title: Text('Call Support'),
              subtitle: Text('Talk to our support team over the phone.'),
              onTap: _makePhoneCall,
            ),
          ],
        ),
      ),
    );
  }
}

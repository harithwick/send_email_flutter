import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Emails Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EmailSender(),
    );
  }
}

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  State<EmailSender> createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool emailSent = false;

  clearTextFields() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  sendEmail() {
    
  }

  Future sendEmail({
    required String name,
    required String date,
    required String mobileNumber,
    required String email,
    required String userId,
    required String message,
  }) async {
    String emailPostUrl = "https://api.emailjs.com/api/v1.0/email/send";
    final url = Uri.parse(emailPostUrl);
    final response = await http.post(url,
        headers: {
          'origin': "http://localhost",
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "service_id": "{ENTER SERVICE ID}",
          "template_id": "ENTER TEMPLATE ID",
          "user_id": "{ENTER USER ID}",
          'template_params': {
            "email_address": email,
            "mobile_number": mobileNumber,
            "from_name": name,
            "date": date,
            "user_id": userId,
            "message": message,
          }
        }));
    print("Email Response Body:");
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: 450,
          width: 400,
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Email Sender',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: 'Message'),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter message';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 45,
                  width: 110,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(00))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        sendEmail();
                        clearFields();
                      }
                    },
                    child: const Text('Send', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

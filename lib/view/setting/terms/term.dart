import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Term extends StatelessWidget {
  const Term({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        elevation: 0,
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.acme(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                    '''Welcome to the Inventory Stock Management App . Before you start using the App, please carefully read and agree to the following Terms and Conditions, as they govern your use of the App.    \n The user can perform various actions related to inventory management, such as:\n
              1.Viewing Inventory: Users can see the current stock levels, product details, and other relevant information about the inventory items.\n
              2.Adding New Items: Users may add new products to the inventory, specifying details like product name, description, quantity, price, etc. \n
              3.Editing Existing Items: Users can modify the information of existing inventory items, such as updating stock quantities, changing product details, or adjusting prices. \n
              5.Generating Reports: Users may generate reports that provide insights into inventory levels, sales performance, and other relevant metrics.\n
              6.Analyzing Data: Users can analyze inventory data to make informed decisions, such as identifying popular products or detecting slow-moving items.''',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                " Acceptance of Terms:",
                style:
                    GoogleFonts.acme(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '''              1. By using the App, you agree to be bound by these Terms and Conditions, and any other policies and guidelines posted on the App.If you do not agree with any part of these Terms, please refrain from using the App.\n
              2. App Purpose: The App is designed to assist users in managing their inventory stock efficiently. The App provides functionalities to track, organize, and analyze inventory items, manage stock levels, set notifications for low stock,and generate reports, among other features.\n
              3. Data Privacy: We are committed to protecting your data privacy. Please refer to our Privacy Policy for details on how we collect, use, and protect your personal information.\n
              4. User Responsibilities: You agree to use the App solely for lawful purposes and in accordance with these Terms and Conditions. You are responsible for all activities conducted through your account and must not engage in any actions that may harm the App, its users, or its functionality.\n
              5. Third-Party Services: The App may integrate with third-party services or link to external websites. We are not responsible for the content, privacy practices, or actions of any third-party services. Your use of such services is at your own risk, and you should review the respective Terms and policies of those services.\n
              6. Termination: We reserve the right to Terminate or suspend your access to the App at any time and for any reason without prior notice.\n
              7. Contact: If you have any questions, concerns, or feedback regarding the App or these Terms and Conditions, please contact us.''',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

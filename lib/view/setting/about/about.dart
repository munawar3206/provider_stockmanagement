import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        title: Text(
          'About',
          style: GoogleFonts.acme(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: Image(
                  image: AssetImage('asset/inventoware-logo1.png'),
                  height: 115,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '''Welcome to InventoWare, a powerful and comprehensive inventory stock management application developed by Munawar.With a mission to simplify inventory control for businesses of all sizes, InventoWare offers an array of advanced features to streamline your inventory processes, optimize stock levels, and enhance overall efficiency.
Internship Experience at Bridgeon Solution Kakkanchery,Malappuram:
During my internship at Bridgeon Solution Kakkanchery, I had the privilege of honing my skills in inventory stock management and gaining hands-on experience in implementing cutting-edge solutions. Working alongside talented mentors and peers, I was exposed to the latest industry practices, which have greatly influenced the development of InventoWare. It was an enriching experience that helped me refine my expertise and passion for revolutionizing inventory management.''',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '''Stay Connected with Munawar:
                    
    LinkedIn: Munawar E K
    Instagram: munawar_ek
    GitHub: munawar3206 
    Email: munawarek313@gmail.com 
    Website:https://munawar3206.github.io/personal-webpage/


Feel free to reach out to me through any of these channels. I'm always open to connecting with fellow professionals, collaborators, and enthusiasts. Let's build a vibrant network and share our passion for inventory stock management and technology! Looking forward to connecting with you soon.
InventoWare is committed to empowering businesses to thrive by offering an all-in-one inventory management solution that saves time, reduces costs, and boosts productivity. Whether you are a small business owner or part of a large enterprise, join the InventoWare community today and experience the seamless and hassle-free way to manage your inventory efficiently. Let's embark on this transformative journey together!''',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
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

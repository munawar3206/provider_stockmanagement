import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock/helpers/app_colors.dart';

class About extends StatelessWidget {
  About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.appbar,
        title: Text(
          'About',
          style: GoogleFonts.acme(
              fontWeight: FontWeight.bold, color:AppColors.bottom),
        ),
        iconTheme: const IconThemeData(color:AppColors.bottom),
        elevation: 0,
      ),
      backgroundColor:AppColors.bg,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor:AppColors.card,
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
                      color:AppColors.bottom),
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
                      color: AppColors.bottom),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

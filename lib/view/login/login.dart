import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock/helpers/app_colors.dart';
import 'package:stock/widget/bottom.dart';


final _usernameController = TextEditingController();
String SAVE_KEY_NAME = 'save_key_name';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Lottie.asset(
                          'asset/animation_lllxjypb.json',
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Form(
                          key: _formKey,
                          child: SizedBox(
                            width: size.width * 0.6,
                            child: TextFormField(
                              controller: _usernameController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  hintText: "Username"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Username';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              checkLogin(context);
                            } else {
                              print('Empty value');
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                             AppColors.login),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(120, 35)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide.none),
                            ),
                          ),
                          child: Text(
                            'Gets Start',
                            style: GoogleFonts.acme(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.card),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final username = _usernameController.text;
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('username', username);
    await sharedPref.setBool(SAVE_KEY_NAME, true);

    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(builder: (ctx1) => const Bottom()),
    );
  }
}
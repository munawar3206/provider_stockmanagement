import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stock/view/setting/about/about.dart';
import 'package:stock/view/setting/exit/exit.dart';
import 'package:stock/view/setting/reset/reset.dart';
import 'package:stock/view/setting/terms/term.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final List<ItemData> itemsList = [
    ItemData(Icons.notes, 'Terms and Conditions'),
    ItemData(Icons.info_outlined, 'About'),
    ItemData(Icons.restore, 'Reset App'),
    ItemData(Icons.star, 'Rate App'),
    ItemData(Icons.exit_to_app, 'Exit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        title: Text(
          "Settings",
          style: GoogleFonts.acme(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: itemsList.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color.fromARGB(255, 177, 190, 251),
            thickness: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            final ItemData pages = itemsList[index];
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      pages.icon,
                      color: Colors.black,
                    ),
                    title: Text(
                      pages.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      _handleItemTap(pages);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleItemTap(ItemData pages) {
    switch (pages.name) {
      case 'Terms and Conditions':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Term()),
        );
      case 'About':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => About()),
        );
        break;
      case 'Exit':
        exitDB(context);
      case 'Reset App':
        resetDB(context);
        break;
      default:
        break;
    }
  }
}

class ItemData {
  final IconData icon;
  final String name;

  ItemData(this.icon, this.name);
}

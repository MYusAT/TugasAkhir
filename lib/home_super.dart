import 'package:flutter/material.dart';
import 'list_admin_super.dart' as admins;
import 'list_gudang_super.dart' as gudangs;
import 'main.dart' as main;
import 'global_var.dart';
import 'update_user.dart' as update_user;

class home_super extends StatelessWidget {
  const home_super({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Daftar Admin",),
                Tab(text: "Daftar Gudang",),
              ],
            ),
            title: Text("User : ${g_nama_admin} \ndi Gudang ${g_nama_lengkap_gudang}, sbg ${g_role_admin}"),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.account_box_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => update_user.update_user()),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => main.MyApp()),
                  );
                },
              ),
              
            ],
          ),
          body: TabBarView(
            children: [
              admins.list_admin_super(),
              gudangs.list_gudang_super(),
            ],
          ),
        ),
      ),
    );
  }
}
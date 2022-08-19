import 'package:flutter/material.dart';
import 'posts.dart' as posts;
import 'list_gudang.dart' as gudangs;
import 'main.dart' as main;
import 'global_var.dart';
import 'list_supplier.dart' as supplier;
import 'update_user.dart' as update_user;
import 'list_barang.dart' as barang;

class myhome extends StatelessWidget {
  const myhome({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 30), // Space between tabs
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 2), // Indicator height
                insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
              ),
              isScrollable: true,
              tabs: [
                Tab(text: "Daftar Stok Barang ${g_nama_lengkap_gudang}",),
                Tab(text: "Daftar Gudang-Gudang Tersedia",),
                Tab(text: "Daftar Supplier",),
                Tab(text: "Daftar Barang",),
              ],
            ),
            title: Text("User : ${g_nama_admin} \ndi ${g_nama_lengkap_gudang}, sbg ${g_role_admin}"),
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
              )
            ],
          ),
          body: TabBarView(
            children: [
              posts.PostsPage(),
              gudangs.GudangPage(),
              supplier.list_supplier(),
              barang.list_barang(),
            ],
          ),
        ),
      ),
    );
  }
}
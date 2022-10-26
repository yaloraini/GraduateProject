import 'package:final_project/Home.dart';
import 'package:final_project/profile.dart';
import 'package:flutter/material.dart';
import 'FirebaseAction.dart';
import 'Login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'Modify.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'Settings.dart';

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final PNameController = TextEditingController();
  final PPriceController = TextEditingController();
  final PBPDController = TextEditingController();

  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    //final imageTemprorary = File(image.path);
    final imagePermanent = await saveFilePermanently(image.path);
    setState(() {
      this._image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ZAWD',
                  style: TextStyle(
                    fontFamily: 'Bellota',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        drawerScrimColor: Colors.black38,
        drawer: const NavigationDrawer(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                  'Modify Auction',
                  style: TextStyle(
                    fontFamily: 'Bellota',
                    fontSize: 35,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold),
                ),
            ),
            Form(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: PNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          hintText: 'Pname',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: PPriceController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Starting Price',
                          hintText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: PBPDController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Brief Product Description',
                          hintText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    CustomButton(
                        title: 'Pick from Gallery',
                        icon: Icons.image_search_outlined,
                        onClick: getImage),
                  ],
                ),
              ),
            ),
    
            //Here goes the photo thing
    
            MaterialButton(
              onPressed: () {
                AddProduct({
                  'ProductName': PNameController.text,
                  'ProductPrice': PPriceController.text,
                  'ProductDescription': PBPDController.text
                });
    
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
    
                Fluttertoast.showToast(
                    msg: "Product Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              color: Colors.lightBlueAccent,
              minWidth: 120,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'AUCTION HOUSE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'BIDS',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
            });
          },
        ),
      ),
    );
  }
  Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
  }) {
  return Container(
    width: 280,
    color: Colors.blueAccent,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [Icon(icon), SizedBox(width: 20), Text(title)],
      ),
    ),
  );
  }
}


class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        color: Colors.lightBlueAccent,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT25dmRWW9XDVDEfjggD1OzyJAsyox9ZWHSLn8-SiwNb3csMCSzOefYpKHa4m6-KfQf4g&usqp=CAU"),
            ),
            Column(
              children: [
                Text(
                  'Yazeed Aloraini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'yazeed@gmail.com',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.home_filled,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.lightBlueAccent,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.star,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Auction House'),
            onTap: () {
              print('side auction house is working');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Bids'),
            onTap: () {
              print('side bids is working');
            },
          ),
          SizedBox(
            height: 300,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Log Out'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      );
}
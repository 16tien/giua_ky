import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giuaky/service/database.dart';
import 'package:random_string/random_string.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController typecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Product", style: TextStyle(color: Colors.blue, fontSize: 24.0, fontWeight: FontWeight.bold),),
            Text("Form", style: TextStyle(color: Colors.orange, fontSize: 24.0, fontWeight: FontWeight.bold),)
          ],),),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text("Tên", style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
        SizedBox(height: 10.0,),
        Container(
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: namecontroller,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        SizedBox(height: 20,),
            Text("Loại", style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: typecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20,),
            Text("Giá", style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: pricecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 10.0,),
            Center(
              child: ElevatedButton(onPressed: () async {
                String Id = randomAlphaNumeric(10);
                Map<String, dynamic> productInfoMap={
                  "Name": namecontroller.text,
                  "Type": typecontroller.text,
                  "Id": Id,
                  "Price" : pricecontroller.text
                };
                await DatabaseMethods().addProductDetails(productInfoMap, Id).then((value) {
                  Fluttertoast.showToast(
                      msg: "Them thanh cong",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                });
                Navigator.pop(context);
              }, child: Text("Thêm", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            )
      ],),),
    );
  }
}

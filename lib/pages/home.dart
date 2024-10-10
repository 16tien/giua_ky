import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giuaky/pages/product.dart';
import 'package:giuaky/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController typecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  Stream? ProductStream;

  getontheload()async{
    ProductStream= await DatabaseMethods().getProductDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProductDetails(){
    return StreamBuilder(
        stream: ProductStream,
        builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds=snapshot.data.docs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Material(

                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Tên: "+ ds["Name"] , style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                namecontroller.text = ds["Name"];
                                typecontroller.text = ds["Type"];
                                pricecontroller.text = ds["Price"];
                                EditProductDatail(ds["Id"]);
                              },
                              child: Icon(Icons.edit, color: Colors.orange,)),
                              SizedBox(width: 5.0),
                              GestureDetector(
                                  onTap: () async {
                                    await DatabaseMethods().deleteProductDetail(ds["Id"]);
                                  },
                                  child: Icon(Icons.delete, color: Colors.black,)),
                        ],
                      ),
                      Text("Loại: "+ ds["Type"], style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),),
                      Text("Giá: "+ ds["Price"] + "đ", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            );
      }) : Container();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Product()));
      }, child: Icon(Icons.add),),
      appBar: AppBar(
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Danh sách sản phẩm", style: TextStyle(color: Colors.orange, fontSize: 24.0, fontWeight: FontWeight.bold),)
      ],),),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(children: [
          Expanded(child: allProductDetails()),
        ],),
      ),
    );
  }

  Future EditProductDatail(String id)=> showDialog(context: context, builder: (context)=> AlertDialog(
    content: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.cancel)),

          SizedBox(width: 60.0),
          Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 24.0, fontWeight: FontWeight.bold),),
          Text("Details", style: TextStyle(color: Colors.orange, fontSize: 24.0, fontWeight: FontWeight.bold),)
        ],),
        SizedBox(height: 20),
        Text("Tên", style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
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
        Text("Loại", style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
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
        Text("Giá", style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
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
          SizedBox(height: 30),
          Center(child: ElevatedButton(onPressed: ()async{
            Map<String, dynamic> updateInfo = {
              "Name" : namecontroller.text,
              "Type" : typecontroller.text,
              "Id" : id,
              "Price" : pricecontroller.text
            };
            await DatabaseMethods().updateProductDetail(id, updateInfo).then((value){
              Navigator.pop(context);
            });
          }, child: Text("Update")))
      ],),
    ),
  ));
}

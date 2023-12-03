import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MaterialStateProperty<OutlinedBorder?>? circle=null;

  @override
  Widget build(BuildContext context ){
    return Scaffold(
      appBar: AppBar(
      title:const Text("drone controller"),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,

      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              
              
              ElevatedButton.icon(onPressed: (){
                Navigator.pushNamed(context,"/controller" );
              }, icon:const Icon( Icons.control_camera), label: Text("Controller",style: TextStyle(fontSize: 15.sp),),
              style: ElevatedButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),backgroundColor: Colors.deepPurple,minimumSize: Size(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.width/19)),
              ),
           
             
             ElevatedButton.icon(onPressed: (){
                Navigator.pushNamed(context,"/MPU");
              }, icon:const Icon(Icons.sensors), label: Text("MPU data",style: TextStyle(fontSize: 15.sp),),
              style: ElevatedButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),backgroundColor: Colors.deepPurple,minimumSize: Size(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.width/19))
              ),
              
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(onPressed: (
              ){
              Navigator.pushNamed(context,"/settings");
              }, icon:const Icon(Icons.settings), label: Text("Parameter",style: TextStyle(fontSize: 15.sp),),
              style: ElevatedButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),backgroundColor: Colors.deepPurple,minimumSize: Size(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.width/19))
              )
              ),
              Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(onPressed: (){
              }, icon:const Icon(Icons.camera_alt), label: Text("Camera",style: TextStyle(fontSize: 15.sp)),
              style: ElevatedButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),backgroundColor: Colors.deepPurple,minimumSize: Size(MediaQuery.of(context).size.width/20, MediaQuery.of(context).size.width/19))
              ),
              )
            ],
          )
        ]
      ),

    );
  }
}

  
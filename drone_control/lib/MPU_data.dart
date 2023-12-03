import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
class data extends StatefulWidget{
  @override
  _dataState createState()=>_dataState();
}
class _dataState extends State<data>{
  bool Enable=false;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title:const Text("MPU Data"),
      backgroundColor: Colors.deepPurple,
      toolbarHeight: MediaQuery.of(context).size.height / 8,
    ),
    body: Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.w,top:15.h),
          width: MediaQuery.of(context).size.width/4.5,
          height: MediaQuery.of(context).size.height/3.4,
        child :Card(
          shape: Border.all(color: Colors.deepPurple,width: 0.5),
          elevation: 5,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child:Text("  Accelerometer",style: TextStyle(fontSize: 18.2.sp,fontWeight: FontWeight.bold,color: Colors.deepPurple),),
            ),
           

              Text("  Roll   :",style: TextStyle(fontSize: 16.sp)),
            
             

             Text("  Pitch :",style: TextStyle(fontSize:16.sp ),),
           
             
              Text("  Yaw   :",style: TextStyle(fontSize: 16.sp),),
           
            
          ],
        ),

        ),
        ),
     
        Container(
                   width: MediaQuery.of(context).size.width/4.5,
                             height: MediaQuery.of(context).size.height/3.4,
                   margin: EdgeInsets.only(top: 15.h),
                  
child:
         Card(
          shape: Border.all(color: Colors.deepPurple,width: 0.5),
          elevation: 5,
          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child:Text("  Gyroscope ",style: TextStyle(fontSize: 18.2.sp,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
            ),
            

              Text("  Roll   :",style: TextStyle(fontSize: 16.sp)),
            
            

             Text("  Pitch :",style: TextStyle(fontSize:16.sp),),
           
             
             Text("  Yaw   :",style: TextStyle(fontSize: 16.sp),),
           
           
            
          ],
        ),

        ),
        ),
           Container(
          margin: EdgeInsets.only(top: 15.h),
         width: MediaQuery.of(context).size.width/4.5,
                   height: MediaQuery.of(context).size.height/3.4,
          child :
         Card(
          shape: Border.all(color: Colors.deepPurple,width: 0.5),
          elevation: 5,
          child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h,left: 0),
              child:Text("  Filtred Angle",style: TextStyle(fontSize: 18.2.sp,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
            ),
            

             Text("  Roll   :",style: TextStyle(fontSize: 16.sp)),
           
             

              Text("  Pitch :",style: TextStyle(fontSize:16.sp),),
            
              
              Text("  Yaw   :",style: TextStyle(fontSize: 16.sp),),
           
            
          ],
        ),

        ),
        ),
        Container(         
          width: MediaQuery.of(context).size.width/4.5,
                    height: MediaQuery.of(context).size.height/3.4,

          margin: EdgeInsets.only(top:15.h),
child:
        Card(
          shape: Border.all(color: Colors.deepPurple,width: 0.5),
          elevation: 5,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h,left: 0),
              child:Text("  Temperature ",style: TextStyle(fontSize: 18.2.sp,fontWeight: FontWeight.bold,color: Colors.deepPurple),),
            ),
           
              Text("  Temp : ",style: TextStyle(fontSize: 16.sp),),
            
            
         
              FlutterSwitch(value: Enable,
              activeText: "Enabled",
              inactiveColor: Colors.white,
              inactiveSwitchBorder: Border.all(color: Colors.deepPurple),
              inactiveToggleColor: Colors.deepPurple,
              inactiveText: "Disabled",
              inactiveTextColor: Colors.deepPurple,
              valueFontSize: 12.sp,
              showOnOff: true,
              width: MediaQuery.of(context).size.width/7.5,
              height: MediaQuery.of(context).size.height/16,
              activeColor: Colors.deepPurple,
              activeTextColor: Colors.white,
               onToggle: ((value) { setState(() {
                Enable=value;
               }
               );
              }),
            ),
             
          ],
        ),

        ),
        )
      ],
    ),

   );
  
   }
   

}
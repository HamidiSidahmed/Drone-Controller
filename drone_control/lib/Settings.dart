import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';
class setting extends StatefulWidget{
  @override
  _settingState  createState()=>_settingState();
}
class _settingState extends State<setting> {
final channel = IOWebSocketChannel.connect("ws://192.168.0.2:84");
TextEditingController LPF=TextEditingController();
TextEditingController GYRO=TextEditingController();
TextEditingController ACC=TextEditingController();
TextEditingController Proportional=TextEditingController();
TextEditingController Derivative=TextEditingController();
TextEditingController Integral=TextEditingController();
TextEditingController IPAdress=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Settings"),
        backgroundColor: Colors.deepPurple,
        toolbarHeight: MediaQuery.of(context).size.height / 8,
      ),
      body:
      SingleChildScrollView(
        child:
      Column(
        children:[
         Row(
          children: [
            Container(margin: EdgeInsets.only(top:35.h,left: 45.w),
            child:
             Text("    MPU   ", style: TextStyle(fontSize: 18.sp)),
            ),
             SingleChildScrollView(
            child:
               Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10.h ),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextField(
                      controller: ACC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "ACC scale",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border:const UnderlineInputBorder()),
                    ),
                  ),
                  Container(
                   margin:const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextField(
                      controller: GYRO,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "GYRO scale",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border:const UnderlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextField(
                      controller:LPF,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "LPF Frequency",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border:const UnderlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
            Container(margin:EdgeInsets.only(top:40.h),
            child:IconButton(onPressed: (){
              Map<String,double> MPU_Setting={
                "Gyro":double.parse(GYRO.text),
                "Acc":double.parse(ACC.text),
                "LPF":double.parse(LPF.text),
              };
              channel.sink.add(MPU_Setting);


            },icon:const Icon(Icons.send,color: Colors.deepPurple,)),
            ),
            Container(
              margin: EdgeInsets.only(top:35.h,left: 25.w),
             child: 
            Text("    PID    ",style: TextStyle(fontSize: 18.sp),),
            ),
            Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h,top: 10.h ),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextField(
                      controller:Proportional ,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Propotional Gain",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border:const UnderlineInputBorder()),
                    ),
                  ),
                  Container(
                   margin: EdgeInsets.only(bottom: 10.h),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextField(
                      controller: Integral,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Integral Gain",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border:const UnderlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextField(
                      controller: Derivative,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Derivative Gain",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border:const UnderlineInputBorder()),
                    ),
                  ),
                  
                ],
              ), 
               Container(margin:const EdgeInsets.only(top:40),
            child:IconButton(onPressed: (){
              Map<String,double> PID ={
                "P":double.parse(Proportional.text),
                "I":double.parse(Integral.text),
                "D":double.parse(Derivative.text),
             };
              channel.sink.add(PID);
             
            },icon:const Icon(Icons.send,color: Colors.deepPurple,)),
            ),      
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(margin: EdgeInsets.only(top: 35.h),
           child: Text("IP Adress  ",style: TextStyle(fontSize: 18.sp),),
          ),
            Container(
              margin: EdgeInsets.only(top:35.h ),
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 12,

                    child: TextField(
                      controller: IPAdress,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border:const UnderlineInputBorder(),
                      hintText: "Enter you ip Adress",
                      hintStyle: TextStyle(fontSize: 14.sp)

                      ),
                                          textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
 Container(margin:EdgeInsets.only(top:40.h),
            child:IconButton(onPressed: (){
            },icon:const Icon(Icons.send,color: Colors.deepPurple,)),
            ),
        ],)
        ],
      )
      )
    );
  }
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

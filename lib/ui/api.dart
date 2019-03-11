import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class User{
 final String guid;
 final String email;
 final String picture;
 User(this.email,this.guid,this.picture);
}

class ApiService extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Api();
  }


}


 class Api extends State<ApiService> {
  var seleted = 18;
  var baber = 'John';
  var times = '12.30';

Future<List<User>> getJson() async{
var  data = await http.get("http://www.json-generator.com/api/json/get/bUBkWcQNBu?indent=4");
var jsondata = json.decode(data.body);

List<User> users =[];
for(var u in jsondata){
  User user = User(u["guid"],u["email"],u["picture"]);

  users.add(user);
}
print(users.length);
  return users;
}
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: new Text("BOOKING ",style: TextStyle(
          fontSize: 16.5,
          color: Colors.black
        ),),
        centerTitle: true,
        backgroundColor: Colors.white,

       leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null,alignment: Alignment.topRight,),

      ),
body:Container(

//    Stack(
//      children: <Widget>[
//        Container(
//          height: 100.0,
//          decoration: BoxDecoration(
//            boxShadow: [
//              BoxShadow(
//                blurRadius: 3.0,
//                color: Colors.black.withOpacity(0.2),
//                spreadRadius: 5.0
//              )
//            ],
//            color: Colors.white
//          ),
//        ),
//        Positioned(
//          top: 25.0,
//          left: 15.0,
//          right: 15.0,
//          child: Container(
//            height: 60.0,
//            child: ListView(
//              scrollDirection: Axis.horizontal,
//              children: <Widget>[
//                getDate(18,'Tue'),
//                SizedBox(width: 25.0,),
//                getDate(19,'Wed'),
//                SizedBox(width: 25.0,),
//                getDate(20,'Fri'),
//                SizedBox(width: 25.0,),
//                getDate(21,'Sat'),
//                SizedBox(width: 25.0,)
//                ,getDate(22,'Sat'),
//                SizedBox(width: 25.0,)
//                ,getDate(23,'Sat'),
//                SizedBox(width: 25.0,)
//                ,getDate(24,'Sat'),
//                SizedBox(width: 25.0,)
//                ,getDate(25,'Sat'),
//                SizedBox(width: 25.0,)
//              ],
//            ),
//          ),
//        )
//      ],
//    ),
//    SizedBox(height: 35.0,),
//    Center(
//      child: Text("Hagorapt",
//          style:TextStyle(
//              letterSpacing: 2.0,
//              fontSize: 30.0,
//            color: Colors.black.withOpacity(0.6),
//            fontWeight: FontWeight.bold
//          )),
//
//    ),
//    SizedBox(height: 35.0,),
   child: FutureBuilder(future:getJson() ,
    builder: (BuildContext context,AsyncSnapshot snapshot){
      if(snapshot.data == null){
        return Container(
          child: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.red,),
          ),
        );

      }
      else{
     return ListView.builder(itemCount:snapshot.data.length,itemBuilder: (BuildContext context , int index){
          return ListTile(

            leading: CircleAvatar(
              child: Text(snapshot.data[index].guid[0].toString().toUpperCase() ,style: TextStyle(color: Colors.black, fontSize: 30.0),),
              backgroundImage:NetworkImage(
                snapshot.data[index].picture
                    
              )
            ),

            title: Text(snapshot.data[index].guid) ,
            onTap: () {
            _showTap(context, snapshot.data[index].guid)
            }

          );
        });
      }

    },
    )
)

    );
  }
  Widget getDate(int date, String day){
    return AnimatedContainer(duration: Duration(milliseconds: 100),
    curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),color:switchColor(date)
      ),
      width: 60.0,
      height: 60.0,
      child:InkWell(
        onTap: (){
          selectDate(date);
        },
        child: Center(
          child: Column(
            children: <Widget>[
               SizedBox(height: 9.0,),
              Text(date.toString(),style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: ContentColor(date)
              ),),

               Text(day.toString(),style: TextStyle(
                   fontSize: 15.0,

                   color: ContentColor(date)
               ),),
            ],
          ),
        ),
      ) ,
    );

  }
  selectDate(date){
    setState(() {
      seleted = date;
    });
  }
 Color switchColor(date){

    if(date == seleted){
      return Colors.black.withOpacity(0.8);
    }
    else{
      return Colors.grey.withOpacity(0.2);
    }
  }

  Color  ContentColor(date){
    if(date == seleted){
      return Colors.white;
    }
    else{
      return Colors.black;
    }
  }
void _showTap(BuildContext context, String message){
  var alert = new AlertDialog(
    title: new Text("tap"),
    content: new Text(message),
    actions: <Widget>[
      FlatButton(onPressed: (){Navigator.pop(context);},child:
        Icon(Icons.close)
        ,)
    ],
  );
  showDialog(context: context, builder: (context)=>alert);
}


}


import 'package:flutter/material.dart';



class SeeCommandAviable extends StatefulWidget {

  const SeeCommandAviable({Key? Key}): super(key:Key);
  @override
  _SeeCommandAviableState createState() => _SeeCommandAviableState();
}

class _SeeCommandAviableState extends State<SeeCommandAviable>{
  late int i=1;
  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Command List"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search),),
        ],

      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/Vector.jpg"),fit: BoxFit.fill,),

        ),

        child:Container(

          child:  ListView(
          children: [

            CommandListItem(

              size: "\nExtra Large \n",
              weight: "12"+" kg \n",
              description:"solid \n",
              Location :"from"+" xxx "+"to"+" yyy \n",
              phone: 0663235148,

            ),
            SizedBox(height: 15,),
            CommandListItem(
              size: "\nLarge \n",
              weight: " 9 "+"kg \n",
              description:"solid \n",
              Location :"from"+" xxx "+"to"+" zzz \n",
              phone: 0663235148,

            )
          ],
        ),
        ),
      ),
    );
  }
}

class CommandListItem extends StatelessWidget {
  final String size;
  final String weight;
  final String description;
  final String Location;
  final int phone;

  const CommandListItem({
    Key? key,
    required this.size,
    required this.weight,
    required this.description,
    required this.Location,
    required this.phone,


}): super(key: key);



  @override
  Widget build(BuildContext context){
    return Container(decoration: BoxDecoration(
      border: Border.all(color: Colors.purpleAccent,width: 0.05,style: BorderStyle.solid,),
      color: Colors.white54,
      borderRadius: BorderRadius.all(Radius.elliptical(25, 50)),
      shape: BoxShape.rectangle,
    ), child: ListTile(
      title: Text("Command  \n Details :"+size+weight+description+Location+'0'+phone.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_task,color: Colors.green,),),
          IconButton(onPressed: (){}, icon: Icon(Icons.block,color: Colors.red,),),
        ],
      ),
    ),
    );
  }
}



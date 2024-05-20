import 'package:flutter/material.dart';
class CommandScreen extends StatefulWidget{
  const CommandScreen({Key? key}):super(key: key);
  @override
  _CommandScreenState createState() => _CommandScreenState();
}
class _CommandScreenState extends State<CommandScreen>{
  final GlobalKey<FormState> _formkey = GlobalKey<
      FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Command"),
      ),
      body:  SafeArea(

        child: Form(

          key: _formkey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/Vector.jpg"),fit: BoxFit.fill),
            ),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(children: <Widget>[
                    Text("Command",
                      style: TextStyle(
                        fontSize: 30,fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 17,),
                    Text("Let's make your order here !",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                  ]
                  ),
                  Column(
                    children: <Widget>[
                      inputFile(label: "Size", hint: "Enter the size"),
                      inputFile(label: "Weight", hint: "Enter the weight"),
                      inputFile(label: "Description", hint: "Enter the description "),
                      SizedBox(height:30),
                      MaterialButton(onPressed: (){

                      },
                        minWidth: double.infinity,
                        height: 60,
                        elevation: 1,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text("Create",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,),),

                      ),
                    ],
                  )
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}


Widget inputFile({
  required String label,
  required String hint,
  TextEditingController? controller,
  bool obscureText = false,

}){
  return Padding(
    padding: const  EdgeInsets.symmetric(vertical: 5.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black87,),

        ),
        SizedBox(height: 5,),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value){
            if(label=="Size"){
              if(value==null || value.isEmpty || value !="Extra large" || value != "Medium" || value != "Small" ){
                return "Select one of this options Extra large or Large or Medium or Small";
              }
            }
            else if (label=="Weight"){
              if(value==null || value.isEmpty || int.tryParse(value)==null){
                return "Entre the weight please !";
              }
            }
            else if (label=="Description"){
              if(value==null || value.isEmpty){
                return "Entre a description about your order please !";
              }
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            labelText:  hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType:  label=="Weight" ? TextInputType.number : TextInputType.text,textInputAction: TextInputAction.next,
        )
      ],
    ),
  );
}



  import 'package:flutter/material.dart';

class EditVehicleInfoScreen extends StatefulWidget {
  @override
  _EditVehicleInfoScreenState createState() => _EditVehicleInfoScreenState();
  }

  class _EditVehicleInfoScreenState extends State<EditVehicleInfoScreen> {
    final _vehicleMatriculeController = TextEditingController();
    final _vehicleModelController = TextEditingController();
    final _vehicleMaxSizeController = TextEditingController();
    final _vehicleColorController = TextEditingController();
    final _vehicleMaxWeightController =TextEditingController();
    final _vehicleTypeController = TextEditingController();
    @override
    void dispose() {
      _vehicleMatriculeController.dispose();
      _vehicleTypeController.dispose();
      _vehicleModelController.dispose();
      _vehicleMaxSizeController.dispose();
      _vehicleMaxWeightController.dispose();
      _vehicleColorController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        appBar: AppBar(
          title: Text('Edit Vehicle Information'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Vector.jpg"),fit: BoxFit.fill,),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _vehicleMatriculeController,
                decoration: InputDecoration(labelText: 'Matricule'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _vehicleTypeController,
                decoration: InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: _vehicleColorController,
                decoration: InputDecoration(labelText: 'Color'),
              ),
              TextField(
                controller: _vehicleModelController,
                decoration: InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: _vehicleMaxSizeController,
                decoration: InputDecoration(labelText: 'Max size'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _vehicleMaxWeightController,
                decoration: InputDecoration(labelText: 'Max weight'),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  // Save the updated vehicle information to your database or state management
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(
                        'Vehicle information updated successfully')),
                  );
                  Navigator.pop(context);
                },

                child: Text('Save',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),

                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  backgroundColor: Colors.deepOrange,
                  side: BorderSide(color: Colors.transparent),
                  shadowColor: Colors.black,
                ),
              ),

            ],
          ),
        ),
      );
    }
  }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key});

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  File? selectedImage;

  bool isFormFilled()
  {
    return serviceNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        imageController.text.isNotEmpty;
  }

  Future<void>pickImage()async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if(pickedFile != null)
      {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
      else{
        print('NO IMAGE SELECTED');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Service Registration'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            TextField(
              controller: serviceNameController,
              decoration: const InputDecoration(
                hintText: 'Service Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: descriptionController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            
            Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                pickImage();
                },
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20.0),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                ),
              onPressed:
                  () {
                        if(isFormFilled())
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form submitted successfully!'),
                            ),
                          );
                      }
                    },
              child: const Text('Done', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),
          ],
        ),
      ),
    );
  }
}

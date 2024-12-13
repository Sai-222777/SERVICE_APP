import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:service/storage_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}



class _CartPageState extends State<CartPage> {

  late String userNumber;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final addressController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();


  int pressed = 0;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pressed = 0;
    loading = false;
  }
  
  @override
  Widget build(BuildContext context) {
    final width =  MediaQuery.sizeOf(context).width;
    final height =  MediaQuery.sizeOf(context).height;
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: cartProvider.services.isEmpty ?
                  Center(
                      child: Container(
                        padding: EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'No Services Added',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ) : 
              ListView.builder(
                itemCount: cartProvider.services.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(cartProvider.services[index]),
                    trailing: IconButton(
                      onPressed: (){
                        cartProvider.removeService(index);
                      }, 
                      icon: Icon(
                        Icons.delete
                        )
                      ),
                  );
                }
                ),
            ),
            ElevatedButton(
              onPressed: () async {
                if(cartProvider.services.isEmpty)
                {
                  return;
                }
                userNumber = (await StorageService.getNumber())!;
                // DocumentSnapshot doc2 = await _firebaseFirestore.collection('USERS').doc('7893632039').get();
                // String token = doc2['FCMToken'];
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context, builder: (context)
                    {
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom
                        ),
                        child: SizedBox(
                          height: height/1.8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                AppBar(
                                  title: Text('SET ADDRESS'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: buildingController,
                                    maxLength: 20,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Building',
                                      counterText: ''
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: streetController,
                                    maxLength: 20,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Street',
                                      counterText: ''
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: areaController,
                                    maxLength: 20,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Area',
                                      counterText: ''
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: cityController,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'City',
                                      counterText: ''
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      // if(pressed == 0 && addressController.text.length >= 15)
                                      // {
                                      //   setState(() {
                                      //     loading = true;
                                      //   });
                                      //   DateTime now = DateTime.now();
                                      //   pressed = 1;
                                      //   await _firebaseFirestore.collection('DistributionService')
                                      //     .doc('Requests')
                                      //     .update({
                                      //       'requests': FieldValue.arrayUnion([
                                      //         {
                                      //           'user': userNumber,
                                      //           'services': cartProvider.services,
                                      //           'address' : addressController.text,
                                      //           'requestTime': '${now.day}-${now.month}-${now.year}--${now.hour}:${now.minute}'
                                      //         }
                                      //       ])
                                      //     });
                                      //     await _firebaseFirestore.collection('USERS').
                                      //       doc(userNumber).set(
                                      //         {
                                      //           'Currently' : 1,
                                      //           'CurrentRequest' : {
                                      //             'services': cartProvider.services,
                                      //             'address' : addressController.text,
                                      //             'status' : 'yet to confirm',
                                      //           }
                                      //         }, SetOptions(merge: true)
                                      //       );
                                      //     setState((){
                                      //       loading = false;
                                      //     });
                                      //     cartProvider.services = [];
                                      //     Navigator.pop(context);
                                      //     showDialog(
                                      //       context: context,
                                      //       builder: (BuildContext context) {
                                      //         return AlertDialog(
                                      //           title: const Text('Service Requested'),
                                      //           content: const Text('Please wait for confirmation'),
                                      //           actions: <Widget>[
                                      //             TextButton(
                                      //               onPressed: () {
                                      //                 Navigator.pop(context); // Close the dialog
                                      //               },
                                      //               child: const Text('OK'),
                                      //             ),
                                      //           ],
                                      //         );
                                      //         }
                                      //       );
                                      // }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      maximumSize: Size(width, height/12), 
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,                 
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8), 
                                      ),
                                    ),
                                    child: Center(
                                      child: loading ?
                                      const SizedBox(
                                        height: 20,
                                        child: CircularProgressIndicator(color: Colors.white,)
                                        ) :
                                      const Text(
                                        'CONFIRM',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
              },
              style: ElevatedButton.styleFrom(
                maximumSize: Size(width, height/12), 
                backgroundColor: Colors.blue,      
                foregroundColor: Colors.white,           
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),
              ),
              child: const Center(
                child: Text(
                  'REQUEST',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
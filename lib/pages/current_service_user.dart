import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service/storage_service.dart';

class CurrentServiceUser extends StatelessWidget {
  const CurrentServiceUser({super.key});

  Future<Map<String,dynamic>> fetchCurrentOrder() async
  {
    String userNumber = (await StorageService.getNumber())!;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('USERS').doc(userNumber).get();
    return Map<String,dynamic>.from(doc['CurrentRequest']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: Text(
              'CURRENTLY'
            ),
          ),
          FutureBuilder<Map<String,dynamic>>(
            future: fetchCurrentOrder(), 
            builder: (BuildContext context,snapshot)
            {
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator(color: Colors.blue.shade800));
              }
              else if(!snapshot.hasData || snapshot.data!.isEmpty || snapshot.hasError) 
              {
                return Column(
                  children: [
                    SizedBox(height: 50,),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'No Services Requested',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              }
              else
              {
                final request = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: request['services']!.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0), 
                            ),
                            padding: EdgeInsets.all(16), 
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                              Center(child: Text('${request['services']![index]}', textAlign: TextAlign.right,)),
                              SizedBox(height: 8),
                              Center(child: Text('Status: ${request['status']}')),
                              SizedBox(height: 8), 
                              Center(child: Text('Address: ${request['address']}')),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                );
              }
            }
          ),
          SizedBox(height: 40,),
          Center(
            child: Text(
              'PAST SERVICES'
            ),
          ),
        ],
      ),
    );
  }
}
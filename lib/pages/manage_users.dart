import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {

// Future <List<String>> fetchCurrentOrder() async
//   {
//     DocumentSnapshot doc = await FirebaseFirestore.instance.collection('DistributionService').doc('About').get();
//     return List<String>.from(doc['Numbers']);
//   }

final List<Map<String,String>> users = [
  {
    'Name' : 'Sai',
    'UserNo' : '1234567890',
    'Email' : 'saosao@gamil.com',
    'Pincode' : '678002',
    'Address' : 'asdrdwfghj',
    'Role'    : 'User',
  },
  {
    'Name' : 'Srjir',
    'UserNo' : '1234567320',
    'Email' : 'saosao@gamil.com',
    'Pincode' : '678002',
    'Address' : 'asdrdwfghj',
    'Role'    : 'Distributor',
  },
  {
    'Name' : 'Sdhuri',
    'UserNo' : '1244567890',
    'Email' : 'saos@gamil.com',
    'Pincode' : '678002',
    'Address' : 'asdrdwfghj',
    'Role'    : 'User',
  },
  {
    'Name' : 'Sdhuri',
    'UserNo' : '1244567890',
    'Email' : 'saos@gamil.com',
    'Pincode' : '678002',
    'Address' : 'asdrdwfghj',
    'Role'    : 'Admin',
  }
];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('ALL USERS'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          if(users.isEmpty) 
                Column(
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
                          'Unable to load',
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
              ),
              if(users.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: users.length,
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
                            children: [
                              Text('Name: ${users[index]['Name']!}'),
                              Text('Number: ${users[index]['UserNo']!}'),
                              Text('Email: ${users[index]['Email']!}'),
                              Text('Pincode: ${users[index]['Pincode']!}'),
                              Text('Address: ${users[index]['Address']!}'),
                              Text('Role: ${users[index]['Role']!}'),
                              if(users[index]['Role'] == 'User')
                                Row(
                                  children: [
                                    Text('CONVERT TO: '),
                                    ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          users[index]['Role'] = 'Distributor';
                                        });
                                      }, 
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, 
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                      ),
                                      child: Text('DISTRIBUTOR', style: TextStyle(fontSize: 12),)
                                    )
                                  ],
                                ),
                              if(users[index]['Role'] == 'Distributor')
                                Row(
                                  children: [
                                    Text('CONVERT TO: '),
                                    ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          users[index]['Role'] = 'User';
                                        });
                                      }, 
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, 
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                      ),
                                      child: Text('USER', style: TextStyle(fontSize: 12),)
                                    ),
                                    SizedBox(width: 10,),
                                    ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          users[index]['Role'] = 'Admin';
                                        });
                                      }, 
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, 
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                      ),
                                      child: Text('ADMIN', style: TextStyle(fontSize: 12),)
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({super.key});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {

  final List<Map<String,String>> orders = [
    {
      'Service' : 'Laundry',
      'Address' : 'i3eo3ru4trhfiej',
      'UserNo' :  '9999917828' 
    },
    {
      'Service' : 'Laundry2',
      'Address' : 'i3eo3ru4trhfiej',
      'UserNo' :  '9999917828' 
    },
    {
      'Service' : 'Laundry4',
      'Address' : 'i3eo3ru4trhfiej',
      'UserNo' :  '9999917828' 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Pending Requests',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children:
                          [
                            SizedBox(height: 8,),
                            Text(orders[index]['Service']!),
                            SizedBox(height: 8,),
                            Text('Status: ${orders[index]['Address']!}'),
                            SizedBox(height: 8,),
                            Text('UserNo: ${orders[index]['UserNo']!}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: (){
                                    setState(() {
                                      orders.removeAt(index);
                                    });
                                  }, 
                                  child: Text('Decline'),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                    },
                                    child: Text('Accept'),
                                  )
                              ],
                            )
                          ]
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

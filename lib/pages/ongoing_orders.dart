import 'package:flutter/material.dart';
import 'package:service/pages/order_detail.dart';

class OngoingOrders extends StatefulWidget {
  const OngoingOrders({super.key});

  @override
  State<OngoingOrders> createState() => _OngoingOrdersState();
}

class _OngoingOrdersState extends State<OngoingOrders> {
  
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
                'Ongoing Services',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                    padding: EdgeInsets.all(16), 
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            Center(child: Text(orders[index]['Service']!, textAlign: TextAlign.right,)),
                            SizedBox(height: 8),
                            Center(child: Text('Address : ${orders[index]['Address']!}')),
                            SizedBox(height: 8), 
                            Center(child: Text('UserNo: ${orders[index]['UserNo']!}')),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => OrderDetail(
                                  service: orders[index]['Service']!,
                                  address: orders[index]['Address']!,
                                  userNo: orders[index]['UserNo']!,
                                  )
                                )
                              );
                          }, 
                          icon: Icon(Icons.arrow_forward)
                          )
                      ],
                    ),
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

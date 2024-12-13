import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final String service, address, userNo;
  const OrderDetail({super.key, required this.service, required this.address, required this.userNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Order Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const Divider(),
          SizedBox(height: 10,),
          Text('Service : $service'),
          SizedBox(height: 10,),
          Text('Address : $address'),
          SizedBox(height: 10,),
          Text('User Num : $userNo'),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/1.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                ),
                onPressed: () 
                {
                },
                child: Text(
                  'Order Completed',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
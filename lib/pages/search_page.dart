import 'dart:async';

import 'package:flutter/material.dart';
import 'package:service/pages/cart_page.dart';
import 'package:service/pages/current_service_user.dart';
import 'package:service/pages/service_page.dart';
import 'package:provider/provider.dart';
import 'package:service/search_provider.dart';

class SearchPage extends StatefulWidget {
  final bool loggedIn;
   const SearchPage({super.key, required this.loggedIn});


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  final TextEditingController textEditingController = TextEditingController();

  Timer? _debounce;



  @override
  void initState() {
    super.initState();
    _onSearchChanged('');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query)
  {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      searchProvider.filter(query);
    });
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.sizeOf(context);
    // final double width = size.width;
    final double height = size.height;

    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Search Page'),
        actions: [
           if (widget.loggedIn)
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () 
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentServiceUser()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text("CURRENT"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                onChanged: _onSearchChanged,
                // (query){
                //   searchProvider.filterItems(query);
                // },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(16)
                  )
                ),
              ),
              SizedBox(height: height/15,),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: searchProvider.filteredServices.length, 
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: () {
                        if(widget.loggedIn)
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ServicePage(serviceName: searchProvider.filteredServices[index])));
                        }
                        else
                        {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Not Logged In'),
                              content: const Text('Please login to access the service.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                            }
                          );
                      }
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.miscellaneous_services,
                              size: 40,
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              searchProvider.filteredServices[index],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                )
            ],
          ),
        ),
      ),
      floatingActionButton: widget.loggedIn ? FloatingActionButton(
        onPressed:() 
        { 
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
        },
        child: Icon(Icons.shopping_cart),
      ) : null,  
    );
  }
}
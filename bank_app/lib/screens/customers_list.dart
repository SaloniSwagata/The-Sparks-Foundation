import 'package:bank_app/screens/customer_details.dart';
import 'package:flutter/material.dart';

import '../model/customer.dart';
import '../widgets/customerListCard.dart';


class CustomersList extends StatefulWidget {
  static const routeNamed = '/customer_list';

  @override
  _CustomersListState createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {

  @override
  Widget build(BuildContext context) {
    var query = ModalRoute.of(context).settings.arguments as List<Customer>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.teal, title: Text('View All Customers'),),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: (query.length <= 1) ? Text('No Customer to show') : 
            ListView.builder(itemBuilder: (ctx, i) {
              if(i>0){return CustomerListCard(id: query[i].id,title: query[i].name, navpage: () {
                Navigator.of(context).pushNamed(CustomerDetailsScreen.routeNamed, arguments: [query[i].id,query[i].name, query[i].balance] );
              },);}
              else {return SizedBox(height: 10,);}
            }, itemCount: query.length,),
          ),
          )));
  }
}
import 'package:bank_app/model/customer.dart';
import 'package:flutter/material.dart';

import '../dbHelper.dart';


class NewTransaction extends StatefulWidget {
  final int customerId;
  final String customerName;
  final double customerBalance;


  NewTransaction({this.customerId,this.customerName,this.customerBalance});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController= TextEditingController();

  void submit() async
  {
    var cb;
    final subamt= double.parse(amountController.text);
    if(subamt <=0)
    {
      return;
    }
    cb = widget.customerBalance + subamt;

    DBHelper db =  DBHelper();
    var query = await db.getCustomer();
    var admin = query[0];
    admin.balance= admin.balance - subamt;

    Customer customer = new Customer(id: widget.customerId, name: widget.customerName, balance: cb);
    Customer adminu = new Customer(id: admin.id, name: admin.name, balance: admin.balance);

    db.update(customer);
    db.update(adminu);

    Navigator.of(context).pushReplacementNamed('/');
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
                ),

              RaisedButton(
                onPressed: submit,
                color: Colors.indigoAccent,
                child: Text("Make Transfer", style: TextStyle(fontWeight: FontWeight.bold,),),
                textColor: Colors.white,)
                ],
                ),
                ),
      ),
              );
  }
}
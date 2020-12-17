import 'package:flutter/material.dart';

import '../dbHelper.dart';

class CustomerListCard extends StatefulWidget
{
  final int id;
  final String title;
  final IconData icon;
  final Function navpage;

  CustomerListCard({this.id, this.icon = Icons.account_circle,this.title, this.navpage});

  @override
  _CustomerListCardState createState() => _CustomerListCardState();
}

class _CustomerListCardState extends State<CustomerListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      child: Card(
        color: Colors.teal,
        child: ListTile(contentPadding: EdgeInsets.all(10),
          leading: Icon(
            widget.icon,
            color: Colors.white,
            size: 40,
          ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete), onPressed: () async {
            DBHelper db =  DBHelper();
            await db.delete(widget.id);
            },
        ),
        onTap: widget.navpage,
        ),
      ),
    );
  }
}
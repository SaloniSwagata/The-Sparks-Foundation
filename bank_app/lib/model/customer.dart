class Customer{
  int id;
  String name;
  double balance;

  Customer({this.id, this.name, this.balance = 10000.0 });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'balance': balance,
    };
    return map;
  }

  Customer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    balance = map['balance'];
  }


}
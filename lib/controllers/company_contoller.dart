import 'dart:convert';

import 'package:homework_44/models/company.dart';

class CompanyContoller {
  final List<Company> _list = [];

  List<Company> get list {
    return [..._list];
  }

  void getProducts() {
    const String url = '''
      {
        "company": "Tech Solutions",
        "location": "San Francisco",
        "employees": [
          {
            "name": "Alice",
            "age": 30,
            "position": "Developer",
            "skills": ["Dart", "Flutter", "Firebase"]
          },
          {
            "name": "Bob",
            "age": 25,
            "position": "Designer",
            "skills": ["Photoshop", "Illustrator"]
          }
        ],
        "products": [
          {"name": "Product A", "price": 29.99, "inStock": true},
          {"name": "Product B", "price": 49.99, "inStock": false}
        ]
      }
     ''';
    Map<String, dynamic> data = jsonDecode(url);

    _list.add(Company.fromJson(data));
    // print(_list[0].products);
  }
}


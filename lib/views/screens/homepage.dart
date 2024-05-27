import 'package:flutter/material.dart';
import 'package:homework_44/controllers/company_contoller.dart';
import 'package:homework_44/views/widgets/company_widgets.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final _controller = CompanyContoller();

  @override
  void initState() {
    super.initState();
    _controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final data = _controller.list[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
        title: const Text(
          "Information",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CompanyWidgets(name: data.company, title: "Company:"),
                    const SizedBox(
                      height: 20,
                    ),
                    CompanyWidgets(name: data.location, title: "Location:"),
                  ],
                ),
              ),
            ),
            const Text(
              "Emlpoyees",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.employees.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name: ${data.employees[i].name}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Name: ${data.employees[i].age}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Name: ${data.employees[i].position}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Skills",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1),
                          ),
                          const Divider(
                            color: Colors.purple,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (var i in data.employees[i].skills)
                                Text(
                                  i,
                                  style: TextStyle(
                                      color: Colors.purple.shade400,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.grey,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Edit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Delete",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(child: Column(children: [],),);
              },
            ))
          ],
        ),
      ),
    );
  }
}

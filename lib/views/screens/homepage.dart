import 'package:flutter/material.dart';
import 'package:homework_44/controllers/company_contoller.dart';
import 'package:homework_44/models/employee.dart';
import 'package:homework_44/views/widgets/company_widgets.dart';
import 'package:homework_44/views/widgets/skills_widget.dart';
import 'package:http/http.dart';

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
                  return SkillsWidget(
                    onDdeleted: _deleteEmployee,
                    onEdited: _editEmployee,
                    data: data,
                    i: i,
                  );
                },
              ),
            ),
            const Text(
              "Products",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.products.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: Text("${data.products[i].name}")),
                          Expanded(child: Text("${data.products[i].price}\$"))
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.edit),
                          IconButton(
                            onPressed: () {
                              return setState(() {
                                _controller.deleteProduct(i);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEmployee,
        backgroundColor: Colors.blue.shade400,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _editEmployee(int index) {
    final employee = _controller.list[0].employees[index];
    TextEditingController nameController =
        TextEditingController(text: employee.name);
    TextEditingController ageController =
        TextEditingController(text: employee.age.toString());
    TextEditingController positionController =
        TextEditingController(text: employee.position);
    TextEditingController skillsController =
        TextEditingController(text: employee.skills.join(', '));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Employee',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(nameController, 'Name'),
                _buildTextField(ageController, 'Age', TextInputType.number),
                _buildTextField(positionController, 'Position'),
                _buildTextField(skillsController, 'Skills (comma separated)'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final newEmployee = Employee(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            position: positionController.text,
                            skills: skillsController.text
                                .split(',')
                                .map((skill) => skill.trim())
                                .toList(),
                          );
                          _controller.addEmployee(newEmployee);
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteEmployee(int index) {
    setState(() {
      _controller.deleteEmployee(index);
    });
  }

  void _addEmployee() {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController skillsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Employee',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(nameController, 'Name'),
                  _buildTextField(ageController, 'Age', TextInputType.number),
                  _buildTextField(positionController, 'Position'),
                  _buildTextField(skillsController, 'Skills (comma separated)'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final newEmployee = Employee(
                              name: nameController.text,
                              age: int.parse(ageController.text),
                              position: positionController.text,
                              skills: skillsController.text
                                  .split(',')
                                  .map((skill) => skill.trim())
                                  .toList(),
                            );
                            _controller.addEmployee(newEmployee);
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

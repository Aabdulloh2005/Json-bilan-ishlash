import 'package:flutter/material.dart';
import 'package:homework_44/models/company.dart';

class SkillsWidget extends StatelessWidget {
  Function onEdited;
  Function onDdeleted;
  Company data;
  int i;
  SkillsWidget(
      {required this.onEdited,
      required this.onDdeleted,
      required this.data,
      required this.i,
      super.key});

  @override
  Widget build(BuildContext context) {
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
                  "Age: ${data.employees[i].age}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Position: ${data.employees[i].position}",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onEdited(i);
                    },
                    child: const Card(
                      color: Colors.grey,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Edit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onDdeleted(i);
                    },
                    child: const Card(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Delete",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
  }
}

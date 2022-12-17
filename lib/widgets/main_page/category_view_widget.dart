import 'package:flutter/material.dart';

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Название категории"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      margin: const EdgeInsets.all(1.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 35,
                        ),
                      ),
                    ),
                    title: Text(
                      "Комментарий категории",
                      style: TextStyle(
                        color: Color.fromARGB(255, 83, 83, 83),
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                      "10\$",
                      style: TextStyle(
                        color: Color.fromARGB(255, 83, 83, 83),
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 1.5,
                    height: 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

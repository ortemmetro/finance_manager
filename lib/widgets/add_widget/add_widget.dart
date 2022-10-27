import 'package:flutter/material.dart';

class AddWidget extends StatelessWidget {
  const AddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 45),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      height: 10,
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('KZT'),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const [
                    Text('Категории'),
                  ],
                ),
              ),
              SizedBox(
                height: 125,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const SizedBox(width: 75, height: 75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text('Семья'),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {},
                //async {
                //   DateTime? newDate = await showDatePicker(
                //     context: context,
                //     initialDate: DateTime(2022, 10, 27),
                //     firstDate: DateTime(1900),
                //     lastDate: DateTime(2023),
                //   );
                // },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: const Text('Выбрать дату'),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const [
                    Text('Комментарий'),
                  ],
                ),
              ),
              const SizedBox(
                width: 367,
                child: TextField(),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Добавить',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

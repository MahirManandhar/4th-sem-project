import 'package:flutter/material.dart';

class AdminBus extends StatefulWidget {
  const AdminBus({super.key});

  @override
  State<AdminBus> createState() => _AdminBusState();
}

class _AdminBusState extends State<AdminBus> {
  String dropdownvalue = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              height: 425,
              color: Colors.grey,
              child: const Center(child: Text('Map')),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
              const Text('Select your bus:'),
              const SizedBox(
                width: 35,
              ),
              DropdownButton(
                  value: 'A',
                  items: const [
                    DropdownMenuItem(value: 'A', child: Text('A')),
                    DropdownMenuItem(value: 'B', child: Text('B')),
                    DropdownMenuItem(value: 'C', child: Text('C')),
                    DropdownMenuItem(value: 'D', child: Text('D')),
                    DropdownMenuItem(value: 'E', child: Text('E')),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  }),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on),
              label: const Text('Track'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

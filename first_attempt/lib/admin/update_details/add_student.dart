import 'package:flutter/material.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Text('PATHSHALA'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Stack(
            children: [
              const Center(
                child: Text(
                  '+ ADD STUDENT',
                  style: TextStyle(color: Colors.black54, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 70,
                    ),
                    Positioned(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 220, horizontal: 15),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your UserId";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'UserId',
                          hintText: 'Enter your UserId',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your middle name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Middle Name',
                          hintText: 'Enter your middle name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your last name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter your last name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your class";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Class',
                          hintText: 'Enter your Class',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your roll no.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Roll no.',
                          hintText: 'Enter your roll no.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please enter your phone no.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Phone no.',
                          hintText: 'Enter your phone no.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add_alt_rounded),
                        label: const Text('ADD'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateFee extends StatefulWidget {
  const UpdateFee({super.key});

  @override
  UpdateFeeState createState() => UpdateFeeState();
}

class UpdateFeeState extends State<UpdateFee> {
  String? selectedClass;
  TextEditingController examFeesController = TextEditingController();
  TextEditingController tuitionFeesController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];
  List<String> ecaOptions = [];
  Map<String, List<String>> selectedEcasForStudents = {};
  TextEditingController newEcaController = TextEditingController();
  TextEditingController ecaFeeController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  Map<String, int> ecaFees = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Update Fees',
            style: TextStyle(color: Colors.black54, fontSize: 30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: selectedClass,
                        hint: const Text('Select Class'),
                        onChanged: (value) async {
                          setState(() {
                            selectedClass = value!;
                            _loadExamAndTuitionFees();
                            _loadStudentList();
                            _loadEcaOptions();
                          });
                        },
                        items: [
                          'LKG',
                          'UKG',
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10'
                        ].map((String? value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value ?? ''),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              buildTextField('Exam Fees', examFeesController),
              const SizedBox(height: 20),
              buildTextField('Tuition Fees', tuitionFeesController),
              const SizedBox(height: 20),
              buildEcaList(),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              TextField(
                controller: deadlineController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Total Fees Deadline (yyyy-MM-dd)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateFeesInDatabase();
        },
        child: const Text('Update'),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget buildEcaList() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ECA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: ecaOptions.map((String eca) {
                return ListTile(
                  title: Text(eca),
                  subtitle: Text('Fee: Rs. ${ecaFees[eca]}'),
                  onTap: () {
                    _showStudentEcaPopup(eca);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteEca(eca);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: newEcaController,
                  decoration: InputDecoration(
                    labelText: 'New ECA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: ecaFeeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ECA Fee',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addNewEca,
                child: const Text('Add ECA'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteEca(String eca) {
    setState(() {
      ecaOptions.remove(eca);
      ecaFees.remove(eca);
    });
  }

  void _addNewEca() {
    String newEca = newEcaController.text.trim();
    String fee = ecaFeeController.text.trim();

    if (newEca.isNotEmpty && fee.isNotEmpty) {
      setState(() {
        ecaOptions.add(newEca);
        ecaFees[newEca] = int.parse(fee);
      });

      //clear fields for next additionnnn
      newEcaController.clear();
      ecaFeeController.clear();
    }
  }

  void _loadEcaOptions() async {
    if (selectedClass != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Fees')
          .doc(selectedClass)
          .collection('ECAs')
          .doc('activities') // Assuming 'activities' is the document ID
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> ecaData =
            documentSnapshot.data() as Map<String, dynamic>;

        if (ecaData.containsKey('activities')) {
          List<dynamic> ecaList = ecaData['activities'] ?? [];

          setState(() {
            ecaOptions = ecaList.map((eca) => eca as String).toList();

            // Navigate to the nested 'fees' field
            Map<String, dynamic>? nestedFees =
                ecaData['fees'] as Map<String, dynamic>?;

            // Check for nested 'fees' field existence
            if (nestedFees != null) {
              ecaFees = Map.fromEntries(
                nestedFees.entries
                    .map((entry) => MapEntry(entry.key, entry.value as int)),
              );
            } else {
              // Handle the case where 'fees' is null or not available
              ecaFees = {};
            }
          });
        } else {
          setState(() {
            ecaOptions = [];
            ecaFees = {};
          });
        }
      } else {
        setState(() {
          ecaOptions = [];
          ecaFees = {};
        });
      }
    }
  }

  void _loadExamAndTuitionFees() async {
    if (selectedClass != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Fees')
          .doc(selectedClass)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          examFeesController.text = documentSnapshot['exam fees'].toString();
          tuitionFeesController.text =
              documentSnapshot['tuition fees'].toString();
          deadlineController.text = documentSnapshot['deadline'].toString();
        });
      } else {
        setState(() {
          examFeesController.text = '';
          tuitionFeesController.text = '';
          deadlineController.text = '';
        });
      }
    }
  }

  void _loadStudentList() async {
    try {
      if (selectedClass != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Students')
            .doc(selectedClass)
            .collection('students')
            .get();

        setState(() {
          studentList = querySnapshot.docs
              .map((doc) => {
                    'name': '${doc['fn']} ${doc['mn']} ${doc['ln']}',
                    'email': doc.id, //email ni store garne
                  })
              .toList();
        });
      }
    } catch (e) {
      print('Error loading student list: $e');
    }
  }

  void _showStudentEcaPopup(String eca) {
    showDialog(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
          title: Text('Students in $eca'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: studentList.map((student) {
                  return Row(
                    children: [
                      Checkbox(
                        value: selectedEcasForStudents[student['name']]
                                ?.contains(eca) ??
                            false,
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              if (selectedEcasForStudents[student['name']] ==
                                  null) {
                                selectedEcasForStudents[student['name']] = [
                                  eca
                                ];
                              } else {
                                selectedEcasForStudents[student['name']]
                                    ?.add(eca);
                              }
                            } else {
                              selectedEcasForStudents[student['name']]
                                  ?.remove(eca);
                              if (selectedEcasForStudents[student['name']]
                                      ?.isEmpty ??
                                  false) {
                                selectedEcasForStudents.remove(student['name']);
                              }
                            }
                          });
                        },
                      ),
                      Text(student['name']),
                    ],
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(alertDialogContext).pop();
                print('Selected ECAs for students: $selectedEcasForStudents');
              },
              child: const Text('Update ECAs'),
            ),
          ],
        );
      },
    );
  }

  void _updateFeesInDatabase() async {
    if (selectedClass != null) {
      // Update exam and tuition fees .. deadline also
      await FirebaseFirestore.instance
          .collection('Fees')
          .doc(selectedClass)
          .set({
        'exam fees': int.tryParse(examFeesController.text) ?? 0,
        'tuition fees': int.tryParse(tuitionFeesController.text) ?? 0,
        'deadline': deadlineController.text.trim()
      });

      print('hiiiiiiiiiiiiiiiiiiiiiiiiiii');

      // Update ECA fees for each student
      for (Map<String, dynamic> student in studentList) {
        String email = student['email']; // Use the stored email
        int totalEcaFees = selectedEcasForStudents[student['name']]?.fold<int>(
                0,
                (previousValue, eca) => previousValue + (ecaFees[eca] ?? 0)) ??
            0;

        int? examFees = int.tryParse(examFeesController.text);
        int? tuitionFees = int.tryParse(tuitionFeesController.text);

        int examFeesValue = examFees ?? 0;
        int tuitionFeesValue = tuitionFees ?? 0;

        num totalFees = examFeesValue + tuitionFeesValue + totalEcaFees;

// int examFees = int.tryParse(examFeesController.text);
// int tuitionFees =int.tryParse(tuitionFeesController.text);
//             num totalFees = examFees + tuitionFees + totalEcaFees;
        // totalFeesController.text = totalFees.toString();

        print('byeeeeeeeeeee');

        // Update fees for each student
        await FirebaseFirestore.instance
            .collection('Fees')
            .doc(selectedClass)
            .collection('Students')
            .doc(email)
            .set({
          'exam fees': int.tryParse(examFeesController.text) ?? 0,
          'tuition fees': int.tryParse(tuitionFeesController.text) ?? 0,
          'deadline': deadlineController.text.trim(),
          'total eca fees': totalEcaFees,
          'activities': selectedEcasForStudents[student['name']] ?? [],
          'fees': ecaFees,
          'total fees': totalFees,
        });
      }

      // eca and fee at class level
      await FirebaseFirestore.instance
          .collection('Fees')
          .doc(selectedClass)
          .collection('ECAs')
          .doc('activities') // Use a specific document ID for ECA activities
          .set({
        'activities': ecaOptions,
        'fees': ecaFees,
      });

      _showFeesUpdatedPopup();
    }
  }

  void _showFeesUpdatedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
          title: const Text('Fees Updated'),
          content: const Text('The fees have been successfully updated.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(alertDialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}




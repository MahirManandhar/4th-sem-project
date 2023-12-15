import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class UpdateFee extends StatefulWidget {
  const UpdateFee({Key? key}) : super(key: key);

  @override
  UpdateFeeState createState() => UpdateFeeState();
}

class UpdateFeeState extends State<UpdateFee> {
  String selectedClass = 'Select Class';
  TextEditingController examFeesController = TextEditingController();
  TextEditingController tuitionFeesController = TextEditingController();
  TextEditingController ecaFeesController = TextEditingController();
  TextEditingController totalFeesController = TextEditingController();
  TextEditingController totalFeesDeadlineController = TextEditingController();

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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
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
                              onChanged: (value) {
                                if (value != 'Select Class') {
                                  setState(() {
                                    selectedClass = value!;
                                    _calculateFees();
                                  });
                                }
                              },
                              items: [
                                'Select Class', // Initial value
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
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: examFeesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Exam Fees',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: tuitionFeesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tuition Fees',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: ecaFeesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ECA Fees',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: totalFeesDeadlineController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'Total Fees Deadline (yyyy-MM-dd)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _showTotalFees(context),
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateFees() {
    int examFees = 0;
    int tuitionFees = 0;

    switch (selectedClass) {
      case 'LKG':
        examFees = 1000000000;
        tuitionFees = 20000000;
        break;
      case 'UKG':
        examFees = 3000000000;
        tuitionFees = 400000000;
        break;
      case '1':
        examFees = 1000;
        tuitionFees = 2000;
        break;
      case '2':
        examFees = 1000;
        tuitionFees = 2000;
        break;
      case '3':
        examFees = 1000;
        tuitionFees = 2000;
        break;
      case '4':
        examFees = 20000;
        tuitionFees = 10000;
        break;
      case '5':
        examFees = 22000;
        tuitionFees = 10000;
        break;
      case '6':
        examFees = 23000;
        tuitionFees = 11000;
        break;
      case '7':
        examFees = 2600;
        tuitionFees = 15000;
        break;
      case '8':
        examFees = 26000;
        tuitionFees = 17000;
        break;
      case '9':
        examFees = 27000;
        tuitionFees = 17000;
        break;
      case '10':
        examFees = 30000;
        tuitionFees = 20000;
        break;
    }

    setState(() {
      examFeesController.text = examFees.toString();
      tuitionFeesController.text = tuitionFees.toString();
    });
  }

  void _showTotalFees(BuildContext context) {
    int examFees = int.tryParse(examFeesController.text) ?? 0;
    int tuitionFees = int.tryParse(tuitionFeesController.text) ?? 0;
    int ecaFees = int.tryParse(ecaFeesController.text) ?? 0;

    num totalFees = examFees + tuitionFees + ecaFees;
// int deadline = int.tryParse(totalFeesDeadlineController.text) ?? 0;
    totalFeesController.text = totalFees.toString();

    showDialog(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
          title: const Text('Total Fees'),
          content: Text('Total Fees for $selectedClass is $totalFees'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(alertDialogContext).pop();
                addFeeDetails(
                  selectedClass,
                  int.parse(examFeesController.text.trim()),
                  int.parse(tuitionFeesController.text.trim()),
                  int.parse(ecaFeesController.text.trim()),
                  int.parse(totalFeesController.text.trim()),
                  totalFeesDeadlineController.text.trim(), // Add Total Fees Deadline
                );
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: UpdateFee(),
  ));
}

Future<void> addFeeDetails(
  String selectedClass, int examFees, int tuitionFees, int ecaFees, int totalFees, String totalFeesDeadline) async {
  // Check if the class already exists
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Fees')
      .where('class', isEqualTo: selectedClass)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    // Update the existing document
    String documentId = querySnapshot.docs.first.id;
    await FirebaseFirestore.instance.collection('Fees').doc(documentId).update({
      'exam fees': examFees,
      'tuition fees': tuitionFees,
      'eca fees': ecaFees,
      'total': totalFees,
      'total fees deadline': totalFeesDeadline, // Update Total Fees Deadline
    });
  } else {
    // Add a new document with the document ID as the class
    await FirebaseFirestore.instance.collection('Fees').doc(selectedClass).set({
      'class': selectedClass,
      'exam fees': examFees,
      'tuition fees': tuitionFees,
      'eca fees': ecaFees,
      'total': totalFees,
      'total fees deadline': totalFeesDeadline, // Add Total Fees Deadline
    });
  }
}

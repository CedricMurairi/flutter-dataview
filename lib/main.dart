import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data View Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Data View Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, Object>> dataValues = [
    {"name": "John", "age": 20, "role": "Student"},
    {"name": "Jane", "age": 30, "role": "Professor"},
    {"name": "William", "age": 40, "role": "Associate Professor"}
  ];

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final roleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: roleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Role',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          if (nameController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              roleController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill all the fields')),
                            );
                            return;
                          }
                          final Map<String, Object> newPerson = {
                            "name": nameController.text,
                            "age": ageController.text,
                            "role": roleController.text
                          };
                          setState(() {
                            dataValues.add(newPerson);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Data added successfully')),
                            );
                          });
                          nameController.clear();
                          ageController.clear();
                          roleController.clear();
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Age',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: <DataRow>[
                for (var i = 0; i < dataValues.length; i++)
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(dataValues[i]["name"].toString())),
                      DataCell(Text(dataValues[i]["age"].toString())),
                      DataCell(Text(dataValues[i]["role"].toString())),
                    ],
                  )
              ],
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

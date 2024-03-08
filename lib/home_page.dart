import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _updateController = TextEditingController();
  //List _country = ["Bangladesh", "India", "Nepal", "Bhutan"];
  Box? _countryBox;
  @override
  void initState() {
    _countryBox = Hive.box("Opi_List");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Hive Practice",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    final userData = _controller.text;
                    _countryBox!.add(userData);
                  },
                  child: Text("ADD DATA")),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: Hive.box("Opi_List").listenable(),
                      builder: (context, box, widget) {
                        return ListView.builder(
                            itemCount: _countryBox?.keys.toList().length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                      _countryBox!.getAt(index).toString()),
                                  trailing: Container(
                                    width: 100,
                                    color: Colors.amber,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (
                                                    context,
                                                  ) {
                                                    return AlertDialog(
                                                      content: Column(
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                _updateController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                _countryBox!.putAt(
                                                                    index,
                                                                    _updateController
                                                                        .text);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  "UpData")),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.remove),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

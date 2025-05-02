import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({super.key});

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {

  Map<String, dynamic> formData= {
  "type": "Card",
  "child": {
    "type": "Column",
    "children": [
      {
        "type": "Text",
        "data": "Main Card"
      },
      {
        "type": "Card",
        "child": {
          "type": "Column",
          "children": [
            {
              "type": "Text",
              "data": "Nested Card Level 2"
            },
            {
              "type": "Card",
              "child": {
                "type": "Column",
                "children": [
                  {
                    "type": "Text",
                    "data": "Nested Card Level 3"
                  },
                  {
                    "type": "TextField",
                    "decoration": {
                      "labelText": "Enter something 2"
                    }
                  },
                  {
                    "type": "TextField",
                    "decoration": {
                      "labelText": "Enter something 2"
                    }
                  },
                  {
                    "type": "TextField",
                    "decoration": {
                      "labelText": "Enter something 3"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    ]
  }
};
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Dynamic Widget Builder")),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: buildDynamicWidget(formData),
    ),
  );
}


Widget buildDynamicWidget(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'Card':
      return Card(
        child: json.containsKey('child')
            ? buildDynamicWidget(json['child'])
            : null,
      );
    case 'Column':
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (json['children'] as List)
            .map<Widget>((child) => buildDynamicWidget(child))
            .toList(),
      );
    case 'Text':
      return Text(json['data'] ?? '');
    case 'TextField':
      return TextField(
        decoration: InputDecoration(
          labelText: json['decoration']?['labelText'],
        ),
      );
    default:
      return SizedBox.shrink(); 
  }
}
}

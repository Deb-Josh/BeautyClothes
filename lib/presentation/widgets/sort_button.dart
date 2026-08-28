import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  final valuesSort = [
    "Aléatoire",
    "A->Z",
    "Z->A",
  ];
  String? selectedSort = "Aléatoire";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(Icons.sort, color: const Color(0xFF0066B9)),

      value: selectedSort,
      onChanged: (valueSort) => setState(() {
        selectedSort = valueSort;
        final state = GoRouterState.of(context);
        final currentParams = {...state.uri.queryParameters};
        
        if(valueSort == "Aléatoire"){
          currentParams.remove("sort");
        }else{
          currentParams["sort"] = "$valueSort";
        }

        context.go(Uri(
          path: state.uri.path,
          queryParameters: currentParams,
        ).toString());
      }),
      items: valuesSort.map((valueSort) =>
        DropdownMenuItem(
          value: valueSort,
          child: Text(valueSort),
        ),
      ).toList(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final valuesFilter = [
    "Tout",
    "women's clothing",
    "men's clothing",
    "electronics",
    "jewelery"
  ];
  String? selectedFilter = "Tout";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(Icons.filter_list, color: const Color(0xFF0066B9)),
      value: selectedFilter,
      onChanged: (valueFilter) => setState(() {
        selectedFilter = valueFilter;
        final state = GoRouterState.of(context);
        final currentParams = {...state.uri.queryParameters};
        
        if(valueFilter == "Tout"){
          currentParams.remove("filter");
        }else{
          currentParams["filter"] = "$valueFilter";
        }

        context.go(Uri(
          path: state.uri.path,
          queryParameters: currentParams,
        ).toString());
      }),
      items: valuesFilter.map((valueFilter) =>
        DropdownMenuItem(
          value: valueFilter,
          child: Text(valueFilter),
        ),
      ).toList(),
    );
  }
}
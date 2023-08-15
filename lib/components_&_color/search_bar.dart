import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';

// class ReusebleSearchBar extends StatefulWidget {
//   final Function(String) onSearch;

//   const ReusebleSearchBar({Key? key, required this.onSearch}) : super(key: key);

//   @override
//   _ReusebleSearchBarState createState() => _ReusebleSearchBarState();
// }

// class _ReusebleSearchBarState extends State<ReusebleSearchBar> {
//   TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: TextField(
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           // border: InputBorder.none,
//           prefixIcon: IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () => widget.onSearch(_searchController.text),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ReusebleSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;

  ReusebleSearchBar({required this.hintText, required this.onChanged});

  @override
  _ReusebleSearchBarState createState() => _ReusebleSearchBarState();
}

class _ReusebleSearchBarState extends State<ReusebleSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // SvgPicture.network(
              //   'https://icons8.com/icon/83218/search',
              //   height: 24,
              //   color: greyColor,
              // ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              const Icon(
                Icons.search,
                size: 25,
                color: greyColor,
              )

              // FaIcon(
              //   FontAwesomeIcons.search,
              //   size: 18,
              //   color: Colors.grey,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

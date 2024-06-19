import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const CustomDropdown(
      {Key? key, required this.initialValue, required this.onChanged})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String dropdownValue;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            child: Container(
              height: 200.0, // Set the height for the scrollable area
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  _buildDropdownItem('12 : 00 A.M.'),
                  //_buildDropdownItem('12 : 30 A.M.'),
                  _buildDropdownItem('01 : 00 A.M.'),
                  //_buildDropdownItem('01 : 30 A.M.'),
                  _buildDropdownItem('02 : 00 A.M.'),
                  //_buildDropdownItem('02 : 30 A.M.'),
                  _buildDropdownItem('03 : 00 A.M.'),
                  //_buildDropdownItem('03 : 30 A.M.'),
                  _buildDropdownItem('04 : 00 A.M.'),
                  // _buildDropdownItem('04 : 30 A.M.'),
                  _buildDropdownItem('05 : 00 A.M.'),
                  //_buildDropdownItem('05 : 30 A.M.'),
                  _buildDropdownItem('06 : 00 A.M.'),
                  //_buildDropdownItem('06 : 30 A.M.'),
                  _buildDropdownItem('07 : 00 A.M.'),
                  // _buildDropdownItem('07 : 30 A.M.'),
                  _buildDropdownItem('08 : 00 A.M.'),
                  // _buildDropdownItem('08 : 30 A.M.'),
                  _buildDropdownItem('09 : 00 A.M.'),
                  //_buildDropdownItem('09 : 30 A.M.'),
                  _buildDropdownItem('10 : 00 A.M.'),
                  // _buildDropdownItem('10 : 30 A.M.'),
                  _buildDropdownItem('11 : 00 A.M.'),
                  // _buildDropdownItem('11 : 30 A.M.'),
                  _buildDropdownItem('12 : 00 P.M.'),
                  // _buildDropdownItem('12 : 30 P.M.'),
                  _buildDropdownItem('01 : 00 P.M.'),
                  // _buildDropdownItem('01 : 30 P.M.'),
                  _buildDropdownItem('02 : 00 P.M.'),
                  // _buildDropdownItem('02 : 30 P.M.'),
                  _buildDropdownItem('03 : 00 P.M.'),
                  // _buildDropdownItem('03 : 30 P.M.'),
                  _buildDropdownItem('04 : 00 P.M.'),
                  // _buildDropdownItem('04 : 30 P.M.'),
                  _buildDropdownItem('05 : 00 P.M.'),
                  // _buildDropdownItem('05 : 30 P.M.'),
                  _buildDropdownItem('06 : 00 P.M.'),
                  // _buildDropdownItem('06 : 30 P.M.'),
                  _buildDropdownItem('07 : 00 P.M.'),
                  // _buildDropdownItem('07 : 30 P.M.'),
                  _buildDropdownItem('08 : 00 P.M.'),
                  // _buildDropdownItem('08 : 30 P.M.'),
                  _buildDropdownItem('09 : 00 P.M.'),
                  // _buildDropdownItem('09 : 30 P.M.'),
                  _buildDropdownItem('10 : 00 P.M.'),
                  // _buildDropdownItem('10 : 30 P.M.'),
                  _buildDropdownItem('11 : 00 P.M.'),
                  // _buildDropdownItem('11 : 30 P.M.'),
                  // Add more items if needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          dropdownValue = value;
          widget.onChanged(value);
        });
        _toggleDropdown();
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: dropdownValue == value ? Colors.grey[600] : Colors.black,
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dropdownValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}

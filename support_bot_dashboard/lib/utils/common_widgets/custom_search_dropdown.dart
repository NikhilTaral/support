import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CustomSearchDropdown extends StatefulWidget {
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String label;
  const CustomSearchDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  _CustomBopsateDropdownState createState() => _CustomBopsateDropdownState();
}

class _CustomBopsateDropdownState extends State<CustomSearchDropdown> {
  final TextEditingController _searchController = TextEditingController();
  late List<String> _filteredItems;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredItems = widget.items
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });

    _overlayEntry?.markNeedsBuild();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _closeDropdown,
              child: Container(),
            ),
          ),
          Positioned(
            width: UIHelpers.screenWidth(context) * 0.13,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, 50),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SupportBotColors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: serviceLocator<S>().searchText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: SupportBotColors.bluePrimary),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: true,
                          fillColor: SupportBotColors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return ListTile(
                              title: Text(
                                item,
                                style: item == widget.selectedValue
                                    ? SupportBotTextstyle.medium
                                        .copyWith(fontWeight: FontWeight.w500)
                                    : SupportBotTextstyle.medium,
                              ),
                              onTap: () {
                                widget.onChanged(item);
                                _closeDropdown();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
          decoration: BoxDecoration(
            border: Border.all(color: SupportBotColors.bluePrimary),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedValue.isNotEmpty
                    ? widget.selectedValue
                    : widget.label,
                style: SupportBotTextstyle.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: SupportBotColors.bluePrimary,
                ),
                overflow: TextOverflow.clip,
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: SupportBotColors.bluePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

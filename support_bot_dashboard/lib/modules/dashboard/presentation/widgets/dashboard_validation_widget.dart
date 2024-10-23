import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class ValidationReasonRenderer extends StatefulWidget {
  final String rowID;
  final PlutotableBloc plutotableBloc;
  final DateTime? date;
  final DateTime? month;
  final PlutoRow row;
  String pipeline;

  ValidationReasonRenderer({
    Key? key,
    required this.rowID,
    required this.plutotableBloc,
    required this.date,
    required this.month,
    required this.pipeline,
    required this.row,
  }) : super(key: key);

  @override
  ValidationReasonRendererState createState() =>
      ValidationReasonRendererState();
}

class ValidationReasonRendererState extends State<ValidationReasonRenderer> {
  late String _selectedValue;
  late String _previousValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _reason = '';

  String _selectedClassification = 'All';

  final List<String> classificationItems = [
    'All',
    'Spam/Marketing',
    'No Action Required',
    'Genuine Query',
    'Acknowledgement Required'
  ];

  @override
  void initState() {
    super.initState();
    _selectedValue =
        _validateValue(widget.row.cells['validation']?.value ?? 'Select');
    _previousValue = _selectedValue;
  }

  String _validateValue(String value) {
    const validValues = ['Select', 'correct', 'incorrect'];
    if (!validValues.contains(value)) {
      return 'Select';
    }
    return value;
  }

  void _showPopup(String rowId) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return BlocProvider.value(
          value: context.read<PlutotableBloc>(),
          child: AlertDialog(
            title: Text(S.of(context).emailValidations),
            backgroundColor: SupportBotColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SizedBox(
              width: UIHelpers.screenWidth(context) * 0.3,
              height: UIHelpers.screenHeight(context) * 0.28,
              child: BlocConsumer<PlutotableBloc, PlutotableState>(
                listener: (context, state) {
                  if (state is UpdateValidationSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is UpdateValidationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            _reason = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).comments;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: S.of(context).comments,
                            contentPadding: const EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          maxLines: 4,
                        ),
                        UIHelpers.verticalSpaceRegular,
                        Text(
                          S.of(context).classification,
                          style: SupportBotTextstyle.subheadingH6.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        UIHelpers.verticalSpaceTiny,
                        SizedBox(
                          width: UIHelpers.screenWidth(context) * 0.18,
                          height: UIHelpers.screenHeight(context) * 0.05,
                          child: DropdownButtonFormField<String>(
                            value: _selectedClassification,
                            items: classificationItems
                                .map((String classification) {
                              return DropdownMenuItem<String>(
                                value: classification,
                                child: Text(
                                  classification,
                                  style: SupportBotTextstyle.medium.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: SupportBotColors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedClassification = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                              color: SupportBotColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SupportBotColors.danger,
                      foregroundColor: SupportBotColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedValue = _previousValue;
                        widget.row.cells['validation']!.value = _selectedValue;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).cancel,
                      style: SupportBotTextstyle.hint.copyWith(
                        color: SupportBotColors.white,
                      ),
                    ),
                  ),
                  UIHelpers.horizontalSpaceRegular,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SupportBotColors.bluePrimary,
                      foregroundColor: SupportBotColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String validationStatus = _selectedValue;
                        context.read<PlutotableBloc>().add(
                            UpdateValidationEvent(
                                id: rowId,
                                validation: validationStatus,
                                reason: _reason,
                                selectedDate: widget.date,
                                selectedMonth: widget.month,
                                pipeline: widget.pipeline,
                                classification: _selectedClassification));
                      }
                    },
                    child: Text(
                      S.of(context).save,
                      style: SupportBotTextstyle.hint.copyWith(
                        color: SupportBotColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String rowId = widget.rowID;

    return BlocListener<PlutotableBloc, PlutotableState>(
      listener: (context, state) {
      
        if (state is FetchTableDataSuccess) {
        

          if (state.getValidationDetailsAttributeModel?.data?.status == true) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(S.of(context).statusUpdated),
                  content: Text(
                      state.getValidationDetailsAttributeModel?.data?.message ??
                          ""),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SupportBotColors.bluePrimary,
                        foregroundColor: SupportBotColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        S.of(context).ok,
                        style: SupportBotTextstyle.hint.copyWith(
                          color: SupportBotColors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if(state.getValidationDetailsAttributeModel?.data?.status == false){
          
            context.read<PlutotableBloc>().add(
                  UpdateValidationEvent(
                    id: widget.rowID,
                    validation: _selectedValue,
                    reason: '',
                    selectedDate: widget.date,
                    selectedMonth: widget.month,
                    pipeline: widget.pipeline,
                  ),
                );
          }
        } else if (state is GetValidationDetailsFailure) {
          print("Failure state received: ${state.message}");
        }
      },
      child: Column(
        children: [
          Flexible(
            child: SizedBox(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedValue,
                items: [
                  DropdownMenuItem<String>(
                    value: 'Select',
                    child: Text(
                      'Select',
                      style: SupportBotTextstyle.hint.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        color: SupportBotColors.gray.shade700,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'correct',
                    child: Text(
                      'Correct',
                      style: SupportBotTextstyle.hint.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        color: SupportBotColors.black,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'incorrect',
                    child: Text(
                      'Incorrect',
                      style: SupportBotTextstyle.hint.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        color: SupportBotColors.black,
                      ),
                    ),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _previousValue = _selectedValue;
                    _selectedValue = newValue!;
                    widget.row.cells['validation']!.value = _selectedValue;
                    if (_selectedValue == 'incorrect') {
                      _showPopup(rowId);
                    } else {
                      BlocProvider.of<PlutotableBloc>(context).add(GetValidationDetailsEvent(ticketId: rowId));
                    }
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                iconEnabledColor: SupportBotColors.gray.shade800,
                iconDisabledColor: SupportBotColors.gray.shade800,
                underline: const SizedBox.shrink(),
                dropdownColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Support Bot`
  String get title {
    return Intl.message(
      'Support Bot',
      name: 'title',
      desc: 'Support Bot',
      args: [],
    );
  }

  /// `Ticket Classification`
  String get ticketClassification {
    return Intl.message(
      'Ticket Classification',
      name: 'ticketClassification',
      desc: 'Ticket Classification',
      args: [],
    );
  }

  /// `AI Query Answer`
  String get aiQueryAnswer {
    return Intl.message(
      'AI Query Answer',
      name: 'aiQueryAnswer',
      desc: 'AI Query Answer',
      args: [],
    );
  }

  /// `Spam/Marketing`
  String get spam {
    return Intl.message(
      'Spam/Marketing',
      name: 'spam/Marketingm',
      desc: 'Spam/Marketing',
      args: [],
    );
  }

  /// `No Action Required`
  String get noActionRequired {
    return Intl.message(
      'No Action Required',
      name: 'noActionRequired',
      desc: 'No Action Required',
      args: [],
    );
  }

  /// `Genuine Query`
  String get genuineQuery {
    return Intl.message(
      'Genuine Query',
      name: 'genuineQuery',
      desc: 'Genuine Query',
      args: [],
    );
  }

  /// `Acknowledgement Required`
  String get acknowledgementRequired {
    return Intl.message(
      'Acknowledgement Required',
      name: 'acknowledgementRequired',
      desc: 'Acknowledgement Required',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: 'Total',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: 'Day',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: 'Month',
      args: [],
    );
  }

  /// `Classification`
  String get classification {
    return Intl.message(
      'Classification',
      name: 'classification',
      desc: 'Classification',
      args: [],
    );
  }

  /// `Validation`
  String get validation {
    return Intl.message(
      'Validation',
      name: 'validation',
      desc: 'Validation',
      args: [],
    );
  }

  /// `Export CSV File`
  String get export {
    return Intl.message(
      'Export CSV File',
      name: 'export',
      desc: 'Export CSV File',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: 'ID',
      args: [],
    );
  }

  /// `Ticket Description`
  String get ticketDescription {
    return Intl.message(
      'Ticket Description',
      name: 'ticketDescription',
      desc: 'Ticket Description',
      args: [],
    );
  }

  /// `Reasoning`
  String get reasoning {
    return Intl.message(
      'Reasoning',
      name: 'reasoning',
      desc: 'Reasoning',
      args: [],
    );
  }

  /// `Validation Reason`
  String get validationReason {
    return Intl.message(
      'Validation Reason',
      name: 'validationReason',
      desc: 'Validation Reason',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: 'Actions',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: 'Status',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Save',
      args: [],
    );
  }

  /// `Revert`
  String get revert {
    return Intl.message(
      'Revert',
      name: 'revert',
      desc: 'Revert',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: 'View',
      args: [],
    );
  }

  /// `Email Validation Details`
  String get emailValidations {
    return Intl.message(
      'Email Validation Details',
      name: 'emailValidations',
      desc: 'Email Validation Details',
      args: [],
    );
  }

  /// `Please enter your comments`
  String get comments {
    return Intl.message(
      'Please enter your comments',
      name: 'comments',
      desc: 'Please enter your comments',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel',
      args: [],
    );
  }

  /// `Ticket stage reverted successfully`
  String get revertSuccess {
    return Intl.message(
      'Ticket stage reverted successfully',
      name: 'revertSuccess',
      desc: 'Ticket stage reverted successfully',
      args: [],
    );
  }

  /// `No changes to revert.`
  String get noRevert {
    return Intl.message(
      'No changes to revert.',
      name: 'noRevert',
      desc: 'No changes to revert.',
      args: [],
    );
  }

  /// `This classification does not support revert feature`
  String get revertClassifcation {
    return Intl.message(
      'This classification does not support revert feature',
      name: 'revertClassifcation',
      desc: 'This classification does not support revert feature',
      args: [],
    );
  }

  /// `Change Classification`
  String get changeClassifcation {
    return Intl.message(
      'Change Classification',
      name: 'changeClassifcation',
      desc: 'Change Classification',
      args: [],
    );
  }

  /// `Update Status`
  String get statusUpdated {
    return Intl.message(
      'Update Status',
      name: 'statusUpdated',
      desc: 'Update Status',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: 'Ok',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'Yes',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'No',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: 'Link',
      args: [],
    );
  }

  /// `isAnswerEdited`
  String get isAnswerEdited {
    return Intl.message(
      'isAnswerEdited',
      name: 'isAnswerEdited',
      desc: 'isAnswerEdited',
      args: [],
    );
  }

  /// `Validation Status`
  String get validationStatus {
    return Intl.message(
      'Validation Status',
      name: 'validationStatus',
      desc: 'Validation Status',
      args: [],
    );
  }

  /// `User Validation`
  String get userValidation {
    return Intl.message(
      'User Validation',
      name: 'userValidation',
      desc: 'User Validation',
      args: [],
    );
  }

  /// `Validation Exists`
  String get validationExists {
    return Intl.message(
      'Validation Exists',
      name: 'validationExists',
      desc: 'Validation Exists',
      args: [],
    );
  }

  /// `Validate Email`
  String get validatEmail {
    return Intl.message(
      'Validate Email',
      name: 'validatEmail',
      desc: 'Validate Email',
      args: [],
    );
  }

  /// `Bops State`
  String get bopsState {
    return Intl.message(
      'Bops State',
      name: 'bopsState',
      desc: 'Bops State',
      args: [],
    );
  }

  /// `Pipeline Type`
  String get pipelineType {
    return Intl.message(
      'Pipeline Type',
      name: 'pipelineType',
      desc: 'PipelineType',
      args: [],
    );
  }

  /// `Validate AI Answer`
  String get validateAIAnswer {
    return Intl.message(
      'Validate AI Answer',
      name: 'validateAIAnswer',
      desc: 'Validate AI Answer',
      args: [],
    );
  }

  /// `Update Ticket`
  String get updateTicket {
    return Intl.message(
      'Update Ticket',
      name: 'updateTicket',
      desc: 'Update Ticket',
      args: [],
    );
  }

  /// `Update Successfully..`
  String get updateSuccess {
    return Intl.message(
      'Update Successfully..',
      name: 'updateSuccess',
      desc: 'Update Successfully',
      args: [],
    );
  }

  /// `AI Classification`
  String get aIClassification {
    return Intl.message(
      'AI Classification',
      name: 'aIClassification',
      desc: 'AI Classification',
      args: [],
    );
  }

  /// `Acknowledge Required`
  String get ackRequired {
    return Intl.message(
      'Acknowledge Required',
      name: 'ackRequired',
      desc: 'Acknowledge Required',
      args: [],
    );
  }

  /// `Error fetching data from server`
  String get aPIErrorMsg {
    return Intl.message(
      'Error fetching data from server',
      name: 'aPIErrorMsg',
      desc: 'Error fetching data from server',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

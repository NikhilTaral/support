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

  /// `Pipeline Type`
  String get pipelineType {
    return Intl.message(
      'Pipeline Type',
      name: 'pipelineType',
      desc: 'Pipeline Type',
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

    /// `Validation Status`
  String get validationStatus {
    return Intl.message(
      'Validation Status',
      name: 'validationStatus',
      desc: 'Validation Status',
      args: [],
    );
  }

  /// `Spam`
  String get spam {
    return Intl.message(
      'Spam/Marketing',
      name: 'Spam/Marketing',
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

  //answer edited
  String get isAnswerEdited {
    return Intl.message(
      'isAnswerEdited',
      name: 'isAnswerEdited',
      desc: 'isAnswerEdited',
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

  /// `Export`
  String get export {
    return Intl.message(
      'Export CSV File',
      name: 'export',
      desc: 'Export CSV File',
      args: [],
    );
  }

  /// `id`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: 'ID',
      args: [],
    );
  }

  /// `ticketDescription`
  String get ticketDescription {
    return Intl.message(
      'Ticket Description',
      name: 'ticketDescription',
      desc: 'Ticket Description',
      args: [],
    );
  }

  /// `reasoning`
  String get reasoning {
    return Intl.message(
      'Reasoning',
      name: 'reasoning',
      desc: 'Reasoning',
      args: [],
    );
  }

  /// `validationReason`
  String get validationReason {
    return Intl.message(
      'Validation Reason',
      name: 'validationReason',
      desc: 'Validation Reason',
      args: [],
    );
  }

  /// `actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: 'Actions',
      args: [],
    );
  }

  /// `status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: 'Status',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Save',
      args: [],
    );
  }

  /// `revert`
  String get revert {
    return Intl.message(
      'Revert',
      name: 'revert',
      desc: 'Revert',
      args: [],
    );
  }

  /// `Unrevert`
  String get updateTicket {
    return Intl.message(
      'Update',
      name: 'updateTicket',
      desc: 'updateTicket',
      args: [],
    );
  }

  /// `view`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: 'View',
      args: [],
    );
  }

  /// `changeClassification`
  String get changeClassifcation {
    return Intl.message(
      'Change Classification',
      name: 'changeClassifcation',
      desc: 'Change Classification',
      args: [],
    );
  }

  /// `emailValidations`
  String get emailValidations {
    return Intl.message(
      'Email Validation Details',
      name: 'emailValidations',
      desc: 'Email Validation Details',
      args: [],
    );
  }

  /// `comments`
  String get comments {
    return Intl.message(
      'Please enter your comments',
      name: 'comments',
      desc: 'Please enter your comments',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel',
      args: [],
    );
  }

  /// `revertSuccess`
  String get revertSuccess {
    return Intl.message(
      'Ticket stage reverted successfully',
      name: 'revertSuccess',
      desc: 'Ticket stage reverted successfully',
      args: [],
    );
  }

  /// `alreadyUpdated`
  String get noRevert {
    return Intl.message(
      'No changes to revert.',
      name: 'noRevert',
      desc: 'No changes to revert.',
      args: [],
    );
  }

    /// `UpdateSuccess`
  String get UpdateSuccess {
    return Intl.message(
      'Ticket Stage Updated Successfully',
      name: 'UpdateSuccess',
      desc: 'Ticket Stage Updated successfully',
      args: [],
    );
  }

  /// `revertClassification`
  String get revertClassifcation {
    return Intl.message(
      'This classification does not support revert feature',
      name: 'revertClassifcation',
      desc: 'This classification does not support revert feature',
      args: [],
    );
  }

  /// `statusUpdated`
  String get statusUpdated {
    return Intl.message(
      'Update Status',
      name: 'statusUpdated',
      desc: 'Update Status',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: 'Ok',
      args: [],
    );
  }

  /// `link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: 'Link',
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

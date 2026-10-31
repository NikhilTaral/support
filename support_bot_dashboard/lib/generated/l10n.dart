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

  /// `Items per page:   `
  String get itemsPerPageText {
    return Intl.message(
      'Items per page:   ',
      name: 'itemsPerPageText',
      desc: 'Items per page',
      args: [],
    );
  }

  /// `Error fetching data from server`
  String get aPIErrorMsgText {
    return Intl.message(
      'Error fetching data from server',
      name: 'aPIErrorMsgText',
      desc: 'Error msg',
      args: [],
    );
  }

  /// `Page`
  String get pageText {
    return Intl.message(
      'Page',
      name: 'pageText',
      desc: 'Page',
      args: [],
    );
  }

  /// `Pipeline`
  String get piplineText {
    return Intl.message(
      'Pipeline',
      name: 'piplineText',
      desc: 'Pipeline',
      args: [],
    );
  }

  /// `Apply Filter`
  String get filterApplyText {
    return Intl.message(
      'Apply Filter',
      name: 'filterApplyText',
      desc: 'Apply Filter',
      args: [],
    );
  }

  /// `Clear Filters`
  String get filterClearText {
    return Intl.message(
      'Clear Filters',
      name: 'filterClearText',
      desc: 'Clear Filters',
      args: [],
    );
  }

  /// `Please select a pipeline to apply filter`
  String get filterApplySnackBarText {
    return Intl.message(
      'Please select a pipeline to apply filter',
      name: 'filterApplySnackBarText',
      desc: 'Please select a pipeline to apply filter',
      args: [],
    );
  }

  /// `Search...`
  String get searchText {
    return Intl.message(
      'Search...',
      name: 'searchText',
      desc: 'Search',
      args: [],
    );
  }

  /// `Get Started`
  String get getStartedText {
    return Intl.message(
      'Get Started',
      name: 'getStartedText',
      desc: 'Get Started',
      args: [],
    );
  }

  /// `Validate`
  String get validate {
    return Intl.message(
      'Validate',
      name: 'validate',
      desc: 'Validate',
      args: [],
    );
  }

  /// `Validate AI Answer`
  String get validateAIAnswerText {
    return Intl.message(
      'Validate AI Answer',
      name: 'validateAIAnswerText',
      desc: 'Validate AI Answer Text',
      args: [],
    );
  }

  /// `Do you want to Validate AI Answer for this ticket?`
  String get validateAIAnsweTicketrText {
    return Intl.message(
      'Do you want to Validate AI Answer for this ticket?',
      name: 'validateAIAnsweTicketrText',
      desc: 'Do you want to Validate AI Answer for this ticket? Text',
      args: [],
    );
  }

  /// `Ticket ID:`
  String get ticketIDText {
    return Intl.message(
      'Ticket ID:',
      name: 'ticketIDText',
      desc: 'Ticket ID: Text',
      args: [],
    );
  }

  /// `Ticket Description:`
  String get ticketDescriptionText {
    return Intl.message(
      'Ticket Description:',
      name: 'ticketDescriptionText',
      desc: 'Ticket Description Text',
      args: [],
    );
  }

  /// `Answer Status:`
  String get answerStatusText {
    return Intl.message(
      'Answer Status:',
      name: 'answerStatusText',
      desc: 'Answer Status Text',
      args: [],
    );
  }

  /// `Validation Status:`
  String get aiValidationStatusText {
    return Intl.message(
      'Validation Status:',
      name: 'aiValidationStatusText',
      desc: 'Validation Status Text',
      args: [],
    );
  }

  /// `AI Answer Validated Successfully!`
  String get aiAnswerValidationSuccessfullyText {
    return Intl.message(
      'AI Answer Validated Successfully!',
      name: 'aiAnswerValidationSuccessfullyText',
      desc: 'AI Answer Validated Successfully',
      args: [],
    );
  }

  /// `Failed Validating AI Answer !`
  String get aiAnswerValidationFailureText {
    return Intl.message(
      'Failed Validating AI Answer !',
      name: 'aiAnswerValidationFailureText',
      desc: 'Failed Validating AI Answer ',
      args: [],
    );
  }

  /// `Answer Edited Status:`
  String get answerEditedStatusText {
    return Intl.message(
      'Answer Edited Status:',
      name: 'answerEditedStatusText',
      desc: 'Answer Edited Status Text',
      args: [],
    );
  }

  /// `AI Query Answer:`
  String get aIQueryAnswerText {
    return Intl.message(
      'AI Query Answer:',
      name: 'aIQueryAnswerText',
      desc: 'AI Query Answer Text',
      args: [],
    );
  }

  /// `CSV Downloaded Successfully!`
  String get exportSuccessfullyText {
    return Intl.message(
      'CSV Downloaded Successfully!',
      name: 'exportSuccessfullyText',
      desc: 'Export Successfully Text',
      args: [],
    );
  }

  /// `CSV Downloading Failed!`
  String get exportFailureText {
    return Intl.message(
      'CSV Downloading Failed!',
      name: 'exportFailureText',
      desc: 'Export Failure Text',
      args: [],
    );
  }

  /// `Edit`
  String get editText {
    return Intl.message(
      'Edit',
      name: 'editText',
      desc: 'Edit Text',
      args: [],
    );
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
      name: 'spam',
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

  /// `AI Classification`
  String get classification {
    return Intl.message(
      'AI Classification',
      name: 'classification',
      desc: 'AI Classification',
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

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: 'Link',
      args: [],
    );
  }

  /// `Genuine Query`
  String get genuineQueryText {
    return Intl.message(
      'Genuine Query',
      name: 'genuineQueryText',
      desc: 'Genuine Query Column Title',
      args: [],
    );
  }

  /// `Acknowledgement Required`
  String get acknowledgeRequiredText {
    return Intl.message(
      'Acknowledgement Required',
      name: 'acknowledgeRequiredText',
      desc: 'Acknowledgement Required Column Title',
      args: [],
    );
  }

  /// `Spam/Marketing`
  String get spamMarketing {
    return Intl.message(
      'Spam/Marketing',
      name: 'spamMarketing',
      desc: 'Spam/Marketing Column Title',
      args: [],
    );
  }

  /// `No items available.`
  String get noItemsText {
    return Intl.message(
      'No items available.',
      name: 'noItemsText',
      desc: 'No items available. Title',
      args: [],
    );
  }

  /// `Tickets Answer: `
  String get ticketsAnswerText {
    return Intl.message(
      'Tickets Answer: ',
      name: 'ticketsAnswerText',
      desc: 'Tickets AnswerText Text',
      args: [],
    );
  }

  /// `Tickets Not Answer:`
  String get ticketsNotAnswerText {
    return Intl.message(
      'Tickets Not Answer:',
      name: 'ticketsNotAnswerText',
      desc: 'Tickets Not Answer Text',
      args: [],
    );
  }

  /// `AI Tickets Answer`
  String get aiTicketsAnswerText {
    return Intl.message(
      'AI Tickets Answer',
      name: 'aiTicketsAnswerText',
      desc: 'AI Tickets Answer Text',
      args: [],
    );
  }

  /// `Ticket Not Edited:`
  String get ticketNotEditedText {
    return Intl.message(
      'Ticket Not Edited:',
      name: 'ticketNotEditedText',
      desc: 'Ticket Not Edited Text',
      args: [],
    );
  }

  /// `Ticket Edited:`
  String get ticketEditedText {
    return Intl.message(
      'Ticket Edited:',
      name: 'ticketEditedText',
      desc: 'Ticket Edited Text',
      args: [],
    );
  }

  /// `AI Tickets Edited`
  String get aiTicketsEditedText {
    return Intl.message(
      'AI Tickets Edited',
      name: 'aiTicketsEditedText',
      desc: 'AI Tickets Edited Text',
      args: [],
    );
  }

  /// `User Validation`
  String get userValidationText {
    return Intl.message(
      'User Validation',
      name: 'userValidationText',
      desc: 'User Validation Text',
      args: [],
    );
  }

  /// `OK`
  String get oKText {
    return Intl.message(
      'OK',
      name: 'oKText',
      desc: 'OK Text',
      args: [],
    );
  }

  /// `Actual Classification`
  String get actualClassification {
    return Intl.message(
      'Actual Classification',
      name: 'actualClassification',
      desc: 'Actual Classification Text',
      args: [],
    );
  }

  /// `Validation Status`
  String get validationStatusText {
    return Intl.message(
      'Validation Status',
      name: 'validationStatusText',
      desc: 'Validation Status Text',
      args: [],
    );
  }

  /// `Unable to Classify`
  String get ticketUnableClassify {
    return Intl.message(
      'Unable to Classify',
      name: 'ticketUnableClassify',
      desc: 'Unable to Classify text',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrongText {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrongText',
      desc: 'Something Went Wrong Text',
      args: [],
    );
  }

  /// `Validated Tickets`
  String get validatedTicketsText {
    return Intl.message(
      'Validated Tickets',
      name: 'validatedTicketsText',
      desc: 'Validated Tickets Text',
      args: [],
    );
  }

  /// `Validated Tickets`
  String get validatedTicketsPercentageText {
    return Intl.message(
      'Validated Tickets',
      name: 'validatedTicketsPercentageText',
      desc: 'Validated Tickets Text',
      args: [],
    );
  }

  /// `Total Tickets`
  String get totalTicketsText {
    return Intl.message(
      'Total Tickets',
      name: 'totalTicketsText',
      desc: 'Total Tickets Text',
      args: [],
    );
  }

  /// `Total Tickets`
  String get totalTicketsPercentageText {
    return Intl.message(
      'Total Tickets',
      name: 'totalTicketsPercentageText',
      desc: 'Total Tickets Text',
      args: [],
    );
  }

  /// `Pipeline`
  String get pipelineText {
    return Intl.message(
      'Pipeline',
      name: 'pipelineText',
      desc: 'pipeline Text',
      args: [],
    );
  }

  /// `Total`
  String get totalText {
    return Intl.message(
      'Total',
      name: 'totalText',
      desc: 'Total Text',
      args: [],
    );
  }

  /// `Total Count`
  String get totalCountText {
    return Intl.message(
      'Total Count',
      name: 'totalCountText',
      desc: 'Total Count Text',
      args: [],
    );
  }

  /// `Validated Count`
  String get validatedCountText {
    return Intl.message(
      'Validated Count',
      name: 'validatedCountText',
      desc: 'Validated Count Text',
      args: [],
    );
  }

  /// `Validated Percentage`
  String get validatedPercentageText {
    return Intl.message(
      'Validated Percentage',
      name: 'validatedPercentageText',
      desc: 'Validated Count Percentage Text',
      args: [],
    );
  }

  /// `User Validation Count`
  String get userValidationCountText {
    return Intl.message(
      'User Validation Count',
      name: 'userValidationCountText',
      desc: 'User Validation Count Text',
      args: [],
    );
  }

  /// `Awaiting to Classify`
  String get awaitingToClassifyText {
    return Intl.message(
      'Awaiting to Classify',
      name: 'awaitingToClassifyText',
      desc: 'Awaiting to Classify Text',
      args: [],
    );
  }

  /// `AI Accuracy`
  String get aIAccuracyText {
    return Intl.message(
      'AI Accuracy',
      name: 'aIAccuracyText',
      desc: 'AI Accuracy Text',
      args: [],
    );
  }

  /// `Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown.`
  String get piplineInfoToolTipText {
    return Intl.message(
      'Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown.',
      name: 'piplineInfoToolTipText',
      desc:
          'Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown. Text',
      args: [],
    );
  }

  /// `Auto-Close`
  String get autoCloseText {
    return Intl.message(
      'Auto-Close',
      name: 'autoCloseText',
      desc: 'Auto-Close Text',
      args: [],
    );
  }

  /// `Correct`
  String get correctText {
    return Intl.message(
      'Correct',
      name: 'correctText',
      desc: 'Correct Text',
      args: [],
    );
  }

  /// `Incorrect`
  String get incorrectText {
    return Intl.message(
      'Incorrect',
      name: 'incorrectText',
      desc: 'InCorrect Text',
      args: [],
    );
  }

  /// `AI Response Stats`
  String get aiResponseStatText {
    return Intl.message(
      'AI Response Stats',
      name: 'aiResponseStatText',
      desc: 'AI Response Stats Text',
      args: [],
    );
  }

  /// ` Responses: {totalResponses}\nPercentage: {percentage}% \n {correctIncorrectText}`
  String totalResponsesTooltip(
      Object totalResponses, Object percentage, Object correctIncorrectText) {
    return Intl.message(
      ' Responses: $totalResponses\nPercentage: $percentage% \n $correctIncorrectText',
      name: 'totalResponsesTooltip',
      desc: 'Tooltip displaying correct/incorrect responses and percentage',
      args: [totalResponses, percentage, correctIncorrectText],
    );
  }

  /// `By clicking “GET STARTED” you are agreeing to our `
  String get signInPageTextPart1 {
    return Intl.message(
      'By clicking “GET STARTED” you are agreeing to our ',
      name: 'signInPageTextPart1',
      desc: 'By clicking “GET STARTED” you are agreeing to our ',
      args: [],
    );
  }

  /// `Privacy Policy,`
  String get signInPageTextPart2 {
    return Intl.message(
      'Privacy Policy,',
      name: 'signInPageTextPart2',
      desc: 'Privacy Policy,',
      args: [],
    );
  }

  /// ` our `
  String get signInPageTextPart3 {
    return Intl.message(
      ' our ',
      name: 'signInPageTextPart3',
      desc: ' our ',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get signInPageTextPart4 {
    return Intl.message(
      'Terms & Conditions',
      name: 'signInPageTextPart4',
      desc: 'Terms & Conditions',
      args: [],
    );
  }

  /// `Enter the email and the name that was used on your join application.`
  String get signInPageText {
    return Intl.message(
      'Enter the email and the name that was used on your join application.',
      name: 'signInPageText',
      desc:
          'Enter the email and the name that was used on your join application.',
      args: [],
    );
  }

  /// `We’ve sent a link for your joining application to {email}. Click the link to kick-start your application process.`
  String v3OnboardingLoginJoinEmailSentSubtitle(Object email) {
    return Intl.message(
      'We’ve sent a link for your joining application to $email. Click the link to kick-start your application process.',
      name: 'v3OnboardingLoginJoinEmailSentSubtitle',
      desc: 'Onboarding login view email sent screen subtitle',
      args: [email],
    );
  }

  /// ` as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed.`
  String get signInPageTextPart5 {
    return Intl.message(
      ' as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed.',
      name: 'signInPageTextPart5',
      desc:
          'as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed.',
      args: [],
    );
  }

  /// `From Join App`
  String get fromJoinAppTitle {
    return Intl.message(
      'From Join App',
      name: 'fromJoinAppTitle',
      desc: 'from Join App Title',
      args: [],
    );
  }

  /// `Download MyeXp app to get the latest updates about your application`
  String get fromJoinAppDownloadTitle {
    return Intl.message(
      'Download MyeXp app to get the latest updates about your application',
      name: 'fromJoinAppDownloadTitle',
      desc: 'from Join App Download Title',
      args: [],
    );
  }

  /// `or`
  String get fromJoinAppOrTitle {
    return Intl.message(
      'or',
      name: 'fromJoinAppOrTitle',
      desc: 'from Join App OR Title',
      args: [],
    );
  }

  /// `Continue on Web`
  String get fromJoinAppSignInButtonTitle {
    return Intl.message(
      'Continue on Web',
      name: 'fromJoinAppSignInButtonTitle',
      desc: 'From Join App Sign In Button Title',
      args: [],
    );
  }

  /// `Expert Care Level 1`
  String get intialpipelineText {
    return Intl.message(
      'Expert Care Level 1',
      name: 'intialpipelineText',
      desc: 'Inital PipLine Text',
      args: [],
    );
  }

  /// `BOPS State/ Province`
  String get bobStateText {
    return Intl.message(
      'BOPS State/ Province',
      name: 'bobStateText',
      desc: 'BOPS State/ Province Text',
      args: [],
    );
  }

  /// `Unknown Pipeline`
  String get unknownPipelineText {
    return Intl.message(
      'Unknown Pipeline',
      name: 'unknownPipelineText',
      desc: 'Unknown Pipeline Text',
      args: [],
    );
  }

  /// `Update Successfully!`
  String get updateSuccessfullyText {
    return Intl.message(
      'Update Successfully!',
      name: 'updateSuccessfullyText',
      desc: 'Update Successfully Text',
      args: [],
    );
  }

  /// `Update Failure!`
  String get updateFailureText {
    return Intl.message(
      'Update Failure!',
      name: 'updateFailureText',
      desc: 'Update Failure Text',
      args: [],
    );
  }

  /// `Reverted Successfully`
  String get revertedSuccessfullyText {
    return Intl.message(
      'Reverted Successfully',
      name: 'revertedSuccessfullyText',
      desc: 'Reverted Successfully Text',
      args: [],
    );
  }

  /// `Reverted Failure`
  String get revertedFailureText {
    return Intl.message(
      'Reverted Failure',
      name: 'revertedFailureText',
      desc: 'Reverted Failure Text',
      args: [],
    );
  }

  /// `Update`
  String get updateText {
    return Intl.message(
      'Update',
      name: 'updateText',
      desc: 'Update Text',
      args: [],
    );
  }

  /// `Update Ticket`
  String get updateTicketText {
    return Intl.message(
      'Update Ticket',
      name: 'updateTicketText',
      desc: 'Update Ticket Text',
      args: [],
    );
  }

  /// `Do you Want to Mark This Ticket as a Contact {value} in HubSpot`
  String requestMsgText(Object value) {
    return Intl.message(
      'Do you Want to Mark This Ticket as a Contact $value in HubSpot',
      name: 'requestMsgText',
      desc: 'request Msg Text',
      args: [value],
    );
  }

  /// `No`
  String get noText {
    return Intl.message(
      'No',
      name: 'noText',
      desc: 'NO Text',
      args: [],
    );
  }

  /// `Yes`
  String get yesText {
    return Intl.message(
      'Yes',
      name: 'yesText',
      desc: 'Yes Text',
      args: [],
    );
  }

  /// `Ticket Details`
  String get ticketDetailsText {
    return Intl.message(
      'Ticket Details',
      name: 'ticketDetailsText',
      desc: 'Ticket Details Text',
      args: [],
    );
  }

  /// `Description`
  String get descriptionText {
    return Intl.message(
      'Description',
      name: 'descriptionText',
      desc: 'Description Text',
      args: [],
    );
  }

  /// `Reasoning`
  String get reasoningText {
    return Intl.message(
      'Reasoning',
      name: 'reasoningText',
      desc: 'Reasoning Text',
      args: [],
    );
  }

  /// `Validated By`
  String get validatedByText {
    return Intl.message(
      'Validated By',
      name: 'validatedByText',
      desc: 'Validated By Text',
      args: [],
    );
  }

  /// `Classification Validation Reason`
  String get classificationValidationReasonText {
    return Intl.message(
      'Classification Validation Reason',
      name: 'classificationValidationReasonText',
      desc: 'Classification Validation Reason Text',
      args: [],
    );
  }

  /// `Close`
  String get closeText {
    return Intl.message(
      'Close',
      name: 'closeText',
      desc: 'Close Text',
      args: [],
    );
  }

  /// `Validated Classification`
  String get validatedClassificationText {
    return Intl.message(
      'Validated Classification',
      name: 'validatedClassificationText',
      desc: 'Validated Classification Text',
      args: [],
    );
  }

  /// `Validated User`
  String get validatedUserText {
    return Intl.message(
      'Validated User',
      name: 'validatedUserText',
      desc: 'Validated User Text',
      args: [],
    );
  }

  /// `No Data Found`
  String get noDataFoundText {
    return Intl.message(
      'No Data Found',
      name: 'noDataFoundText',
      desc: 'No Data Found Text',
      args: [],
    );
  }

  /// `No User Available`
  String get noUserAvailableText {
    return Intl.message(
      'No User Available',
      name: 'noUserAvailableText',
      desc: 'No User Available Text',
      args: [],
    );
  }

  /// `No State/Province Available`
  String get noStateAvailableText {
    return Intl.message(
      'No State/Province Available',
      name: 'noStateAvailableText',
      desc: 'No State/Province Available Text',
      args: [],
    );
  }

  /// `Please provide reason and select classification`
  String get reasonAndSelectClassificationText {
    return Intl.message(
      'Please provide reason and select classification',
      name: 'reasonAndSelectClassificationText',
      desc: 'Please provide reason and select classification Text',
      args: [],
    );
  }

  /// `No selection`
  String get noSelectionText {
    return Intl.message(
      'No selection',
      name: 'noSelectionText',
      desc: 'No selection Text',
      args: [],
    );
  }

  /// `Export CSV File`
  String get exportCSVFileText {
    return Intl.message(
      'Export CSV File',
      name: 'exportCSVFileText',
      desc: 'Export CSV File Text',
      args: [],
    );
  }

  /// `Ticket Validated As Correct`
  String get ticketUpdatedCorrectText {
    return Intl.message(
      'Ticket Validated As Correct',
      name: 'ticketUpdatedCorrectText',
      desc: 'Ticket Validated As  Correct Text',
      args: [],
    );
  }

  /// `Ticket Validated As Incorrect`
  String get ticketUpdatedInCorrectText {
    return Intl.message(
      'Ticket Validated As Incorrect',
      name: 'ticketUpdatedInCorrectText',
      desc: 'Ticket Validated As In-Correct Text',
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

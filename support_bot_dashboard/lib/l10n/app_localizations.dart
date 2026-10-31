import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// Items per page
  ///
  /// In en, this message translates to:
  /// **'Items per page:   '**
  String get itemsPerPageText;

  /// Error msg
  ///
  /// In en, this message translates to:
  /// **'Error fetching data from server'**
  String get aPIErrorMsgText;

  /// Page
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get pageText;

  /// Pipeline
  ///
  /// In en, this message translates to:
  /// **'Pipeline'**
  String get piplineText;

  /// Apply Filter
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get filterApplyText;

  /// Clear Filters
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get filterClearText;

  /// Please select a pipeline to apply filter
  ///
  /// In en, this message translates to:
  /// **'Please select a pipeline to apply filter'**
  String get filterApplySnackBarText;

  /// Search
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchText;

  /// Get Started
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedText;

  /// Validate
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validate;

  /// Validate AI Answer Text
  ///
  /// In en, this message translates to:
  /// **'Validate AI Answer'**
  String get validateAIAnswerText;

  /// Do you want to Validate AI Answer for this ticket? Text
  ///
  /// In en, this message translates to:
  /// **'Do you want to Validate AI Answer for this ticket?'**
  String get validateAIAnsweTicketrText;

  /// Ticket ID: Text
  ///
  /// In en, this message translates to:
  /// **'Ticket ID:'**
  String get ticketIDText;

  /// Ticket Description Text
  ///
  /// In en, this message translates to:
  /// **'Ticket Description:'**
  String get ticketDescriptionText;

  /// Answer Status Text
  ///
  /// In en, this message translates to:
  /// **'Answer Status:'**
  String get answerStatusText;

  /// Validation Status Text
  ///
  /// In en, this message translates to:
  /// **'Validation Status:'**
  String get aiValidationStatusText;

  /// AI Answer Validated Successfully
  ///
  /// In en, this message translates to:
  /// **'AI Answer Validated Successfully!'**
  String get aiAnswerValidationSuccessfullyText;

  /// Failed Validating AI Answer
  ///
  /// In en, this message translates to:
  /// **'Failed Validating AI Answer !'**
  String get aiAnswerValidationFailureText;

  /// Answer Edited Status Text
  ///
  /// In en, this message translates to:
  /// **'Answer Edited Status:'**
  String get answerEditedStatusText;

  /// AI Query Answer Text
  ///
  /// In en, this message translates to:
  /// **'AI Query Answer:'**
  String get aIQueryAnswerText;

  /// Export Successfully Text
  ///
  /// In en, this message translates to:
  /// **'CSV Downloaded Successfully!'**
  String get exportSuccessfullyText;

  /// Export Failure Text
  ///
  /// In en, this message translates to:
  /// **'CSV Downloading Failed!'**
  String get exportFailureText;

  /// Edit Text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editText;

  /// Support Bot
  ///
  /// In en, this message translates to:
  /// **'Support Bot'**
  String get title;

  /// Ticket Classification
  ///
  /// In en, this message translates to:
  /// **'Ticket Classification'**
  String get ticketClassification;

  /// AI Query Answer
  ///
  /// In en, this message translates to:
  /// **'AI Query Answer'**
  String get aiQueryAnswer;

  /// Spam/Marketing
  ///
  /// In en, this message translates to:
  /// **'Spam/Marketing'**
  String get spam;

  /// No Action Required
  ///
  /// In en, this message translates to:
  /// **'No Action Required'**
  String get noActionRequired;

  /// Genuine Query
  ///
  /// In en, this message translates to:
  /// **'Genuine Query'**
  String get genuineQuery;

  /// Acknowledgement Required
  ///
  /// In en, this message translates to:
  /// **'Acknowledgement Required'**
  String get acknowledgementRequired;

  /// Day
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// Month
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// AI Classification
  ///
  /// In en, this message translates to:
  /// **'AI Classification'**
  String get classification;

  /// Validation
  ///
  /// In en, this message translates to:
  /// **'Validation'**
  String get validation;

  /// Export CSV File
  ///
  /// In en, this message translates to:
  /// **'Export CSV File'**
  String get export;

  /// Save
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Revert
  ///
  /// In en, this message translates to:
  /// **'Revert'**
  String get revert;

  /// View
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// Email Validation Details
  ///
  /// In en, this message translates to:
  /// **'Email Validation Details'**
  String get emailValidations;

  /// Please enter your comments
  ///
  /// In en, this message translates to:
  /// **'Please enter your comments'**
  String get comments;

  /// Cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// ID
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// Ticket Description
  ///
  /// In en, this message translates to:
  /// **'Ticket Description'**
  String get ticketDescription;

  /// Reasoning
  ///
  /// In en, this message translates to:
  /// **'Reasoning'**
  String get reasoning;

  /// Validation Reason
  ///
  /// In en, this message translates to:
  /// **'Validation Reason'**
  String get validationReason;

  /// Actions
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// Status
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// Ticket stage reverted successfully
  ///
  /// In en, this message translates to:
  /// **'Ticket stage reverted successfully'**
  String get revertSuccess;

  /// No changes to revert.
  ///
  /// In en, this message translates to:
  /// **'No changes to revert.'**
  String get noRevert;

  /// This classification does not support revert feature
  ///
  /// In en, this message translates to:
  /// **'This classification does not support revert feature'**
  String get revertClassifcation;

  /// Change Classification
  ///
  /// In en, this message translates to:
  /// **'Change Classification'**
  String get changeClassifcation;

  /// Update Status
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get statusUpdated;

  /// Ok
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// AI Classification
  ///
  /// In en, this message translates to:
  /// **'AI Classification'**
  String get aIClassification;

  /// Acknowledge Required
  ///
  /// In en, this message translates to:
  /// **'Acknowledge Required'**
  String get ackRequired;

  /// Link
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// Genuine Query Column Title
  ///
  /// In en, this message translates to:
  /// **'Genuine Query'**
  String get genuineQueryText;

  /// Acknowledgement Required Column Title
  ///
  /// In en, this message translates to:
  /// **'Acknowledgement Required'**
  String get acknowledgeRequiredText;

  /// Spam/Marketing Column Title
  ///
  /// In en, this message translates to:
  /// **'Spam/Marketing'**
  String get spamMarketing;

  /// No items available. Title
  ///
  /// In en, this message translates to:
  /// **'No items available.'**
  String get noItemsText;

  /// Tickets AnswerText Text
  ///
  /// In en, this message translates to:
  /// **'Tickets Answer: '**
  String get ticketsAnswerText;

  /// Tickets Not Answer Text
  ///
  /// In en, this message translates to:
  /// **'Tickets Not Answer:'**
  String get ticketsNotAnswerText;

  /// AI Tickets Answer Text
  ///
  /// In en, this message translates to:
  /// **'AI Tickets Answer'**
  String get aiTicketsAnswerText;

  /// Ticket Not Edited Text
  ///
  /// In en, this message translates to:
  /// **'Ticket Not Edited:'**
  String get ticketNotEditedText;

  /// Ticket Edited Text
  ///
  /// In en, this message translates to:
  /// **'Ticket Edited:'**
  String get ticketEditedText;

  /// AI Tickets Edited Text
  ///
  /// In en, this message translates to:
  /// **'AI Tickets Edited'**
  String get aiTicketsEditedText;

  /// User Validation Text
  ///
  /// In en, this message translates to:
  /// **'User Validation'**
  String get userValidationText;

  /// OK Text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get oKText;

  /// Actual Classification Text
  ///
  /// In en, this message translates to:
  /// **'Actual Classification'**
  String get actualClassification;

  /// Validation Status Text
  ///
  /// In en, this message translates to:
  /// **'Validation Status'**
  String get validationStatusText;

  /// Unable to Classify text
  ///
  /// In en, this message translates to:
  /// **'Unable to Classify'**
  String get ticketUnableClassify;

  /// Something Went Wrong Text
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get somethingWentWrongText;

  /// Validated Tickets Text
  ///
  /// In en, this message translates to:
  /// **'Validated Tickets'**
  String get validatedTicketsText;

  /// Validated Tickets Text
  ///
  /// In en, this message translates to:
  /// **'Validated Tickets'**
  String get validatedTicketsPercentageText;

  /// Total Tickets Text
  ///
  /// In en, this message translates to:
  /// **'Total Tickets'**
  String get totalTicketsText;

  /// Total Tickets Text
  ///
  /// In en, this message translates to:
  /// **'Total Tickets'**
  String get totalTicketsPercentageText;

  /// pipeline Text
  ///
  /// In en, this message translates to:
  /// **'Pipeline'**
  String get pipelineText;

  /// Total Text
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalText;

  /// Total Count Text
  ///
  /// In en, this message translates to:
  /// **'Total Count'**
  String get totalCountText;

  /// Validated Count Text
  ///
  /// In en, this message translates to:
  /// **'Validated Count'**
  String get validatedCountText;

  /// Validated Count Percentage Text
  ///
  /// In en, this message translates to:
  /// **'Validated Percentage'**
  String get validatedPercentageText;

  /// User Validation Count Text
  ///
  /// In en, this message translates to:
  /// **'User Validation Count'**
  String get userValidationCountText;

  /// Awaiting to Classify Text
  ///
  /// In en, this message translates to:
  /// **'Awaiting to Classify'**
  String get awaitingToClassifyText;

  /// AI Accuracy Text
  ///
  /// In en, this message translates to:
  /// **'AI Accuracy'**
  String get aIAccuracyText;

  /// Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown. Text
  ///
  /// In en, this message translates to:
  /// **'Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown.'**
  String get piplineInfoToolTipText;

  /// Auto-Close Text
  ///
  /// In en, this message translates to:
  /// **'Auto-Close'**
  String get autoCloseText;

  /// Correct Text
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correctText;

  /// InCorrect Text
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrectText;

  /// AI Response Stats Text
  ///
  /// In en, this message translates to:
  /// **'AI Response Stats'**
  String get aiResponseStatText;

  /// Tooltip displaying correct/incorrect responses and percentage
  ///
  /// In en, this message translates to:
  /// **' Responses: {totalResponses}\nPercentage: {percentage}% \n {correctIncorrectText}'**
  String totalResponsesTooltip(Object totalResponses, Object percentage, Object correctIncorrectText);

  /// By clicking “GET STARTED” you are agreeing to our
  ///
  /// In en, this message translates to:
  /// **'By clicking “GET STARTED” you are agreeing to our '**
  String get signInPageTextPart1;

  /// Privacy Policy,
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy,'**
  String get signInPageTextPart2;

  ///  our
  ///
  /// In en, this message translates to:
  /// **' our '**
  String get signInPageTextPart3;

  /// Terms & Conditions
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get signInPageTextPart4;

  /// Enter the email and the name that was used on your join application.
  ///
  /// In en, this message translates to:
  /// **'Enter the email and the name that was used on your join application.'**
  String get signInPageText;

  /// Onboarding login view email sent screen subtitle
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a link for your joining application to {email}. Click the link to kick-start your application process.'**
  String v3OnboardingLoginJoinEmailSentSubtitle(Object email);

  /// as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed.
  ///
  /// In en, this message translates to:
  /// **' as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed.'**
  String get signInPageTextPart5;

  /// from Join App Title
  ///
  /// In en, this message translates to:
  /// **'From Join App'**
  String get fromJoinAppTitle;

  /// from Join App Download Title
  ///
  /// In en, this message translates to:
  /// **'Download MyeXp app to get the latest updates about your application'**
  String get fromJoinAppDownloadTitle;

  /// from Join App OR Title
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get fromJoinAppOrTitle;

  /// From Join App Sign In Button Title
  ///
  /// In en, this message translates to:
  /// **'Continue on Web'**
  String get fromJoinAppSignInButtonTitle;

  /// Inital PipLine Text
  ///
  /// In en, this message translates to:
  /// **'Expert Care Level 1'**
  String get intialpipelineText;

  /// BOPS State/ Province Text
  ///
  /// In en, this message translates to:
  /// **'BOPS State/ Province'**
  String get bobStateText;

  /// Unknown Pipeline Text
  ///
  /// In en, this message translates to:
  /// **'Unknown Pipeline'**
  String get unknownPipelineText;

  /// Update Successfully Text
  ///
  /// In en, this message translates to:
  /// **'Update Successfully!'**
  String get updateSuccessfullyText;

  /// Update Failure Text
  ///
  /// In en, this message translates to:
  /// **'Update Failure!'**
  String get updateFailureText;

  /// Reverted Successfully Text
  ///
  /// In en, this message translates to:
  /// **'Reverted Successfully'**
  String get revertedSuccessfullyText;

  /// Reverted Failure Text
  ///
  /// In en, this message translates to:
  /// **'Reverted Failure'**
  String get revertedFailureText;

  /// Update Text
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateText;

  /// Update Ticket Text
  ///
  /// In en, this message translates to:
  /// **'Update Ticket'**
  String get updateTicketText;

  /// request Msg Text
  ///
  /// In en, this message translates to:
  /// **'Do you Want to Mark This Ticket as a Contact {value} in HubSpot'**
  String requestMsgText(Object value);

  /// NO Text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noText;

  /// Yes Text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesText;

  /// Ticket Details Text
  ///
  /// In en, this message translates to:
  /// **'Ticket Details'**
  String get ticketDetailsText;

  /// Description Text
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionText;

  /// Reasoning Text
  ///
  /// In en, this message translates to:
  /// **'Reasoning'**
  String get reasoningText;

  /// Validated By Text
  ///
  /// In en, this message translates to:
  /// **'Validated By'**
  String get validatedByText;

  /// Classification Validation Reason Text
  ///
  /// In en, this message translates to:
  /// **'Classification Validation Reason'**
  String get classificationValidationReasonText;

  /// Close Text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeText;

  /// Validated Classification Text
  ///
  /// In en, this message translates to:
  /// **'Validated Classification'**
  String get validatedClassificationText;

  /// Validated User Text
  ///
  /// In en, this message translates to:
  /// **'Validated User'**
  String get validatedUserText;

  /// No Data Found Text
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noDataFoundText;

  /// No User Available Text
  ///
  /// In en, this message translates to:
  /// **'No User Available'**
  String get noUserAvailableText;

  /// No State/Province Available Text
  ///
  /// In en, this message translates to:
  /// **'No State/Province Available'**
  String get noStateAvailableText;

  /// Please provide reason and select classification Text
  ///
  /// In en, this message translates to:
  /// **'Please provide reason and select classification'**
  String get reasonAndSelectClassificationText;

  /// No selection Text
  ///
  /// In en, this message translates to:
  /// **'No selection'**
  String get noSelectionText;

  /// Export CSV File Text
  ///
  /// In en, this message translates to:
  /// **'Export CSV File'**
  String get exportCSVFileText;

  /// Ticket Validated As  Correct Text
  ///
  /// In en, this message translates to:
  /// **'Ticket Validated As Correct'**
  String get ticketUpdatedCorrectText;

  /// Ticket Validated As In-Correct Text
  ///
  /// In en, this message translates to:
  /// **'Ticket Validated As Incorrect'**
  String get ticketUpdatedInCorrectText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

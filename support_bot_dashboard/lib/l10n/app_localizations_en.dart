// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get itemsPerPageText => 'Items per page:   ';

  @override
  String get aPIErrorMsgText => 'Error fetching data from server';

  @override
  String get pageText => 'Page';

  @override
  String get piplineText => 'Pipeline';

  @override
  String get filterApplyText => 'Apply Filter';

  @override
  String get filterClearText => 'Clear Filters';

  @override
  String get filterApplySnackBarText => 'Please select a pipeline to apply filter';

  @override
  String get searchText => 'Search...';

  @override
  String get getStartedText => 'Get Started';

  @override
  String get validate => 'Validate';

  @override
  String get validateAIAnswerText => 'Validate AI Answer';

  @override
  String get validateAIAnsweTicketrText => 'Do you want to Validate AI Answer for this ticket?';

  @override
  String get ticketIDText => 'Ticket ID:';

  @override
  String get ticketDescriptionText => 'Ticket Description:';

  @override
  String get answerStatusText => 'Answer Status:';

  @override
  String get aiValidationStatusText => 'Validation Status:';

  @override
  String get aiAnswerValidationSuccessfullyText => 'AI Answer Validated Successfully!';

  @override
  String get aiAnswerValidationFailureText => 'Failed Validating AI Answer !';

  @override
  String get answerEditedStatusText => 'Answer Edited Status:';

  @override
  String get aIQueryAnswerText => 'AI Query Answer:';

  @override
  String get exportSuccessfullyText => 'CSV Downloaded Successfully!';

  @override
  String get exportFailureText => 'CSV Downloading Failed!';

  @override
  String get editText => 'Edit';

  @override
  String get title => 'Support Bot';

  @override
  String get ticketClassification => 'Ticket Classification';

  @override
  String get aiQueryAnswer => 'AI Query Answer';

  @override
  String get spam => 'Spam/Marketing';

  @override
  String get noActionRequired => 'No Action Required';

  @override
  String get genuineQuery => 'Genuine Query';

  @override
  String get acknowledgementRequired => 'Acknowledgement Required';

  @override
  String get day => 'Day';

  @override
  String get month => 'Month';

  @override
  String get classification => 'AI Classification';

  @override
  String get validation => 'Validation';

  @override
  String get export => 'Export CSV File';

  @override
  String get save => 'Save';

  @override
  String get revert => 'Revert';

  @override
  String get view => 'View';

  @override
  String get emailValidations => 'Email Validation Details';

  @override
  String get comments => 'Please enter your comments';

  @override
  String get cancel => 'Cancel';

  @override
  String get id => 'ID';

  @override
  String get ticketDescription => 'Ticket Description';

  @override
  String get reasoning => 'Reasoning';

  @override
  String get validationReason => 'Validation Reason';

  @override
  String get actions => 'Actions';

  @override
  String get status => 'Status';

  @override
  String get revertSuccess => 'Ticket stage reverted successfully';

  @override
  String get noRevert => 'No changes to revert.';

  @override
  String get revertClassifcation => 'This classification does not support revert feature';

  @override
  String get changeClassifcation => 'Change Classification';

  @override
  String get statusUpdated => 'Update Status';

  @override
  String get ok => 'Ok';

  @override
  String get aIClassification => 'AI Classification';

  @override
  String get ackRequired => 'Acknowledge Required';

  @override
  String get link => 'Link';

  @override
  String get genuineQueryText => 'Genuine Query';

  @override
  String get acknowledgeRequiredText => 'Acknowledgement Required';

  @override
  String get spamMarketing => 'Spam/Marketing';

  @override
  String get noItemsText => 'No items available.';

  @override
  String get ticketsAnswerText => 'Tickets Answer: ';

  @override
  String get ticketsNotAnswerText => 'Tickets Not Answer:';

  @override
  String get aiTicketsAnswerText => 'AI Tickets Answer';

  @override
  String get ticketNotEditedText => 'Ticket Not Edited:';

  @override
  String get ticketEditedText => 'Ticket Edited:';

  @override
  String get aiTicketsEditedText => 'AI Tickets Edited';

  @override
  String get userValidationText => 'User Validation';

  @override
  String get oKText => 'OK';

  @override
  String get actualClassification => 'Actual Classification';

  @override
  String get validationStatusText => 'Validation Status';

  @override
  String get ticketUnableClassify => 'Unable to Classify';

  @override
  String get somethingWentWrongText => 'Something Went Wrong';

  @override
  String get validatedTicketsText => 'Validated Tickets';

  @override
  String get validatedTicketsPercentageText => 'Validated Tickets';

  @override
  String get totalTicketsText => 'Total Tickets';

  @override
  String get totalTicketsPercentageText => 'Total Tickets';

  @override
  String get pipelineText => 'Pipeline';

  @override
  String get totalText => 'Total';

  @override
  String get totalCountText => 'Total Count';

  @override
  String get validatedCountText => 'Validated Count';

  @override
  String get validatedPercentageText => 'Validated Percentage';

  @override
  String get userValidationCountText => 'User Validation Count';

  @override
  String get awaitingToClassifyText => 'Awaiting to Classify';

  @override
  String get aIAccuracyText => 'AI Accuracy';

  @override
  String get piplineInfoToolTipText => 'Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown.';

  @override
  String get autoCloseText => 'Auto-Close';

  @override
  String get correctText => 'Correct';

  @override
  String get incorrectText => 'Incorrect';

  @override
  String get aiResponseStatText => 'AI Response Stats';

  @override
  String totalResponsesTooltip(Object totalResponses, Object percentage, Object correctIncorrectText) {
    return ' Responses: $totalResponses\nPercentage: $percentage% \n $correctIncorrectText';
  }

  @override
  String get signInPageTextPart1 => 'By clicking “GET STARTED” you are agreeing to our ';

  @override
  String get signInPageTextPart2 => 'Privacy Policy,';

  @override
  String get signInPageTextPart3 => ' our ';

  @override
  String get signInPageTextPart4 => 'Terms & Conditions';

  @override
  String get signInPageText => 'Enter the email and the name that was used on your join application.';

  @override
  String v3OnboardingLoginJoinEmailSentSubtitle(Object email) {
    return 'We’ve sent a link for your joining application to $email. Click the link to kick-start your application process.';
  }

  @override
  String get signInPageTextPart5 => ' as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed.';

  @override
  String get fromJoinAppTitle => 'From Join App';

  @override
  String get fromJoinAppDownloadTitle => 'Download MyeXp app to get the latest updates about your application';

  @override
  String get fromJoinAppOrTitle => 'or';

  @override
  String get fromJoinAppSignInButtonTitle => 'Continue on Web';

  @override
  String get intialpipelineText => 'Expert Care Level 1';

  @override
  String get bobStateText => 'BOPS State/ Province';

  @override
  String get unknownPipelineText => 'Unknown Pipeline';

  @override
  String get updateSuccessfullyText => 'Update Successfully!';

  @override
  String get updateFailureText => 'Update Failure!';

  @override
  String get revertedSuccessfullyText => 'Reverted Successfully';

  @override
  String get revertedFailureText => 'Reverted Failure';

  @override
  String get updateText => 'Update';

  @override
  String get updateTicketText => 'Update Ticket';

  @override
  String requestMsgText(Object value) {
    return 'Do you Want to Mark This Ticket as a Contact $value in HubSpot';
  }

  @override
  String get noText => 'No';

  @override
  String get yesText => 'Yes';

  @override
  String get ticketDetailsText => 'Ticket Details';

  @override
  String get descriptionText => 'Description';

  @override
  String get reasoningText => 'Reasoning';

  @override
  String get validatedByText => 'Validated By';

  @override
  String get classificationValidationReasonText => 'Classification Validation Reason';

  @override
  String get closeText => 'Close';

  @override
  String get validatedClassificationText => 'Validated Classification';

  @override
  String get validatedUserText => 'Validated User';

  @override
  String get noDataFoundText => 'No Data Found';

  @override
  String get noUserAvailableText => 'No User Available';

  @override
  String get noStateAvailableText => 'No State/Province Available';

  @override
  String get reasonAndSelectClassificationText => 'Please provide reason and select classification';

  @override
  String get noSelectionText => 'No selection';

  @override
  String get exportCSVFileText => 'Export CSV File';

  @override
  String get ticketUpdatedCorrectText => 'Ticket Validated As Correct';

  @override
  String get ticketUpdatedInCorrectText => 'Ticket Validated As Incorrect';
}

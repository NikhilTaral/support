// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) =>
      "Do you Want to Mark This Ticket as a Contact ${value} in HubSpot";

  static String m1(totalResponses, percentage, correctIncorrectText) =>
      " Responses: ${totalResponses}\nPercentage: ${percentage}% \n ${correctIncorrectText}";

  static String m2(email) =>
      "We’ve sent a link for your joining application to ${email}. Click the link to kick-start your application process.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aIAccuracyText": MessageLookupByLibrary.simpleMessage("AI Accuracy"),
        "aIClassification":
            MessageLookupByLibrary.simpleMessage("AI Classification"),
        "aIQueryAnswerText":
            MessageLookupByLibrary.simpleMessage("AI Query Answer:"),
        "aPIErrorMsgText": MessageLookupByLibrary.simpleMessage(
            "Error fetching data from server"),
        "ackRequired":
            MessageLookupByLibrary.simpleMessage("Acknowledge Required"),
        "acknowledgeRequiredText":
            MessageLookupByLibrary.simpleMessage("Acknowledgement Required"),
        "acknowledgementRequired":
            MessageLookupByLibrary.simpleMessage("Acknowledgement Required"),
        "actions": MessageLookupByLibrary.simpleMessage("Actions"),
        "actualClassification":
            MessageLookupByLibrary.simpleMessage("Actual Classification"),
        "aiAnswerValidationFailureText": MessageLookupByLibrary.simpleMessage(
            "Failed Validating AI Answer !"),
        "aiAnswerValidationSuccessfullyText":
            MessageLookupByLibrary.simpleMessage(
                "AI Answer Validated Successfully!"),
        "aiQueryAnswer":
            MessageLookupByLibrary.simpleMessage("AI Query Answer"),
        "aiResponseStatText":
            MessageLookupByLibrary.simpleMessage("AI Response Stats"),
        "aiTicketsAnswerText":
            MessageLookupByLibrary.simpleMessage("AI Tickets Answer"),
        "aiTicketsEditedText":
            MessageLookupByLibrary.simpleMessage("AI Tickets Edited"),
        "aiValidationStatusText":
            MessageLookupByLibrary.simpleMessage("Validation Status:"),
        "answerEditedStatusText":
            MessageLookupByLibrary.simpleMessage("Answer Edited Status:"),
        "answerStatusText":
            MessageLookupByLibrary.simpleMessage("Answer Status:"),
        "autoCloseText": MessageLookupByLibrary.simpleMessage("Auto-Close"),
        "awaitingToClassifyText":
            MessageLookupByLibrary.simpleMessage("Awaiting to Classify"),
        "bobStateText":
            MessageLookupByLibrary.simpleMessage("BOPS State/ Province"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeClassifcation":
            MessageLookupByLibrary.simpleMessage("Change Classification"),
        "classification":
            MessageLookupByLibrary.simpleMessage("AI Classification"),
        "classificationValidationReasonText":
            MessageLookupByLibrary.simpleMessage(
                "Classification Validation Reason"),
        "closeText": MessageLookupByLibrary.simpleMessage("Close"),
        "comments":
            MessageLookupByLibrary.simpleMessage("Please enter your comments"),
        "correctText": MessageLookupByLibrary.simpleMessage("Correct"),
        "day": MessageLookupByLibrary.simpleMessage("Day"),
        "descriptionText": MessageLookupByLibrary.simpleMessage("Description"),
        "editText": MessageLookupByLibrary.simpleMessage("Edit"),
        "emailValidations":
            MessageLookupByLibrary.simpleMessage("Email Validation Details"),
        "export": MessageLookupByLibrary.simpleMessage("Export CSV File"),
        "exportCSVFileText":
            MessageLookupByLibrary.simpleMessage("Export CSV File"),
        "exportFailureText":
            MessageLookupByLibrary.simpleMessage("CSV Downloading Failed!"),
        "exportSuccessfullyText": MessageLookupByLibrary.simpleMessage(
            "CSV Downloaded Successfully!"),
        "filterApplySnackBarText": MessageLookupByLibrary.simpleMessage(
            "Please select a pipeline to apply filter"),
        "filterApplyText": MessageLookupByLibrary.simpleMessage("Apply Filter"),
        "filterClearText":
            MessageLookupByLibrary.simpleMessage("Clear Filters"),
        "fromJoinAppDownloadTitle": MessageLookupByLibrary.simpleMessage(
            "Download MyeXp app to get the latest updates about your application"),
        "fromJoinAppOrTitle": MessageLookupByLibrary.simpleMessage("or"),
        "fromJoinAppSignInButtonTitle":
            MessageLookupByLibrary.simpleMessage("Continue on Web"),
        "fromJoinAppTitle":
            MessageLookupByLibrary.simpleMessage("From Join App"),
        "genuineQuery": MessageLookupByLibrary.simpleMessage("Genuine Query"),
        "genuineQueryText":
            MessageLookupByLibrary.simpleMessage("Genuine Query"),
        "getStartedText": MessageLookupByLibrary.simpleMessage("Get Started"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "incorrectText": MessageLookupByLibrary.simpleMessage("Incorrect"),
        "intialpipelineText":
            MessageLookupByLibrary.simpleMessage("Expert Care Level 1"),
        "itemsPerPageText":
            MessageLookupByLibrary.simpleMessage("Items per page:   "),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "noActionRequired":
            MessageLookupByLibrary.simpleMessage("No Action Required"),
        "noDataFoundText":
            MessageLookupByLibrary.simpleMessage("No Data Found"),
        "noItemsText":
            MessageLookupByLibrary.simpleMessage("No items available."),
        "noRevert":
            MessageLookupByLibrary.simpleMessage("No changes to revert."),
        "noSelectionText": MessageLookupByLibrary.simpleMessage("No selection"),
        "noStateAvailableText":
            MessageLookupByLibrary.simpleMessage("No State/Province Available"),
        "noText": MessageLookupByLibrary.simpleMessage("No"),
        "noUserAvailableText":
            MessageLookupByLibrary.simpleMessage("No User Available"),
        "oKText": MessageLookupByLibrary.simpleMessage("OK"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "pageText": MessageLookupByLibrary.simpleMessage("Page"),
        "pipelineText": MessageLookupByLibrary.simpleMessage("Pipeline"),
        "piplineInfoToolTipText": MessageLookupByLibrary.simpleMessage(
            "Displays the percentage of validated tickets out of total tickets for each pipeline—pipelines with zero tickets are not shown."),
        "piplineText": MessageLookupByLibrary.simpleMessage("Pipeline"),
        "reasonAndSelectClassificationText":
            MessageLookupByLibrary.simpleMessage(
                "Please provide reason and select classification"),
        "reasoning": MessageLookupByLibrary.simpleMessage("Reasoning"),
        "reasoningText": MessageLookupByLibrary.simpleMessage("Reasoning"),
        "requestMsgText": m0,
        "revert": MessageLookupByLibrary.simpleMessage("Revert"),
        "revertClassifcation": MessageLookupByLibrary.simpleMessage(
            "This classification does not support revert feature"),
        "revertSuccess": MessageLookupByLibrary.simpleMessage(
            "Ticket stage reverted successfully"),
        "revertedFailureText":
            MessageLookupByLibrary.simpleMessage("Reverted Failure"),
        "revertedSuccessfullyText":
            MessageLookupByLibrary.simpleMessage("Reverted Successfully"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchText": MessageLookupByLibrary.simpleMessage("Search..."),
        "signInPageText": MessageLookupByLibrary.simpleMessage(
            "Enter the email and the name that was used on your join application."),
        "signInPageTextPart1": MessageLookupByLibrary.simpleMessage(
            "By clicking “GET STARTED” you are agreeing to our "),
        "signInPageTextPart2":
            MessageLookupByLibrary.simpleMessage("Privacy Policy,"),
        "signInPageTextPart3": MessageLookupByLibrary.simpleMessage(" our "),
        "signInPageTextPart4":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
        "signInPageTextPart5": MessageLookupByLibrary.simpleMessage(
            " as well as the anonymous recording of the application process for the purposes of improving this website and its performance. No personally identifying information will be recorded or displayed."),
        "somethingWentWrongText":
            MessageLookupByLibrary.simpleMessage("Something Went Wrong"),
        "spam": MessageLookupByLibrary.simpleMessage("Spam/Marketing"),
        "spamMarketing": MessageLookupByLibrary.simpleMessage("Spam/Marketing"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "statusUpdated": MessageLookupByLibrary.simpleMessage("Update Status"),
        "ticketClassification":
            MessageLookupByLibrary.simpleMessage("Ticket Classification"),
        "ticketDescription":
            MessageLookupByLibrary.simpleMessage("Ticket Description"),
        "ticketDescriptionText":
            MessageLookupByLibrary.simpleMessage("Ticket Description:"),
        "ticketDetailsText":
            MessageLookupByLibrary.simpleMessage("Ticket Details"),
        "ticketEditedText":
            MessageLookupByLibrary.simpleMessage("Ticket Edited:"),
        "ticketIDText": MessageLookupByLibrary.simpleMessage("Ticket ID:"),
        "ticketNotEditedText":
            MessageLookupByLibrary.simpleMessage("Ticket Not Edited:"),
        "ticketUnableClassify":
            MessageLookupByLibrary.simpleMessage("Unable to Classify"),
        "ticketUpdatedCorrectText":
            MessageLookupByLibrary.simpleMessage("Ticket Validated As Correct"),
        "ticketUpdatedInCorrectText": MessageLookupByLibrary.simpleMessage(
            "Ticket Validated As Incorrect"),
        "ticketsAnswerText":
            MessageLookupByLibrary.simpleMessage("Tickets Answer: "),
        "ticketsNotAnswerText":
            MessageLookupByLibrary.simpleMessage("Tickets Not Answer:"),
        "title": MessageLookupByLibrary.simpleMessage("Support Bot"),
        "totalCountText": MessageLookupByLibrary.simpleMessage("Total Count"),
        "totalResponsesTooltip": m1,
        "totalText": MessageLookupByLibrary.simpleMessage("Total"),
        "totalTicketsPercentageText":
            MessageLookupByLibrary.simpleMessage("Total Tickets"),
        "totalTicketsText":
            MessageLookupByLibrary.simpleMessage("Total Tickets"),
        "unknownPipelineText":
            MessageLookupByLibrary.simpleMessage("Unknown Pipeline"),
        "updateFailureText":
            MessageLookupByLibrary.simpleMessage("Update Failure!"),
        "updateSuccessfullyText":
            MessageLookupByLibrary.simpleMessage("Update Successfully!"),
        "updateText": MessageLookupByLibrary.simpleMessage("Update"),
        "updateTicketText":
            MessageLookupByLibrary.simpleMessage("Update Ticket"),
        "userValidationCountText":
            MessageLookupByLibrary.simpleMessage("User Validation Count"),
        "userValidationText":
            MessageLookupByLibrary.simpleMessage("User Validation"),
        "v3OnboardingLoginJoinEmailSentSubtitle": m2,
        "validate": MessageLookupByLibrary.simpleMessage("Validate"),
        "validateAIAnsweTicketrText": MessageLookupByLibrary.simpleMessage(
            "Do you want to Validate AI Answer for this ticket?"),
        "validateAIAnswerText":
            MessageLookupByLibrary.simpleMessage("Validate AI Answer"),
        "validatedByText": MessageLookupByLibrary.simpleMessage("Validated By"),
        "validatedClassificationText":
            MessageLookupByLibrary.simpleMessage("Validated Classification"),
        "validatedCountText":
            MessageLookupByLibrary.simpleMessage("Validated Count"),
        "validatedPercentageText":
            MessageLookupByLibrary.simpleMessage("Validated Percentage"),
        "validatedTicketsPercentageText":
            MessageLookupByLibrary.simpleMessage("Validated Tickets"),
        "validatedTicketsText":
            MessageLookupByLibrary.simpleMessage("Validated Tickets"),
        "validatedUserText":
            MessageLookupByLibrary.simpleMessage("Validated User"),
        "validation": MessageLookupByLibrary.simpleMessage("Validation"),
        "validationReason":
            MessageLookupByLibrary.simpleMessage("Validation Reason"),
        "validationStatusText":
            MessageLookupByLibrary.simpleMessage("Validation Status"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "yesText": MessageLookupByLibrary.simpleMessage("Yes")
      };
}

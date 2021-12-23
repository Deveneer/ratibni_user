class ApiErrors {
  // Error Status Code = null.
  static const String noInternet = 'Network Error!';
  static const String noInternetDetails = 'No Internet Connection.';

  // Error Status Code = 400.
  static const String badRequest = 'Bad Request Error!';
  static const String badRequestDetails =
      'Invalid Input. Some inputs are missing while creating a request.';

  // Error Status Code = 401.
  static const String unauthorised = 'Invalid Credentials!';
  static const String unauthorisedDetails =
      'The provided credentials are incorrect. Please try again.';

  // Error Status Code = 403.
  static const String forbidden = 'Forbidden Error!';
  static const String forbiddenDetails =
      "You don't have permission to access resource on this server.";

  // Error Status Code = 404.
  static const String serverNotFound = 'Server Not Found!';
  static const String serverNotFoundDetails =
      "The page you were trying to reach couldn't be found on our server.";

  // Error Status Code = 408.
  static const String serverTimeOut = 'Server Timeout!';
  static const String serverTimeOutDetails =
      'Server timeout. Please try again later.';

  // Error Status Code = 500 to 599.
  static const String serverError = 'Internal Server Error!';
  static const String serverErrorDetails =
      'Something went wrong with the server. Please try again later.';

  // For unidentified errors.
  static const String unknownError = 'Unknown Error Occured!';
  static const String unknownErrorDetails =
      'Something went wrong. Please try again later.';

  static const String sessionExpired = 'Session Expired!';
  static const String sessionExpiredDeatils =
      'Your session has been expired. Please Click login button to login again.';

  static const String invalidBookingDate = 'Invalid booking date!';
  static const String invalidBookingDateDetails =
      "Booking date must be a date after 24 hour from now!";

  static const String passwordsNotMatching = 'Invalid Credentials!';
  static const String passwordsNotMatchingDetails =
      "Password & confirm password doesn't matches. Please enter both passwords again.";
}

class ErrorText {
  static const String emailErrorText = 'Please enter valid email address!';
  static const String firstNameErrorText = 'please enter your first name!';
  static const String lastNameErrorText = 'please enter your last name!';
  static const String phoneNumberErrorText =
      'Please enter correct phone number!';
  static const String otpErrorText = 'OTP must be a 4 digit number!';
  static const String queryErrorText = 'Please write a valid query!';
  static const String passwordErrorText =
      'Password must have 8 Character!.\nTry a mix of letters, numbers and symbols.';
  static const String cameraAccessDenied = 'Camera Access Denied!';
  static const String cameraAccessDeniedDetails =
      'Camera access has been denied, unable to use camera.';

  static const String locationRequired = 'Location Required!';
  static const String locationRequiredDetails =
      'Please enable location to see nearby locations.';
  static const String noDataFound = 'No Data Found.';

  static const String addressErrorText = 'Please enter correct address!';
  static const String landmarkErrorText = 'Please enter correct Landmark!';
  static const String cityErrorText = 'Please enter correct City!';
  static const String stateErrorText = 'Please enter correct State!';
  static const String countryErrorText = 'Please enter correct Country!';
  static const String postalCodeErrorText = 'Please enter correct Postal Code!';
  static const String searchErrorText = "Search can't be empty.";
  static const String searchErrorDetailText = 'Please search a valid word.';
}

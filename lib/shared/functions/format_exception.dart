
// Change the format of exceptions to be more readable
// by removing the 'Exception: ' or 'Error: ' prefix.

String formatException(String e) {

  if (e.startsWith('Exception: ')) {
    return e.toString().substring(11);
  }

  if (e.startsWith('Error: ')) {
    return e.toString().substring(7);
  }
    
  return e;
}
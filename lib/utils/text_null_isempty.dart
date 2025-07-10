String formatOrNA(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'N/A';
  }
  return value;
}

List<String> listItemRemove(List<String> listFiles) {
  int removeBack = listFiles.indexOf('/..');

  if (removeBack > 0) {
    listFiles.removeAt(removeBack);
  }
  int removeCurrent = listFiles.indexOf('/.');
  if (removeCurrent > 0) {
    listFiles.removeAt(removeCurrent);
  }

  return listFiles;
}

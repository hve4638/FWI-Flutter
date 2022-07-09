abstract class Editor {
  add(String name, { bool update, bool noAliasFlag });
  remove(String name, { bool update });
  move(String from, String to);
  save();
}
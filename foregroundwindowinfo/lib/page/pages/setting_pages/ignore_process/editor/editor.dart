abstract class Editor {
  add(String name, String alias, { bool update, bool noAliasFlag });
  remove(String name, { bool update });
  move(String from, String to);
  save();
}
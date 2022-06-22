abstract class FwiConfig {
  int get traceUpdateTime;
  int get timelineUpdateTime;
  int get rankUpdateTime;
  set traceUpdateTime(int value);
  set timelineUpdateTime(int value);
  set rankUpdateTime(int value);
  get readonly;
  save();
  load();
}





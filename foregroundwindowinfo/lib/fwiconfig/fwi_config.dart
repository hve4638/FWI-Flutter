abstract class FwiConfig {
  int get traceUpdateDuration;
  int get timelineUpdateDuration;
  int get rankUpdateDuration;
  int get timelineWriteDuration;
  set traceUpdateDuration(int value);
  set timelineUpdateDuration(int value);
  set rankUpdateDuration(int value);
  set timelineWriteDuration(int value);
  get readonly;
  save();
  load();
}





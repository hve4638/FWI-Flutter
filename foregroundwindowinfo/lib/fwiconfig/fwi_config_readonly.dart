import 'package:wininfo/fwiconfig/fwi_config.dart';

class FwiConfigReadonly {
  final FwiConfig manager;
  FwiConfigReadonly(this.manager);

  get traceUpdateTime => manager.traceUpdateTime;
  get timelineUpdateTime => manager.timelineUpdateTime;
  get rankUpdateTime => manager.rankUpdateTime;
  get readonly => this;
}
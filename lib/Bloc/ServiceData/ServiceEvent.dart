



abstract class ServiceEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class onPressedEvent extends ServiceEvent{
   String headcode;
   String train_uid;
   String origin_location;
   String destination_location;
   String origin_time;
   String destination_time;
   String ota;
   String otd;
   String joining;
   String alightning;
   String delay;
   String comment;

   onPressedEvent(
   {
   required this.headcode,
   required this.train_uid,
   required this.origin_location,
   required this.destination_location,
   required this.origin_time,
   required this.destination_time,
   required  this.ota,
   required this.otd,
   required this.joining,
   required this.alightning,
   required this.delay,
   required this.comment});
   }

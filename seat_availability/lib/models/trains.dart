class Train{
  final String number,name,travelTime,srcDepartureTime,destArrivalTime;
  final Station fromStation,toStation;
  final List<TrainClass> classesList;
  final List<Day> daysList;

  Train({
    this.number,
    this.name,
    this.travelTime,
    this.srcDepartureTime,
    this.destArrivalTime,
    this.fromStation,
    this.toStation,
    this.classesList,
    this.daysList
  });
  
  factory Train.fromJson(Map<String, dynamic> json){
    List<dynamic> tempClassesList = json['classes'] as List;
    List<dynamic> tempDaysList = json['days'] as List;
    return Train(
      number: json['number'],
      name: json['name'],
      travelTime: json['travel_time'],
      srcDepartureTime: json['src_departure_time'],
      destArrivalTime: json['dest_arrival_time'],
      fromStation: Station.fromJson(json['from_station']),
      toStation: Station.fromJson(json['to_station']),
      classesList: tempClassesList.map((i)=>TrainClass.fromJson(i)).toList(),
      daysList: tempDaysList.map((i)=>Day.fromJson(i)).toList(),
    );
  }

}

class Station{
  final String code,name;
  Station({this.code,this.name});

  factory Station.fromJson(Map<String, dynamic> json){
    return Station(
      code: json['code'],
      name: json['name'] 
    );
  }
}

class TrainClass{
  final String code, available,name;
  TrainClass({this.code,this.available,this.name});

  factory TrainClass.fromJson(Map<String, dynamic> json){
    return TrainClass(
      code: json['code'],
      available: json['available'],
      name: json['name'] 
    );
  }

}

class Day{
  final String code, runs;
  Day({this.code,this.runs});

  factory Day.fromJson(Map<String, dynamic> json){
    return Day(
      code: json['code'],
      runs: json['runs'] 
    );
  }

}
class TrainInfo{
  final Train train;
  final List<Available> availableList;
  final Station fromStation,toStation;
  final TrainClass journeyClass;

  TrainInfo({
    this.train,
    this.journeyClass,
    this.fromStation,
    this.toStation,
    this.availableList
  });

  factory TrainInfo.fromJson(Map<String, dynamic> json){
    List<dynamic> tempAvailablesList = json['availability'] as List;
    return TrainInfo(
      train: Train.fromJson(json['train']),
      journeyClass: TrainClass.fromJson(json['journey_class']),
      fromStation: Station.fromJson(json['from_station']),
      toStation: Station.fromJson(json['to_station']),
      availableList: tempAvailablesList.map((i)=>Available.fromJson(i)).toList()
    );
  }
}

class Train{
  final String number,name;//,travelTime,srcDepartureTime,destArrivalTime;
  final List<TrainClass> classesList;
  final List<Day> daysList;

  Train({
    this.number,
    this.name,
    // this.travelTime,
    // this.srcDepartureTime,
    // this.destArrivalTime,
    this.classesList,
    this.daysList
  });
  
  factory Train.fromJson(Map<String, dynamic> json){
    List<dynamic> tempClassesList = json['classes'] as List;
    List<dynamic> tempDaysList = json['days'] as List;
    return Train(
      number: json['number'],
      name: json['name'],
      // travelTime: json['travel_time'],
      // srcDepartureTime: json['src_departure_time'],
      // destArrivalTime: json['dest_arrival_time'],
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

class Available{
  final String date, status;
  Available({this.date,this.status});

  factory Available.fromJson(Map<String, dynamic> json){
    return Available(
      date: json['date'],
      status: json['status'] 
    );
  }
}
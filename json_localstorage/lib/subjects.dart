class Subject{
  String subName;
  int present,absent;
  double percent,criteria;
  Set<String> dateList;

  double get getPercent => present / (present+absent) ;

  Subject({
    this.subName,
    this.present,
    this.absent,
    this.criteria,
    this.dateList
  });

  factory Subject.fromJson(Map<String,dynamic> parsedJson){
    Set<String> mDates = Set.from(parsedJson['dates']);
    return Subject(
      subName: parsedJson['subName'].toString(),
      present: parsedJson['present'],
      absent: parsedJson['absent'],
      criteria: parsedJson['criteria'],
      dateList: mDates
    );
  }
}
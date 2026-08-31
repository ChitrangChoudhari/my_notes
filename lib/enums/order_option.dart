
enum OrderOption{
  dateCreated,
  dateModified;

  String get name{
    return switch(this){
      OrderOption.dateCreated => 'Date Created',
      OrderOption.dateModified => 'Date Modified',
    };
  }
}
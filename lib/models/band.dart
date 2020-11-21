class Band {
  String id;
  String name;
  int votes;

//Creamos el constructor
/*definimos con llave para poder poner nombres */
  Band({this.id, this.name, this.votes});

  //el factory es un constructor que recibe tipo de argumentos y regresa una nueva instacia de mi clase band
  factory Band.fromMap(Map<String, dynamic> obj) => Band(
        id    : obj.containsKey('id')     ?  obj['id']    : 'no-id',//validamos, si cexiste entonces lo esytablece, de lo contrario no hay id
        name  : obj.containsKey('name')   ?  obj['name']  : 'no-names',
        votes : obj.containsKey('votes')  ?  obj['votes'] : 'no-votes',
      );
}

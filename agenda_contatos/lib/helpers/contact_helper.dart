import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

final String contactTable = "contactTable";//nome da tabela
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";


class ContactHelper{ //Terá apenas um objeto desta classe, por isso será utilizado o Singleton
  static final ContactHelper _instance = ContactHelper.internal(); //Objeto da classe, declarado dentro da propria classe,
  //variavel única e não alteravel.
  factory ContactHelper() =>_instance;

  ContactHelper.internal();//construtor interno

  Database _db;

  Future<Database> get db async{
    if(db !=null){
      return db;
    }else{
      _db = await initDb();
      return db;
      }
  }

 Future<Database> initDb() async{ //inicializando o BD
    final databasePath = await getDatabasesPath(); //Retorna uma string futura
    final path = join(databasePath,"contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
      await db.execute("CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT )");
    });
  }
  Future<Contact> saveContact(Contact contact) async{//Função para salvar contado no BD
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());//
    return contact;
  }
  Future<Contact> getContact(int id) async{ //pega o contato do DB, e instancia um objeto.
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable,columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?", whereArgs: [id]);
    if(maps.length > 0) {
      return Contact.fromMap(maps.first);
    }
    else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async{ //Deleta um contato do banco de dados TESTAR COM CONTACT NO LUGAR DO ID
    Database dbContact = await db;
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  updateContact(Contact contact) async{// Update do contato
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(), //pega a instancia do contato editado, e passa para Map
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }
  Future<List> getAllContatc() async{ //pegar todos os contatos
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable"); // retorna uma lista de "linhas"
    List<Contact> listContacts = List();

    for(Map map in listMap){
      listContacts.add(Contact.fromMap(map)); //transforma em instancias de Contato todos os mapas da lista
    }
    return listContacts;
  }
  Future<int> getNumberContacs() async{//pega o número de contatos(dados/linhas) no DB
    Database dbContact = await db;

    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async{//Fecha o DB, o future é usado para evitar erros já que não retorna nada
    Database dbContact = await db;
     dbContact.close();
  }
}
class Contact{
  int id;
  String name;
  String email;
  String phone;
  String img;//como não é possivel armazenar a imagem no sqlite, se armazena o path.

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    img = map[imgColumn];
    phone = map[phoneColumn];
  }
  Map toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)"; //Quando for usado o print(Contato), será exibida as informações do contato
  }
}

import 'package:floor/floor.dart';
import 'package:hypnos/databases/entities/heartrate.dart';


//Here, we are saying that the following class defines a dao.

@dao
abstract class HRDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM HeartRate')
  Future<List<HeartRate>> findAllHR();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertHR(HeartRate heartrate);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteHR(HeartRate task);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateHR(HeartRate heartrate);

}//TodoDao
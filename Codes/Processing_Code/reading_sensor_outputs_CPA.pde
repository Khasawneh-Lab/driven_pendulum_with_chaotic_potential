import processing.serial.*;

Serial myPort;  
String val;     
Table dataTable;
String fileName;

// the number reading you want before writing to a file
int numReadings = 500; 
int readingCounter = 0; 

void setup()
{
  // Define which port Arduino is connected to
  String portName = Serial.list()[2]; 
  //define the port and serial number used in Arduino
  myPort = new Serial(this, portName, 9600);
  
  //generate a new table
  dataTable = new Table();

  //add columns
  dataTable.addColumn("id");
  dataTable.addColumn("year");
  dataTable.addColumn("month");
  dataTable.addColumn("day");
  dataTable.addColumn("hour");
  dataTable.addColumn("minute");
  dataTable.addColumn("second");
  dataTable.addColumn("microseconds");
  dataTable.addColumn("Angle");
  dataTable.addColumn("PG");  
  myPort.bufferUntil('\n'); 

}

void draw()
{
}

void serialEvent(Serial s){
      try{
        //read 
        val = s.readString();
        val = trim(val);
        float sensorVals[] = float(split(val, ',')); 
        
        //adds row for each reading
        TableRow newRow = dataTable.addRow(); 
        newRow.setInt("id", dataTable.lastRowIndex());
        
        //record time stamp
        newRow.setInt("year", year());
        newRow.setInt("month", month());
        newRow.setInt("day", day());
        newRow.setInt("hour", hour());
        newRow.setInt("minute", minute());
        newRow.setInt("second", second());
        //sensor values obtained from Arduino
        newRow.setFloat("microseconds",sensorVals[0]);
        newRow.setFloat("Angle",sensorVals[2]);
        newRow.setFloat("PG",sensorVals[1]);
         
        readingCounter++; 
        
        //save the file when the readings reach to a certain value
        if (readingCounter==50000)
          {
          saveTable(dataTable, "Pendulum Data/data.csv");  
          }
         //println(val,"",readingCounter);
      }
      catch(RuntimeException e) {
      }
  }

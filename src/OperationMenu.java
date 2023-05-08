import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;
import java.time.*;

public class OperationMenu implements Menu{
    private final AptMenu.Tuple record;

    public OperationMenu(AptMenu.Tuple tuple){
        record=tuple;
    }

    @Override
    public boolean displayMenu() {
        System.out.printf("For %s %s\n" +
                "1. Review notes\n" +
                "2. Review tests\n" +
                "3. Add a note\n" +
                "4. Prescribe a test\n" +
                "5. Go back to the appointments.\n\n" +
                "Enter your choice:",record.getName(),record.getMomID());
        return true;
    }

    @Override
    public void runCommand(String command, User U, Statement aStatement) {
        if(command.equals("1"))
            reviewNote(aStatement);
        else if (command.equals("2"))
            reviewTest(aStatement);
        else if (command.equals("3"))
            addNote(aStatement);
        else if (command.equals("4"))
            prescribeTest(aStatement);
        else if(command.equals("5"))
            quitMenu(U);
        else
            System.out.println("Invalid input.");
    }

    @Override
    public void quitMenu(User aUser) {
        aUser.backToPreMenu();
    }

    private void reviewNote(Statement aStatement){
        String query=String.format("SELECT A.date,N.settime,N.description " +
                "FROM Appointment A,Note N " +
                "WHERE A.appid=N.appid AND " +
                "A.cpid = %s AND " +
                "A.numofpreg = %s " +
                "ORDER BY A.date DESC, " +
                "N.settime DESC " +
                "LIMIT 50", record.getCpID(),record.getNumofpreg());
        try {
            ResultSet rs = aStatement.executeQuery(query);
            boolean hasRecord=false;
            System.out.printf("----------\nNotes for %s of pregnancy %s:\n",
                    record.getName(),record.getNumofpreg());
            while(rs.next()){
                hasRecord=true;
                String date=rs.getString("date");
                String time=rs.getString("settime");
                String description=rs.getString("description");
                System.out.printf("%s %s %s\n",date,time,description);
            }
            if(!hasRecord)
                System.out.println("There are no notes for this pregnancy.");
            System.out.println("----------");
        }catch (SQLException e){
            System.out.println("Wrong format of cpid or numofpreg.");
        }
    }
    private void reviewTest(Statement aStatement){
        String query=String.format("SELECT T.prescribedate,T.testtype,T.result " +
                "FROM Test T,MotherTest MT,Appointment A " +
                "WHERE MT.testid=T.testid AND " +
                "MT.motherid = %s AND " +
                "T.appid=A.appid AND " +
                "A.cpid = %s AND " +
                "A.numofpreg = %s " +
                "ORDER BY T.prescribedate DESC ",record.getMomID(),
                record.getCpID(),record.getNumofpreg());
        boolean hasRecord=false;
        try{
            System.out.printf("----------\nTests for %s\'s %s time pregnancy:\n",
                    record.getName(),record.getNumofpreg());
            ResultSet rs= aStatement.executeQuery(query);
            while(rs.next()){
                hasRecord=true;
                String date=rs.getString("prescribedate");
                String type=rs.getString("testtype");
                String result=rs.getString("result");
                if(result==null)
                    result="PENDING";
                System.out.printf("%s [%s] %.50s\n",date,type,result);
            }
            System.out.println("----------");
        }catch (SQLException e){
            System.out.println("An unexpected error occurs.");
            System.out.println("Invalid cpid or numofpreg");
        }
    }

    private void addNote(Statement aStatement){

        System.out.println("Please type your observation:");
        Scanner input=new Scanner(System.in);
        String note=input.nextLine();
        int newID=getNoteID(aStatement);
        DateTimeFormatter dtf=DateTimeFormatter.ofPattern("HH:mm:ss");
        LocalTime localTime = LocalTime.now();
        String query=String.format("INSERT INTO Note(noteid,appid,description,settime) " +
                "VALUES " +
                "(%d,%s,\'%.255s\',\'%s\')",newID,record.getAppID(),note,dtf.format(localTime));
        try{
            aStatement.executeUpdate(query);
            System.out.printf("Note is added already.\n\n");
        }catch (SQLException e){
            System.out.println("Unexpected Error occurs, invalid appid,note or time");
        }
    }

    /**
     * This function is used to find a new id for a new note.
     * @return the unique new id for a test.
     */
    private int getNoteID(Statement aStatement){
        String query="SELECT noteid " +
                "FROM Note ";
        int counter=0;
        try {
            ResultSet rs = aStatement.executeQuery(query);
            while(rs.next())
                counter++;
        }catch(SQLException e){
            System.out.println("Unexpected Error Occurs, wrong noteid.");
        }
        return (counter+1)*5+3;
    }

    private void prescribeTest(Statement aStatement){
        System.out.println("Please enter the type of test:");
        Scanner input=new Scanner(System.in);
        String type=input.nextLine();
        int newId=getTestID(aStatement);
        String insertQuery=String.format("INSERT INTO Test (testid,appid,prescribedate,testtype,teststatus) " +
                "VALUES " +
                "(%d,%s,\'%s\',\'%s\',\'F\')",newId,record.getAppID(),record.getDate(),type);
        String insertMTQuery=String.format("INSERT INTO MotherTest (testid,motherid) " +
                "VALUES " +
                "(%d,%s)",newId,record.getMomID());
        try{
            aStatement.executeUpdate(insertQuery);
            aStatement.executeUpdate(insertMTQuery);
            System.out.printf("Test is prescribed\n\n");
        }catch(SQLException e){
            System.err.println("Unexpected Error Occurs, invalid id,appid,date or test type");
        }
    }
    private int getTestID(Statement aStatement){
        String query="SELECT testid " +
                "FROM TEST ";
        int counter=0;
        try {
            ResultSet rs = aStatement.executeQuery(query);
            while(rs.next())
                counter++;
        }catch(SQLException e){
            System.err.println("Unexpected Error Occurs, wrong testid.");
        }
        return (counter+1)*11+2;
    }
}

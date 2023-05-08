import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

/**
 * This class shows all appointments the midwife have selected with specific date
 * and ask for further command.
 */
public class AptMenu implements Menu{
    private final String aDate;
    private List<Tuple> list;
    private final User aUser;
    public AptMenu(String pDate,Statement aStatement,User U){
        aDate=pDate;
        aUser=U;
        try {
            list = findList(aDate, aStatement, U);
        }catch (SQLException e){
            System.out.println("Not a valid date.");
            quitMenu(U);
        }
    }
    @Override
    public boolean displayMenu() {
        if(list.isEmpty()){
            System.out.println("There are no appointments on the selected date.\n");
            quitMenu(aUser);
            return false;
        }
        int counter=1;
        for(Tuple t : list){
            System.out.printf("%d. %s\n",counter,t.toString());
            counter++;
        }
        System.out.println("\nEnter the appointment number that you would like to work on." +
                "\n\t\t[E] to exit [D] to go to another date :");
        return true;
    }

    @Override
    public void runCommand(String command, User U, Statement aStatement) {
        if(command.equals("E"))
            U.quitProgram();
        else if (command.equals("D"))
            quitMenu(U);
        else{
            try {
                int number = Integer.parseInt(command);
                if (number <= 0 || number > list.size())
                    System.out.println("Invalid input.");
                else {
                    Tuple tempTuple = list.get(number - 1);
                    U.addMenu(new OperationMenu(tempTuple));
                }
            }catch (Exception e){
                System.out.println("Invalid Input.");
            }
        }
    }

    @Override
    public void quitMenu(User aUser) {
        aUser.setSelectedDate(null);
        if(aUser.getCurrentMenu() instanceof AptMenu)
            aUser.backToPreMenu();
    }
    private List<Tuple> findList(String date, Statement aStatement, User U) throws SQLException {
        String query=String.format("SELECT A.time,M.name,A.appid,P.primaryid,C.cpid,M.hcardid," +
                "P.numofpreg,A.date " +
                "FROM Appointment A,Mother M,Pregnancy P,Couple C " +
                "WHERE " +
                "C.momid = M.hcardid AND " +
                "C.cpid = P.cpid AND " +
                "A.cpid = P.cpid AND " +
                "A.numofpreg = P.numofpreg AND " +
                "A.midwifeid =  "+U.getId()+ " AND " +
                "A.date = \'" + date +"\'"+
                " ORDER BY A.time ");
        List<Tuple> aList=new LinkedList<>();
        try {
            ResultSet rs = aStatement.executeQuery(query);
            while(rs.next()) {
                String midType;
                String time = rs.getString("time");
                String primaryId = rs.getString("primaryid");
                String momName = rs.getString("name");
                String appNum = rs.getString("appid");
                String momId=rs.getString("hcardid");
                String cpId=rs.getString("cpid");
                String numofpreg=rs.getString("numofpreg");
                String appDate=rs.getString("date");
                if (primaryId.equals(U.getId()))
                    midType = "P";
                else
                    midType = "B";
                aList.add(new Tuple(time,midType,momName,appNum,cpId,momId,numofpreg,appDate));
            }
        }catch (SQLException e){throw new SQLException();};
        return aList;
    }

    public static class Tuple{
        private final String appTime;
        private final String midwifeType;
        private final String momName;
        private final String momId;
        private final String appID;
        private final String cpID;
        private final String numofpreg;
        private final String date;
        public Tuple(String time,String type,String name,String appID,String cpID,
                     String momId,String numofpreg,String appDate){
            appTime=time;
            midwifeType=type;
            momName=name;
            date=appDate;
            this.appID=appID;
            this.cpID=cpID;
            this.momId=momId;
            this.numofpreg=numofpreg;
        }
        public String getName(){return momName;};
        public String getAppID(){return appID;};
        public String getTime(){return appTime;};
        public String getType(){return midwifeType;};
        public String getCpID(){return cpID;};
        public String getMomID(){return momId;};
        public String getNumofpreg(){return numofpreg;};
        public String getDate(){return date;};
        @Override
        public String toString() {
            return String.format("%s %s %s %s",appTime.substring(0,5),midwifeType,
                    momName,momId);
        }
    }
}

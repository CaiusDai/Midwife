import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Singleton design pattern
 * This class represent the login menu.
 */
public class LoginMenu implements Menu{
    private static LoginMenu menu=new LoginMenu();
    private LoginMenu(){};

    public static Menu getInstance(){
        return menu;
    }
    @Override
    public boolean displayMenu(){
        System.out.println("Please enter your practitioner id" +
                " [E] to exit:");
        return true;
    }

    @Override
    public void runCommand(String command,User u,Statement aStatement){
        if(command.equals("E")) {
            u.quitProgram();
        }
        else{
            try {
                if (validID(command, aStatement)) {
                    u.setId(command);
                    u.addMenu(DateMenu.getInstance());
                }
                else
                    System.out.println("Invalid input.");
            }catch (SQLException e){
                System.out.println("Invalid input.");
            }
        }
    }


    @Override
    public void quitMenu(User aUser) {
        aUser.quitProgram();
    }

    private boolean validID(String id, Statement aStatement) throws SQLException{
        String query="SELECT * FROM Midwife " +
                "WHERE practitionerid = "+id ;
        try {
            ResultSet rs = aStatement.executeQuery(query);
            return rs.next();
        }catch (SQLException e){
            System.out.println(e.getLocalizedMessage());
            throw new SQLException();
        }
    }

}

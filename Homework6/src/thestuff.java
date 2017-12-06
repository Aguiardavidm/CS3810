
import com.sun.org.apache.xpath.internal.SourceTree;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import java.util.Scanner;


//Problems
//1. output errors to error file error.txt

public class thestuff {

    static String driverLocation = "org.postgresql.Driver";
    static String postgresUrl = "jdbc:postgresql://localhost:5432/homework4";
    static String postgresUser = "david";
    static String posgresPassword = "1234";

    static String errorFile = "C:\\Users\\aguia\\Documents\\MSU Fall 2017\\Databases\\Homework6\\HW6.error.txt";
    static String flightInformation = "C:\\Users\\aguia\\Documents\\MSU Fall 2017\\Databases\\Homework6\\HW6.flight.txt";

    static Scanner reader = new Scanner(System.in);
    static boolean readError = false;
    static String error;
    static String totalError;

    public static void main(String args[]) throws IOException {

        boolean finished = false;
        do {
            System.out.println();
            System.out.println("Enter the corresponding number for the desired action \n1. Enter a new Customer\n2. Enter a flight\n3. Find an existing flight\n4. Exit the program");
            String choice = reader.nextLine();
            switch (choice) {
                case "1":
                    createCustomer();
                    break;
                case "2":
                    createFlight();
                    break;
                case "3":
                    System.out.println("Still in production!");
                    break;
                case "4":
                    System.out.println("Have a great day!");
                    finished = true;
                    break;
                default:
                    System.out.println("Please chose a valid option");
            }
        } while (finished == false);
    }

    //https://stackoverflow.com/questions/14206768/how-to-check-if-a-string-is-numeric
    public static boolean isNumeric(String s) {
        return s != null && s.matches("[-+]?\\d*\\.?\\d+");
    }

    private static void createFlight() {
        String originAnswer = null;
        String destAnswer = null;
        String personPaying = null;
        String personFlying = null;
        String departDate = null;
        String departTime = null;
        String arrivalDateTime = null;

        Connection c;
        Statement stmt;
        int attempts = 0;
        try {
            //Create Database
            Class.forName(driverLocation);
            c = DriverManager.getConnection(postgresUrl, postgresUser, posgresPassword);
            stmt = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            boolean goodAnswer = false;//Did the user give good input?
            ResultSet resultSet;

            //Generate a list of possible departure cities and take input
            do {
                System.out.println("Please type a city for departure from the following list");
                resultSet = stmt.executeQuery("SELECT city_name from city");
                ResultSetMetaData rsmd = resultSet.getMetaData();
                int columnsNumber = rsmd.getColumnCount();

                //Print the result set
                while (resultSet.next()) {
                    for (int i = 1; i <= columnsNumber; i++) {
                        String columnValue = resultSet.getString(i);
                        System.out.print(columnValue + ", ");
                    }

                }
                System.out.println();

                originAnswer = reader.nextLine();

                //Did the user give one of the options
                resultSet.beforeFirst();
                while (resultSet.next()) {
                    if (Objects.equals(resultSet.getString(1), originAnswer))
                        goodAnswer = true;
                    else
                        errorBuilder("The origin city "+ originAnswer + " is not an acceptable input.");

                }
                attempts++;
            }
            while (goodAnswer == false && attempts < 3); //If the user gave bad info go again

            //Ask for a destination city
            goodAnswer = false;
            if (attempts < 3) {
                attempts = 0;
                do {
                    System.out.println("Choose a city to fly to");
                    resultSet = stmt.executeQuery("SELECT dest_city_name FROM routes WHERE origin_city_name = '" + originAnswer + "'");

                    //Print the list of destinations based on the origin
                    while (resultSet.next()) {
                        String columnValue = resultSet.getString(1);
                        System.out.print(columnValue + ", ");
                    }
                    System.out.println("");

                    destAnswer = reader.nextLine();

                    //Did the user give good data
                    resultSet.beforeFirst();
                    while (resultSet.next()) {
                        if (Objects.equals(resultSet.getString(1), destAnswer))
                            goodAnswer = true;
                        else
                            errorBuilder("The destination " +destAnswer + " is not an acceptable input. ");
                    }
                    attempts++;
                } while (goodAnswer == false && attempts < 3);
            }

            goodAnswer = false;
            if (attempts < 3) {
                attempts = 0;
                do {
                    System.out.println("Who will be paying for the flight");
                    resultSet = stmt.executeQuery("SELECT full_name FROM person");

                    //Print the list of people
                    while (resultSet.next()) {
                        String columnValue = resultSet.getString(1);
                        System.out.print(columnValue + ", ");
                    }
                    System.out.println("");

                    personPaying = reader.nextLine();

                    //Did the user give good data
                    resultSet.beforeFirst();
                    while (resultSet.next()) {
                        if (Objects.equals(resultSet.getString(1), personPaying))
                            goodAnswer = true;
                        else
                            errorBuilder(personPaying + " is not an acceptable payment person");
                    }
                    attempts++;
                } while (goodAnswer == false && attempts < 3);
            }

            goodAnswer = false;
            if (attempts < 3) {
                attempts = 0;
                do {
                    System.out.println("Who will be flying on this flight");
                    resultSet = stmt.executeQuery("SELECT full_name FROM person");

                    //Print the list of people
                    while (resultSet.next()) {
                        String columnValue = resultSet.getString(1);
                        System.out.print(columnValue + ", ");
                    }
                    System.out.println("");

                    personFlying = reader.nextLine();

                    //Did the user give good data
                    resultSet.beforeFirst();
                    while (resultSet.next()) {
                        if (Objects.equals(resultSet.getString(1), personFlying))
                            goodAnswer = true;
                        else
                            errorBuilder(personFlying + "is not an acceptable person input");
                    }
                    attempts++;
                } while (goodAnswer == false && attempts < 3);
            }

            goodAnswer = false;
            if (attempts < 3) {
                attempts = 0;
                do {
                    System.out.println("What date would you like to depart (mmddyyyy)");

                    departDate = reader.nextLine();

                    if (isNumeric(departDate) && departDate.length() == 8){
                        goodAnswer = true;
                    }
                    else{
                        errorBuilder("The departure date is invalid.");
                    }
                    attempts++;
                } while (goodAnswer == false && attempts < 3);
            }

            goodAnswer = false;
            if (attempts < 3) {
                attempts = 0;
                do {
                    System.out.println("What time would you like to depart (hhmm) in military time");

                    departTime = reader.nextLine();

                    if (isNumeric(departTime) && departTime.length() == 4) {
                        goodAnswer = true;
                        arrivalDateTime = setArrivalTime(departDate, departTime);
                    }
                    else{
                        errorBuilder("The departure time is invalid.");
                    }
                    attempts++;
                } while (goodAnswer == false && attempts < 3);
            }
            if (attempts <3) {
                String departDateTime = departDate + departTime;

                DateFormat dateFormat = new SimpleDateFormat("ddMMyyyy");
                Date date = new Date();
                String bookingDate = dateFormat.format(date);

                int nextBookingIndex = getLargestFromTable(stmt, "booking_number","flight");
                int nextFlightIndex = getLargestFromTable(stmt,"flight_number","flight");

                String sqlAddress = "INSERT INTO flight (origin_city_name, dest_city_name, booking_number, booking_date, flight_number, departure_time_date, arrival_time_date, payment_person,ticket_person )" +
                        " VALUES ( \'" + originAnswer + "\',\'" + destAnswer + "\', \'" + nextBookingIndex + "\', \'" + bookingDate + "\', \'"+nextFlightIndex+"\', \'"+ departDateTime +"\', \'"+arrivalDateTime+"\', \'"+personPaying+"\', \'"+personFlying+"\');";
                stmt.executeUpdate(sqlAddress);
                System.out.println(personFlying+" added flight from " + originAnswer + " to " + destAnswer + " on " + departDateTime +" with flight number "+ nextFlightIndex);
            }

            if (attempts < 3)
                System.out.println("Data entered correctly");
            else
                errorBuilder("Too many invalid inputs");
            writeToFile(errorFile,totalError);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
    }

    private static int getLargestFromTable(Statement stmt,String colName,String tableName) throws SQLException {
        ResultSet largestIndex = stmt.executeQuery("SELECT max("+colName+") FROM "+tableName+"");
        largestIndex.next();
        String largestIndexString = largestIndex.getString(1);
        return Integer.parseInt(largestIndexString) + 1;
    }

    private static String setArrivalTime(String departDate, String departTime) {
        String arrivalDateTime;
        int arrivalDay = Integer.parseInt(departDate.substring(2, 4));
        int arrivalHour = Integer.parseInt(departTime.substring(0, 2)) + 10;
        String stringArrivalHour = String.valueOf(arrivalHour);
        if (arrivalHour > 24) {
            arrivalHour = arrivalHour - 24;
            stringArrivalHour = '0'+ String.valueOf(arrivalHour);
            arrivalDay = arrivalDay + 1;
        }
        String stringArrivalTime;
        if (arrivalDay < 10)
            stringArrivalTime = '0'+ String.valueOf(arrivalDay);
        else
            stringArrivalTime = String.valueOf(arrivalDay);
        arrivalDateTime = departDate.substring(0,2) + stringArrivalTime+ departDate.substring(4) + stringArrivalHour + departTime.substring(2);
        return arrivalDateTime;
    }

    private static Customer createCustomer() throws IOException {
        Customer newCust;
        String firstname = "";
        String lastname = "";
        String address = "";
        String city = "";
        String state = "";
        String zipcode = "";
        String phone = "";
        String email = "";
        readError = true;
        int custAttempts = 0;

        while (readError == true && custAttempts < 3) {
            readError = false;
            error = "";

            firstname = askFirstName();
            lastname = askLastName();
            address = askStreetAddress();
            city = askCityAddress();
            state = askState();
            zipcode = askZipCode();
            phone = askPhone();
            email = askEmail();

            if (readError == true) {
                errorBuilder("\nRead Error \n------------------------------\n Please Try Again\n");
                custAttempts++;
            }
        }

        if (custAttempts <3){
            writeToFile(errorFile, totalError);
        }

        newCust = new Customer(firstname, lastname, address, city, state, zipcode, phone, email);
        //newCust = new Customer("Bill", "Wick", "69 Kickass Ave", "Littleton", "CO", "80124","30308976543","Hello@world.com");
        System.out.println(firstname + lastname + address + city + state + zipcode + phone + email);

        if (newCust.isNull() == false) {
            Connection c;
            Statement stmt;
            try {
                Class.forName(driverLocation);
                c = DriverManager.getConnection(postgresUrl, postgresUser, posgresPassword);
                stmt = c.createStatement();
                int nextAddressIndex = getLargestFromTable(stmt,"address_id","address");

                String sqlAddress = "INSERT INTO address (address_id, street, city, state, postal_code)" +
                        " VALUES ( " + nextAddressIndex + ", \'" + newCust.getAddress() + "\',\'" + newCust.getCity() + "\' , \'" + newCust.getState() + "\',\'" + newCust.getZipcode() + "\');";
                stmt.executeUpdate(sqlAddress);

                stmt = c.createStatement();
                String sqlPerson = "INSERT INTO person (full_name, first_name,last_name, mailing_address_id,phone_number)" +
                        " VALUES (\'" + newCust.getFirstname() + " " + newCust.getLastname() + "\' , \'" + newCust.getFirstname() + "\' , \'"
                        + newCust.getLastname() + "\' , \'" + nextAddressIndex + "\' , \'" + newCust.getPhone() + "\');";
                stmt.executeUpdate(sqlPerson);
                System.out.println("Customer successfully created");

            } catch (Exception e) {
                e.printStackTrace();
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }
        }
        readError = false;
        return newCust;
    }

    private static String askEmail() {
        String email;

        System.out.println("Please enter your email address");
        email = reader.nextLine();

        if (email.indexOf("@") == -1 || email.indexOf('.') < email.indexOf("@")) {
            String emailError;
            if (email.indexOf('@') == -1)
                emailError = "does not contain an @ symbol.";
            else if (email.indexOf('.') == -1)
                emailError = "does not contain a period.";
            else if (email.indexOf('.') < email.indexOf('@'))
                emailError = "does not have a period after the @ symbol.";
            else
                emailError = "and that is pretty fucked up.";
            readError = true;
            error = (error + "The entered email " + emailError + " \n");
            errorBuilder("The entered email " + emailError + " \n");
        }
        return email;
    }

    private static String askPhone() {
        System.out.println("Please enter your full 10 digit phone number with only the digits");
        String phone = reader.nextLine();
        if (!isNumeric(phone)) {
            error = (error + "The phone number must be a number \n");
            errorBuilder("The phone number must be a number \n");
            readError = true;
        }
        return phone;
    }

    private static String askZipCode() {
        System.out.println("Please enter your zip code");
        String zip = reader.nextLine();
        if (!isNumeric(zip)) {
            error = (error + "The zipcode must be a number \n");
            readError = true;
            errorBuilder("The zipcode must be a number \n");
        }
        if (zip.length() != 5) {
            error = (error + "The zipcode must be 5 numbers");
            readError = true;
            errorBuilder("The zipcode must be 5 numbers");
        }
        return zip;
    }

    private static String askState() {
        System.out.println("Please enter your state");
        return reader.nextLine();
    }

    private static String askCityAddress() {
        System.out.println("Please enter your city");
        return reader.nextLine();
    }

    private static String askStreetAddress() {
        System.out.println("Please enter your street address (do not enter the city, state or zip)");
        return reader.nextLine();
    }

    private static String askLastName() {
        System.out.println("Please enter your Last Name");
        return reader.nextLine();
    }

    private static String askFirstName() {
        System.out.println("Please enter your First Name:");
        return reader.nextLine();
    }

    private static void errorBuilder(String errorInput){
        totalError = totalError + errorInput + '\n';
        System.out.println(errorInput);
    }

    private static void writeToFile(String fileName, String str) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
        writer.write(str);

        writer.close();
    }
}
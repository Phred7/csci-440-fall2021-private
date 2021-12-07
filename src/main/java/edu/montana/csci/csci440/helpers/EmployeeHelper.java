package edu.montana.csci.csci440.helpers;

import edu.montana.csci.csci440.model.Employee;
import edu.montana.csci.csci440.util.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class EmployeeHelper {

    public static String makeEmployeeTree() {
        // TODO, change this to use a single query operation to get all employees
        Employee employee = Employee.find(1); // root employee
        // and use this data structure to maintain reference information needed to build the tree structure
        Map<Long, List<Employee>> employeeMap = new HashMap<>(); // list is the list of who this employee reports to

        List<Employee> allEmployees = Employee.all();

        for(Employee currentEmployee : allEmployees){
            Long reportsTo = currentEmployee.getReportsTo();
            if (reportsTo == null){ // may be null instead
                employeeMap.put(currentEmployee.getEmployeeId(), new ArrayList<Employee>());
            } else {
                List<Employee> employees = employeeMap.get(reportsTo); //this is a list containing all the employees that have the employee reportsTo as a boss
                if(employees == null) {
                    List<Employee> c_e = new ArrayList<>();
                    c_e.add(currentEmployee);
                    employeeMap.put(reportsTo, c_e);
                } else {
                    employees.add(currentEmployee);
                }
                employeeMap.put(currentEmployee.getEmployeeId(), new ArrayList<>());
//                List<Employee> supervisors = new ArrayList<>();
//                supervisors.add(allEmployees.get(reportsTo.intValue()));
//                if (employees == null){
//
//                } else {
//
//                }
//                Employee boss = allEmployees.get(reportsTo.intValue());
//                System.out.println(currentEmployee.getFirstName());
//                System.out.println(boss.getFirstName());
            }
        }

        return "<ul>" + makeTree(employee, employeeMap) + "</ul>";
    }

//    // TODO - currently this method just uses the employee.getReports() function, which
//    //  issues a query.  Change that to use the employeeMap variable instead
//    public static String makeTree(Employee employee, Map<Long, List<Employee>> employeeMap) {
//        String list = "<li><a href='/employees" + employee.getEmployeeId() + "'>"
//                + employee.getEmail() + "</a><ul>";
//        List<Employee> reports = employee.getReports();
//        for (Employee report : reports) {
//            list += makeTree(report, employeeMap);
//        }
//        System.out.println(list);
//        return list + "</ul></li>";
//    }

    public static String makeTree(Employee employee, Map<Long, List<Employee>> employeeMap) {
        try (Connection conn = DB.connect();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM employees")) {
            ResultSet results = stmt.executeQuery();
            List<Employee> resultList = new LinkedList<>();
            while (results.next()) {
                // employeeMap.put(results.getLong("EmployeeId"), ); //TODO
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
        String list = "<li><a href='/employees" + employee.getEmployeeId() + "'>"
                + employee.getEmail() + "</a><ul>";
        List<Employee> reports = employeeMap.get(employee.getEmployeeId());
        for (Employee report : reports) {
            list += makeTree(report, employeeMap);
        }
        System.out.println(list);
        return list + "</ul></li>";
    }
}

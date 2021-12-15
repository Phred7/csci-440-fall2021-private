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

        for (Employee currentEmployee : allEmployees) {
            Long reportsTo = currentEmployee.getReportsTo();
            employeeMap.put(currentEmployee.getEmployeeId(), null);
            if (reportsTo != 0) {
                List<Employee> employees = employeeMap.get(reportsTo);
                if (employees == null) {
                    employees = new ArrayList<>();
                }
                employees.add(currentEmployee);
                employeeMap.put(reportsTo, employees);
            }
        }

        return "<ul>" + makeTree(employee, employeeMap) + "</ul>";
    }

    public static String makeTree(Employee employee, Map<Long, List<Employee>> employeeMap) {
        StringBuilder list = new StringBuilder("<li><a href='/employees" + employee.getEmployeeId() + "'>" + employee.getEmail() + "</a><ul>");
        List<Employee> subordinates = employeeMap.get(employee.getEmployeeId());
        if(subordinates != null) {
            for (Employee subordinate : subordinates) {
                list.append(makeTree(subordinate, employeeMap));
            }
        }
        return list + "</ul></li>";
    }
}

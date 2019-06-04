package it.unipd.dei.webapp.rest;

import it.unipd.dei.webapp.database.*;
import it.unipd.dei.webapp.resource.*;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Manages all the REST API of the application.
 */
public final class EmployeeRestResource extends RestResource {

	/**
	 * Creates a new REST resource for managing employee resources.
	 */
	public EmployeeRestResource(final HttpServletRequest req, final HttpServletResponse res, Connection con) {
		super(req, res, con);
	}
	
	// List all the employees
	public void listEmployee() throws IOException {

		List<Employee> el  = null;
		Message m = null;

		try{
			// Creates a new object for accessing the database and lists all the employees
			el = new ListEmployeeDatabase(con).listEmployee();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// It should not happen
				m = new Message("Cannot list employees: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search employee: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
	
	// List all the shift of an employee
	public void listEmployeeShift() throws IOException {

		List<TimeSlot> el  = null;
		Message m = null;
		
		try{
			
			// parse the URI path to extract the fiscal code
			String path = req.getRequestURI();
			path = path.substring(path.lastIndexOf("timeslot") + 8);

			final String fiscalCode = path.substring(1);
			
			// Creates a new object for accessing the database and lists all the employees
			el = new SearchTimeSlotByFiscalCodeDatabase(con, fiscalCode).searchTimeSlotByFiscalCode();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list timeslots of the employee: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search employee's fiscal code for timeslot: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
	
	// List all the projects
	public void listProject() throws IOException {

		List<Employee> el  = null;
		Message m = null;
		/*
		try{
			// Creates a new object for accessing the database and lists all the employees
			el = new ListEmployeeDatabase(con).listEmployee();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list employees: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search employee: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}*/
	}
	
	// List all the active projects
	public void listActiveProject() throws IOException {

		List<Employee> el  = null;
		Message m = null;
		/*
		try{
			// Creates a new object for accessing the database and lists all the employees
			el = new ListEmployeeDatabase(con).listEmployee();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list employees: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search employee: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}*/
	}
	
	// List all the task of a specific project
	public void listTask() throws IOException {

		List<TimeSlot> el  = null;
		Message m = null;
		/*
		try{
			// Creates a new object for accessing the database and lists all the employees
			el = new ListEmployeeDatabase(con).listEmployee();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list employees: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search employee: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}*/
	}

	/**
	 * Searches employees by their salary.
	public void searchEmployeeBySalary()  throws IOException {

		List<Employee> el  = null;
		Message m = null;

		try{
			// parse the URI path to extract the salary
			String path = req.getRequestURI();
			path = path.substring(path.lastIndexOf("salary") + 6);

			final int salary = Integer.parseInt(path.substring(1));


			// creates a new object for accessing the database and search the employees
			el = new SearchEmployeeBySalaryDatabase(con, salary).searchEmployeeBySalary();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot search employee: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search employee: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}*/
}

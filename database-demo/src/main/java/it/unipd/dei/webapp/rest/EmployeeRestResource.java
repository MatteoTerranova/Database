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
			
			// Extract data from URL
			final String fiscalCode = path.substring(1,path.lastIndexOf("fromdate") - 1);
			final String fromDate = path.substring((path.lastIndexOf("fromdate") + 9), (path.lastIndexOf("todate") - 1));
			final String toDate = path.substring(path.lastIndexOf("todate") + 7);
			
			//final SearchRange range =  SearchRange.fromJSON(req.getInputStream());
			final SearchRange range = new SearchRange(fromDate, toDate);
			
			// Creates a new object for accessing the database and lists all the employees
			el = new SearchTimeSlotByFiscalCodeDatabase(con, fiscalCode, range.getFromDate(), range.getToDate()).searchTimeSlotByFiscalCode();
			
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
			m = new Message("Cannot search employee's fiscal code for timeslot: unexpected error. ", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
	
	// Create a new shif of an employee
	public void createEmployeeShift() throws IOException {

		TimeSlot el = null;
		Message m = null;
		
		try{
			
			final TimeSlot timeslot = TimeSlot.fromJSON(req.getInputStream());
			
			// Create a new object for accessing the database
			el = new CreateTimeSlotDatabase(con, timeslot).createTimeSlot();
			
			if(el != null) {
				res.setStatus(HttpServletResponse.SC_CREATED);
				el.toJSON(res.getOutputStream());
			} else {
				// It should not happen
				m = new Message("Cannot create the employee's timeshift: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			if (t instanceof SQLException && ((SQLException) t).getSQLState().equals("23505")) {
				m = new Message("Cannot create the employee's timeslot: it already exists.", "E5A2", t.getMessage());
				res.setStatus(HttpServletResponse.SC_CONFLICT);
				m.toJSON(res.getOutputStream());
			} else {
				m = new Message("Cannot create the employee's timeslot: unexpected error.", "E5A1", t.getMessage());
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		}
	}
}

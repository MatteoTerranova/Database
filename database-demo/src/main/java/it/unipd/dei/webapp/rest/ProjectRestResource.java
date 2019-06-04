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
 * Manages the project REST API of the application.
 */
public final class ProjectRestResource extends RestResource {

	/**
	 * Creates a new REST resource for managing project resources.
	 */
	public ProjectRestResource(final HttpServletRequest req, final HttpServletResponse res, Connection con) {
		super(req, res, con);
	}
	
	// List all the projects
	public void listProject() throws IOException {

		List<Project> el  = null;
		Message m = null;
	
		try{
			// Creates a new object for accessing the database and lists all the projects
			el = new ListProjectDatabase(con).listProject();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list projects: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search projects: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
	
	// List all the active projects
	public void listActiveProject() throws IOException {

		List<Project> el  = null;
		Message m = null;
		
		try{
			// Creates a new object for accessing the database and lists all the active projects
			el = new ListActiveProjectDatabase(con).listActiveProject();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list active projects: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search active projects: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
	
	// List all the task of a specific project
	public void listTask() throws IOException {

		List<Task> el  = null;
		Message m = null;
		
		try{
			// parse the URI path to extract the project uuid
			String path = req.getRequestURI();
			String uuid = path.substring(path.lastIndexOf("project") + 8, path.lastIndexOf("task") -1);
			
			// Creates a new object for accessing the database and lists all the employees
			el = new ListTaskDatabase(con, uuid).listTask();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// it should not happen
				m = new Message("Cannot list tasks: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search tasks: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
}

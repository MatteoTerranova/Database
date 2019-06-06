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
public final class DocumentRestResource extends RestResource {

	/**
	 * Creates a new REST resource for managing document resources.
	 */
	public DocumentRestResource(final HttpServletRequest req, final HttpServletResponse res, Connection con) {
		super(req, res, con);
	}
	
	// List all the documents
	public void listDocument() throws IOException {

		List<Document> el  = null;
		Message m = null;

		try{
			// Creates a new object for accessing the database and lists all the documents
			el = new ListDocumentDatabase(con).listDocument();

			if(el != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				new ResourceList(el).toJSON(res.getOutputStream());
			} else {
				// It should not happen
				m = new Message("Cannot list documents: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot search document: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}

	public void createDocument() throws IOException {

		Document el = null;
		Message m = null;
		
		try{
			
			final Document document = Document.fromJSON(req.getInputStream());
			
			// Create a new object for accessing the database
			el = new CreateDocumentDatabase(con, document).createDocument();
			
			if(el != null) {
				res.setStatus(HttpServletResponse.SC_CREATED);
				el.toJSON(res.getOutputStream());
			} else {
				// It should not happen
				m = new Message("Cannot create the document: unexpected error.", "E5A1", null);
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			if (t instanceof SQLException && ((SQLException) t).getSQLState().equals("23505")) {
				m = new Message("Cannot create the document: it already exists.", "E5A2", t.getMessage());
				res.setStatus(HttpServletResponse.SC_CONFLICT);
				m.toJSON(res.getOutputStream());
			} else {
				m = new Message("Cannot create the document: unexpected error.", "E5A1", t.getMessage());
				res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				m.toJSON(res.getOutputStream());
			}
		}
	}

	public void readDocument() throws IOException {

		Document e  = null;
		Message m = null;

		try{
			// parse the URI path to extract the id
			String path = req.getRequestURI();
			path = path.substring(path.lastIndexOf("document") + 8);

			final String id = path.substring(1);


			// creates a new object for accessing the database and reads the document
			e = new ReadDocumentDatabase(con, id).readDocument();

			if(e != null) {
				res.setStatus(HttpServletResponse.SC_OK);
				e.toJSON(res.getOutputStream());
			} else {
				m = new Message(String.format("Document %d not found.", id), "E5A3", null);
				res.setStatus(HttpServletResponse.SC_NOT_FOUND);
				m.toJSON(res.getOutputStream());
			}
		} catch (Throwable t) {
			m = new Message("Cannot read document: unexpected error.", "E5A1", t.getMessage());
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			m.toJSON(res.getOutputStream());
		}
	}
	
}
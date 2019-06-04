package it.unipd.dei.webapp.rest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;

public abstract class RestResource {

	/**
	 * The HTTP request
	 */
	protected final HttpServletRequest req;

	/**
	 * The HTTP response
	 */
	protected final HttpServletResponse res;

	/**
	 * The connection to the database
	 */
	protected final Connection con;

	/**
	 * Creates a new REST resource.
	 */
	protected RestResource(final HttpServletRequest req, final HttpServletResponse res, Connection con) {
		this.req = req;
		this.res = res;
		this.con = con;
	}
}

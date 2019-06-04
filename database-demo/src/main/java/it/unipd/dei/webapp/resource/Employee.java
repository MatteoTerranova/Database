package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * Employee of the Ennedue Studio
 */
public class Employee extends Resource {

	// Fiscal code of the Employee
	private final String fiscalCode;

	// Name of the Employee
	private final String name;

	// Surname of the Employee
	private final String surname;
	
	// IBAN
	private final String IBAN;
	
	// Hourly Wage
	private final double hourlyWage;
	
	// Role
	private final String role;
	
	// Creates new Employee
	public Employee(final String fiscalCode, final String name, final String surname, final String IBAN, final double hourlyWage, final String role) {
		this.fiscalCode = fiscalCode;
		this.name = name;
		this.surname = surname;
		this.IBAN = IBAN;
		this.hourlyWage = hourlyWage;
		this.role = role;
	}

	
	public final String getFicalCode() {
		return fiscalCode;
	}

	
	public final String getName() {
		return name;
	}
	
	public final String getSurname() {
		return surname;
	}
	
	public final String getIBAN() {
		return IBAN;
	}
	
	public final double getHourlyWage() {
		return hourlyWage;
	}

	public final String getRole() {
		return role;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("employee");

		jg.writeStartObject();

		jg.writeStringField("fiscalcode", fiscalCode);

		jg.writeStringField("name", name);
		
		jg.writeStringField("surname", surname);
		
		jg.writeStringField("IBAN", IBAN);

		jg.writeNumberField("hourlywage", hourlyWage);
		
		jg.writeStringField("role", role);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}

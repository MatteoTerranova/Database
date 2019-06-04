/*
 * Copyright 2018 University of Padua, Italy
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.unipd.dei.webapp.resource;


import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * Represents the data about an employee.
 * 
 * @author Nicola Ferro (ferro@dei.unipd.it)
 * @version 1.00
 * @since 1.00
 */
public class Employee extends Resource {

	/**
	 * The badge number (identifier) of the employee
	 */
	private final int badge;

	/**
	 * The surname of the employee
	 */
	private final String surname;

	/**
	 * The age of the employee
	 */
	private final int age;

	/**
	 * The salary of the employee
	 */
	private final int salary;

	/**
	 * Creates a new employee
	 * 
	 * @param badge
	 *            the badge number of the employee
	 * @param surname
	 *            the surname of the employee.
	 * @param age
	 *            the age of the employee.
	 * @param salary
	 *            the salary of the employee
	 */
	public Employee(final int badge, final String surname, final int age, final int salary) {
		this.badge = badge;
		this.surname = surname;
		this.age = age;
		this.salary = salary;
	}

	/**
	 * Returns the badge number of the employee.
	 * 
	 * @return the badge number of the employee.
	 */
	public final int getBadge() {
		return badge;
	}

	/**
	 * Returns the surname of the employee.
	 * 
	 * @return the surname of the employee.
	 */
	public final String getSurname() {
		return surname;
	}

	/**
	 * Returns the age of the employee.
	 * 
	 * @return the age of the employee.
	 */
	public final int getAge() {
		return age;
	}

	/**
	 * Returns the salary of the employee.
	 * 
	 * @return the salary of the employee.
	 */
	public final int getSalary() {
		return salary;
	}

	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("employee");

		jg.writeStartObject();

		jg.writeNumberField("badge", badge);

		jg.writeStringField("surname", surname);

		jg.writeNumberField("age", age);

		jg.writeNumberField("salary", salary);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

	/**
	 * Creates a {@code Employee} from its JSON representation.
	 *
	 * @param in the input stream containing the JSON document.
	 *
	 * @return the {@code Employee} created from the JSON representation.
	 *
	 * @throws IOException if something goes wrong while parsing.
	 */
	public static Employee fromJSON(final InputStream in) throws IOException {

		// the fields read from JSON
		int jBadge = -1;
		String jSurname = null;
		int jAge = -1;
		int jSalary = -1;

		final JsonParser jp = JSON_FACTORY.createParser(in);

		// while we are not on the start of an element or the element is not
		// a token element, advance to the next element (if any)
		while (jp.getCurrentToken() != JsonToken.FIELD_NAME || "employee".equals(jp.getCurrentName()) == false) {

			// there are no more events
			if (jp.nextToken() == null) {
				throw new IOException("Unable to parse JSON: no employee object found.");
			}
		}

		while (jp.nextToken() != JsonToken.END_OBJECT) {

			if (jp.getCurrentToken() == JsonToken.FIELD_NAME) {

				switch (jp.getCurrentName()) {
					case "badge":
						jp.nextToken();
						jBadge = jp.getIntValue();
						break;
					case "surname":
						jp.nextToken();
						jSurname = jp.getText();
						break;
					case "age":
						jp.nextToken();
						jAge = jp.getIntValue();
						break;
					case "salary":
						jp.nextToken();
						jSalary = jp.getIntValue();
						break;
				}
			}
		}

		return new Employee(jBadge, jSurname, jAge, jSalary);
	}
}

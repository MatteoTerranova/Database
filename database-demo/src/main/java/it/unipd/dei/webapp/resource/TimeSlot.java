package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * TimeSlot of the Ennedue Studio
 */
public class TimeSlot extends Resource {

	// Project associated to the TimeSlot
	private final String projectTitle;

	// TemplateID associate to the TimeSlot
	private final String templateID;

	// TimeStamp of the TimeSlot
	private final String timestamp;
	
	// Note on the TimeSlot
	private final String note;
	
	// Hourly wage of the TimeSlot
	private final double hourlyWage;
	
	// Number of hours reported in the TimeSlot
	private final double numHours;
	
	// Employee's fiscal code
	private final String fiscalCode;
	
	// Task's UUID
	private final String taskUUID;
	
	// Creates new TimeSlot
	public TimeSlot(final String projectTitle, final String templateID, final String timestamp, final String note, final double hourlyWage, final double numHours){
		this.projectTitle = projectTitle;
		this.templateID = templateID;
		this.timestamp = timestamp;
		this.note = note;
		this.hourlyWage = hourlyWage;
		this.numHours = numHours;
		this.taskUUID = null;
		this.fiscalCode = null;
	}

	// Creates new TimeSlot
	public TimeSlot( final double numHours, final String fiscalCode, final String taskUUID, final String timestamp, final String note, final double hourlyWage){
		this.fiscalCode = fiscalCode;
		this.taskUUID = taskUUID;
		this.timestamp = timestamp;
		this.note = note;
		this.hourlyWage = hourlyWage;
		this.numHours = numHours;
		this.projectTitle = null;
		this.templateID = null;
	}
	
	public final String getFiscalCode() {
		return fiscalCode;
	}
	
	public final String getTaskUUID() {
		return taskUUID;
	}

	public final String getProjectTitle() {
		return projectTitle;
	}

	
	public final String getTemplateID() {
		return templateID;
	}
	
	public final String getTimestamp() {
		return timestamp;
	}
	
	public final String getNote() {
		return note;
	}
	
	public final double getHourlyWage() {
		return hourlyWage;
	}
	
	public final double getNumHours() {
		return numHours;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("timeslot");

		jg.writeStartObject();

		jg.writeStringField("title", projectTitle);

		jg.writeStringField("template", templateID);
		
		jg.writeStringField("timestamp", timestamp);

		jg.writeStringField("note", note);
		
		jg.writeNumberField("hourlywage", hourlyWage);
		
		jg.writeNumberField("hours", numHours);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}
	
	/**
	 * Creates a TimeSlot from its JSON representation.
	 */
	public static TimeSlot fromJSON(final InputStream in) throws IOException {

		// The fields read from JSON
		String fc = null;
		String uuid = null;
		String timestamp = null;
		String note = null;
		double hourlyWage = -1.0;
		double hours = -1.0;

		final JsonParser jp = JSON_FACTORY.createParser(in);

		// While we are not on the start of an element or the element is not
		// a token element, advance to the next element (if any)
		while (jp.getCurrentToken() != JsonToken.FIELD_NAME || "timeslot".equals(jp.getCurrentName()) == false) {

			// there are no more events
			if (jp.nextToken() == null) {
				throw new IOException("Unable to parse JSON: no timeslot object found.");
			}
		}

		while (jp.nextToken() != JsonToken.END_OBJECT) {

			if (jp.getCurrentToken() == JsonToken.FIELD_NAME) {

				switch (jp.getCurrentName()) {
					case "fiscalcode":
						jp.nextToken();
						fc = jp.getText();
						break;
					case "taskuuid":
						jp.nextToken();
						uuid = jp.getText();
						break;
					case "timestamp":
						jp.nextToken();
						timestamp = jp.getText();
						break;
					case "note":
						jp.nextToken();
						note = jp.getText();
						break;
					case "hourlywage":
						jp.nextToken();
						hourlyWage = jp.getDoubleValue();
						break;
					case "hours":
						jp.nextToken();
						hours = jp.getDoubleValue();
						break;
				}
			}
		}

		return new TimeSlot(hours, fc, uuid, timestamp, note, hourlyWage);
	}

}

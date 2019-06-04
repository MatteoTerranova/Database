package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * SearchRange of the Ennedue Studio
 */
public class SearchRange extends Resource {

	// From date to search
	private final String fromDate;

	// To date to search
	private final String toDate;
	
	// Creates new SearchRange
	public SearchRange(final String fromDate, final String toDate){
		this.fromDate = fromDate;
		this.toDate = toDate;
	}
	
	public final String getFromDate() {
		return fromDate;
	}
	
	public final String getToDate() {
		return toDate;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("range");

		jg.writeStartObject();

		jg.writeStringField("fromdate", fromDate);
		
		jg.writeStringField("todate", toDate);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}
	
	/**
	 * Creates a SearchRange from its JSON representation.
	 */
	public static SearchRange fromJSON(final InputStream in) throws IOException {

		// The fields read from JSON
		String jFromDate = null;
		String jToDate = null;

		final JsonParser jp = JSON_FACTORY.createParser(in);

		// While we are not on the start of an element or the element is not
		// a token element, advance to the next element (if any)
		while (jp.getCurrentToken() != JsonToken.FIELD_NAME || "range".equals(jp.getCurrentName()) == false) {

			// there are no more events
			if (jp.nextToken() == null) {
				throw new IOException("Unable to parse JSON: no range object found.");
			}
		}

		while (jp.nextToken() != JsonToken.END_OBJECT) {

			if (jp.getCurrentToken() == JsonToken.FIELD_NAME) {

				switch (jp.getCurrentName()) {
					case "fromdate":
						jp.nextToken();
						jFromDate = jp.getText();
						break;
					case "todate":
						jp.nextToken();
						jToDate = jp.getText();
						break;
				}
			}
		}

		return new SearchRange(jFromDate, jToDate);
	}

}

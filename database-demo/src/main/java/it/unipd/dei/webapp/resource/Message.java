package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.JsonGenerator;
import java.io.*;

public class Message extends Resource {

	private final String message;

	private final String errorCode;

	private final String errorDetails;
	
	private final boolean isError;

	public Message(final String message, final String errorCode, final String errorDetails) {
		this.message = message;
		this.errorCode = errorCode;
		this.errorDetails = errorDetails;
		this.isError = true;
	}

	public Message(final String message) {
		this.message = message;
		this.errorCode = null;
		this.errorDetails = null;
		this.isError = false;
	}

	public final String getMessage() {
		return message;
	}

	public final String getErrorCode() {
		return errorCode;
	}

	public final String getErrorDetails() {
		return errorDetails;
	}

	public final boolean isError() {
		return isError;
	}

	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("message");

		jg.writeStartObject();

		jg.writeStringField("message", message);

		if(errorCode != null) {
			jg.writeStringField("error-code", errorCode);
		}

		if(errorDetails != null) {
			jg.writeStringField("error-details", errorDetails);
		}

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}

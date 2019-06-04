package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.JsonGenerator;
import java.io.*;

public final class ResourceList<T extends Resource> extends Resource {

    private final Iterable<T> list;

    public ResourceList(final Iterable<T> list) {
        this.list = list;
    }

    @Override
    public final void toJSON(final OutputStream out) throws IOException {

        final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

        jg.writeStartObject();

        jg.writeFieldName("resource-list");

        jg.writeStartArray();

        jg.flush();

        boolean firstElement = true;

        for (final Resource r : list) {

            // Add commas between elements
            if (firstElement) {
                r.toJSON(out);
                jg.flush();

                firstElement = false;
            } else {
                jg.writeRaw(',');
                jg.flush();

                r.toJSON(out);
                jg.flush();
            }
        }

        jg.writeEndArray();

        jg.writeEndObject();

        jg.flush();

        jg.close();
    }

}
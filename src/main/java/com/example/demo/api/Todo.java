//This Class essentially alows us to model the json response(must match same format and data points) and create a way to convert the response to string
package com.example.demo.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

//Added packageds so we can convert the jason response to string using jackson
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


//This tells jackson to ignore any properyies that are not mapped explicitly in the specified section
@JsonIgnoreProperties(ignoreUnknown = true)
//Update data points below for new api consumption
public record Todo(Long id, String title) {

    /*
	 * This section of code is responsable for:
	 * Converting the json response into a string using ObjectMapper
	 * 
	 */
    @Override
    public String toString() {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            return "Todo{id=" + id + ", title='" + title + "'}";
        }
    }
}

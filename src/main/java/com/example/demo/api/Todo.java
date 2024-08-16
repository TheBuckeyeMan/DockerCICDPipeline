package com.example.demo.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

//Added packageds so we can convert the jason response to string using jackson
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@JsonIgnoreProperties(ignoreUnknown = true)
//If we consume a different api, we will need to modify the fields here
public record Todo(Long id, String title) {

    /*
	 * This section of code is responsable for:
	 * 
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

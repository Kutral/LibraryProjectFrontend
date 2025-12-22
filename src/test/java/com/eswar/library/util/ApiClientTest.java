package com.eswar.library.util;

import com.google.gson.Gson;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.net.http.HttpResponse;

public class ApiClientTest {

    @Test
    public void testParseResponseWithoutData() {
        String jsonBody = "{\"success\":true,\"message\":\"User registered successfully\"}";
        int statusCode = 201;

        Gson gson = new Gson();
        ApiClient.ApiResponse apiResp = null;
        
        try {
             com.google.gson.JsonObject jsonResponse = com.google.gson.JsonParser.parseString(jsonBody).getAsJsonObject();
             if (jsonResponse.has("success")) {
                 boolean success = jsonResponse.get("success").getAsBoolean();
                 String message = jsonResponse.has("message") ? jsonResponse.get("message").getAsString() : "";
                 String dataJson = jsonResponse.has("data") && !jsonResponse.get("data").isJsonNull() 
                         ? gson.toJson(jsonResponse.get("data")) 
                         : null;
                 apiResp = new ApiClient.ApiResponse(success, message, dataJson, statusCode);
             }
        } catch (Exception e) {
            e.printStackTrace();
        }

        assertNotNull(apiResp, "ApiResponse should not be null");
        assertTrue(apiResp.isSuccess(), "Should be successful");
        assertEquals("User registered successfully", apiResp.getMessage());
        assertNull(apiResp.getDataJson(), "Data should be null");
        assertEquals(201, apiResp.getStatusCode());
    }
}

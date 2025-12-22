package com.eswar.library.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class ApiClient {


    private static final String BASE_URL = "http://127.0.0.1:8080/api";

    private static final HttpClient client = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .connectTimeout(Duration.ofSeconds(10))
            .build();
    private static final Gson gson = new Gson();

    public static ApiResponse post(String endpoint, Object payload) throws Exception {
        String jsonBody = gson.toJson(payload);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(BASE_URL + endpoint)) // e.g., /auth/login
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();
        return sendRequest(request);
    }

    public static ApiResponse put(String endpoint, Object payload) throws Exception {
        String jsonBody = gson.toJson(payload);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(BASE_URL + endpoint))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();
        return sendRequest(request);
    }

    public static ApiResponse get(String endpoint) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(BASE_URL + endpoint))
                .header("Content-Type", "application/json")
                .GET()
                .build();
        return sendRequest(request);
    }

    private static ApiResponse sendRequest(HttpRequest request) throws Exception {
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        String body = response.body();


        try {
            JsonObject jsonResponse = JsonParser.parseString(body).getAsJsonObject();
            if (jsonResponse.has("success")) {
                 boolean success = jsonResponse.get("success").getAsBoolean();
                 String message = jsonResponse.has("message") ? jsonResponse.get("message").getAsString() : "";
                 // Extract 'data' field if it exists
                 String dataJson = jsonResponse.has("data") ? gson.toJson(jsonResponse.get("data")) : null;
                 return new ApiResponse(success, message, dataJson, response.statusCode());
            }
        } catch (Exception e) {
            // Fallback for raw arrays or errors
        }

        return new ApiResponse(response.statusCode() == 200, "Request completed", body, response.statusCode());
    }

    // Inner DTO class to handle responses
    public static class ApiResponse {
        private boolean success;
        private String message;
        private String dataJson;
        private int statusCode;

        public ApiResponse(boolean success, String message, String dataJson, int statusCode) {
            this.success = success;
            this.message = message;
            this.dataJson = dataJson;
            this.statusCode = statusCode;
        }

        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
        public String getDataJson() { return dataJson; }

        // Helper to convert data JSON back to a specific Java Object (e.g., User.class)
        public <T> T getData(Class<T> classOfT) {
            if (dataJson == null) return null;
            return new Gson().fromJson(dataJson, classOfT);
        }

        public int getStatusCode() { return statusCode; }
    }
}

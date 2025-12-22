package com.eswar.library.util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class BackendProbe {

    private static final HttpClient client = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .connectTimeout(Duration.ofSeconds(2)) // Fast timeout
            .build();

    private static final int[] PORTS = {8079, 8080, 8081, 8082, 8000, 9090};
    private static final String[] CONTEXTS = {"/library-backend", "/LibraryProjectBackend", "/LibraryProject", "/library", "/api", ""};

    public static void probe() {
        System.out.println("=== STARTING BACKEND PROBE ===");
        
        for (int port : PORTS) {
            System.out.println("Checking Port: " + port);
            if (!isPortOpen(port)) {
                System.out.println("  -> Port Closed/Unreachable");
                continue;
            }
            
            for (String context : CONTEXTS) {
                String testUrl = "http://localhost:" + port + context + "/test"; // Try /test endpoint first
                checkUrl(testUrl);
                
                String authUrl = "http://localhost:" + port + context + "/api/auth/login"; // Try auth endpoint
                checkUrl(authUrl);
            }
        }
        System.out.println("=== PROBE FINISHED ===");
    }

    private static boolean isPortOpen(int port) {
        // Simple check by trying to connect to root
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:" + port))
                    .GET()
                    .build();
            client.send(request, HttpResponse.BodyHandlers.ofString());
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private static void checkUrl(String url) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET() // Using GET for probe, though login is POST, 405 Method Not Allowed is a SUCCESS for discovery
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            int status = response.statusCode();
            
            System.out.println("  Tested: " + url + " -> Status: " + status);
            
            if (status != 404 && status != 503) {
                System.out.println("  !!! POTENTIAL MATCH FOUND !!!");
                System.out.println("  !!! Body Preview: " + (response.body().length() > 50 ? response.body().substring(0, 50) : response.body()));
            }
            
        } catch (Exception e) {
            // Ignore connection errors here
        }
    }
}

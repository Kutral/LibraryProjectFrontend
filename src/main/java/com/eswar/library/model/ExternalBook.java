package com.eswar.library.model;

import java.util.List;

public class ExternalBook {
    private String key;
    private String title;
    private List<String> author_name;
    private List<String> isbn;
    private int cover_i;
    private int first_publish_year;

    public String getKey() { return key; }
    public void setKey(String key) { this.key = key; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public List<String> getAuthorName() { return author_name; }
    public void setAuthorName(List<String> author_name) { this.author_name = author_name; }

    public List<String> getIsbn() { return isbn; }
    public void setIsbn(List<String> isbn) { this.isbn = isbn; }

    public int getCoverI() { return cover_i; }
    public void setCoverI(int cover_i) { this.cover_i = cover_i; }

    public int getFirstPublishYear() { return first_publish_year; }
    public void setFirstPublishYear(int first_publish_year) { this.first_publish_year = first_publish_year; }

    public int getFirst_publish_year() { return first_publish_year; }

    public String getFirstIsbn() {
        if (isbn != null && !isbn.isEmpty()) {
            return isbn.get(0);
        }
        return null;
    }

    public String getAuthorsJoined() {
        if (author_name != null) {
            return String.join(", ", author_name);
        }
        return "Unknown Author";
    }
}

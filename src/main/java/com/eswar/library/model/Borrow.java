package com.eswar.library.model;

import java.sql.Timestamp;

public class Borrow {
    private int id;
    private int userId;
    private int bookId;
    private Timestamp borrowDate;
    private Timestamp returnDate;
    private boolean returned;
    private Book book;

    public Borrow() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public Timestamp getBorrowDate() { return borrowDate; }
    public void setBorrowDate(Timestamp borrowDate) { this.borrowDate = borrowDate; }

    public Timestamp getReturnDate() { return returnDate; }
    public void setReturnDate(Timestamp returnDate) { this.returnDate = returnDate; }

    public boolean isReturned() { return returned; }
    public void setReturned(boolean returned) { this.returned = returned; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
}

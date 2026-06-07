package com.rental.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;

/**
 * A specialized linked list implementation for rental records
 */
public class RentalLinkedList {

    /**
     * Node class for the linked list
     */
    private class Node {
        Rental rental;
        Node next;

        Node(Rental rental) {
            this.rental = rental;
            this.next = null;
        }
    }

    private Node head;
    private Node tail;
    private int size;

    /**
     * Constructs an empty linked list
     */
    public RentalLinkedList() {
        this.head = null;
        this.tail = null;
        this.size = 0;
    }

    /**
     * Adds a rental to the end of the list
     *
     * @param rental The rental to add
     */
    public void add(Rental rental) {
        Node newNode = new Node(rental);

        if (head == null) {
            // List is empty
            head = newNode;
            tail = newNode;
        } else {
            // Add to the end
            tail.next = newNode;
            tail = newNode;
        }

        size++;
    }

    /**
     * Removes a rental from the list
     *
     * @param rentalId The ID of the rental to remove
     * @return true if the rental was removed, false if not found
     */
    public boolean remove(String rentalId) {
        if (head == null) {
            return false;
        }

        // Special case: first node
        if (head.rental.getRentalId().equals(rentalId)) {
            head = head.next;
            if (head == null) {
                tail = null; // List is now empty
            }
            size--;
            return true;
        }

        // Look for the rental in the rest of the list
        Node current = head;
        while (current.next != null) {
            if (current.next.rental.getRentalId().equals(rentalId)) {
                // Found it, remove it
                if (current.next == tail) {
                    tail = current; // Update tail if removing last node
                }
                current.next = current.next.next;
                size--;
                return true;
            }
            current = current.next;
        }

        return false; // Not found
    }

    /**
     * Finds a rental by its ID
     *
     * @param rentalId The ID of the rental to find
     * @return The rental if found, null otherwise
     */
    public Rental findById(String rentalId) {
        Node current = head;
        while (current != null) {
            if (current.rental.getRentalId().equals(rentalId)) {
                return current.rental;
            }
            current = current.next;
        }
        return null;
    }

    /**
     * Gets all rentals as an array
     *
     * @return Array of all rentals
     */
    public Rental[] toArray() {
        Rental[] result = new Rental[size];
        Node current = head;
        int index = 0;

        while (current != null) {
            result[index++] = current.rental;
            current = current.next;
        }

        return result;
    }

    /**
     * Gets all rentals as a list
     *
     * @return List of all rentals
     */
    public List<Rental> toList() {
        List<Rental> result = new ArrayList<>(size);
        Node current = head;

        while (current != null) {
            result.add(current.rental);
            current = current.next;
        }

        return result;
    }

    /**
     * Gets the number of rentals in the list
     *
     * @return The size of the list
     */
    public int size() {
        return size;
    }

    /**
     * Checks if the list is empty
     *
     * @return true if the list is empty, false otherwise
     */
    public boolean isEmpty() {
        return size == 0;
    }

    /**
     * Updates a rental in the list
     *
     * @param updatedRental The updated rental
     * @return true if the rental was updated, false if not found
     */
    public boolean update(Rental updatedRental) {
        Node current = head;
        while (current != null) {
            if (current.rental.getRentalId().equals(updatedRental.getRentalId())) {
                current.rental = updatedRental;
                return true;
            }
            current = current.next;
        }
        return false;
    }

    /**
     * Filters rentals by criteria
     *
     * @param predicate The filter predicate
     * @return A new linked list containing only rentals that match the criteria
     */
    public RentalLinkedList filter(Predicate<Rental> predicate) {
        RentalLinkedList result = new RentalLinkedList();
        Node current = head;

        while (current != null) {
            if (predicate.test(current.rental)) {
                result.add(current.rental);
            }
            current = current.next;
        }

        return result;
    }
}
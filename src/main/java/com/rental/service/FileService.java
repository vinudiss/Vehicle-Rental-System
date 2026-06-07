package com.rental.service;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

/**
 * Service class for common file operations
 * Provides utility methods for reading and writing data to files
 */
public class FileService {

    private static final String DATA_DIRECTORY = "data";

    /**
     * Ensure data directory exists
     */
    public static void ensureDataDirectoryExists() {
        File dataDir = new File(DATA_DIRECTORY);
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }
    }

    /**
     * Check if a file exists
     *
     * @param fileName The name of the file to check
     * @return true if file exists, false otherwise
     */
    public static boolean fileExists(String fileName) {
        Path path = Paths.get(DATA_DIRECTORY + File.separator + fileName);
        return Files.exists(path);
    }

    /**
     * Create a new file if it doesn't exist
     *
     * @param fileName The name of the file to create
     * @return true if file was created or already exists, false if creation failed
     */
    public static boolean createFileIfNotExists(String fileName) {
        try {
            ensureDataDirectoryExists();
            Path path = Paths.get(DATA_DIRECTORY + File.separator + fileName);
            if (!Files.exists(path)) {
                Files.createFile(path);
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error creating file: " + e.getMessage());
            return false;
        }
    }

    /**
     * Read all lines from a file
     *
     * @param fileName The name of the file to read
     * @return List of lines from the file, or empty list if file doesn't exist
     */
    public static List<String> readAllLines(String fileName) {
        Path path = Paths.get(DATA_DIRECTORY + File.separator + fileName);
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }

        try {
            return Files.readAllLines(path);
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Write all lines to a file (overwrites existing content)
     *
     * @param fileName The name of the file to write to
     * @param lines The lines to write
     * @return true if write was successful, false otherwise
     */
    public static boolean writeAllLines(String fileName, List<String> lines) {
        ensureDataDirectoryExists();
        Path path = Paths.get(DATA_DIRECTORY + File.separator + fileName);

        try {
            Files.write(path, lines);
            return true;
        } catch (IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
            return false;
        }
    }

    /**
     * Append a line to a file
     *
     * @param fileName The name of the file to append to
     * @param line The line to append
     * @return true if append was successful, false otherwise
     */
    public static boolean appendLine(String fileName, String line) {
        ensureDataDirectoryExists();
        Path path = Paths.get(DATA_DIRECTORY + File.separator + fileName);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path.toFile(), true))) {
            writer.write(line);
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("Error appending to file: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete a line from a file
     *
     * @param fileName The name of the file
     * @param lineToDelete The line to delete
     * @return true if deletion was successful, false otherwise
     */
    public static boolean deleteLine(String fileName, String lineToDelete) {
        List<String> lines = readAllLines(fileName);
        lines.remove(lineToDelete);
        return writeAllLines(fileName, lines);
    }

    /**
     * Replace a line in a file
     *
     * @param fileName The name of the file
     * @param oldLine The line to replace
     * @param newLine The new line
     * @return true if replacement was successful, false otherwise
     */
    public static boolean replaceLine(String fileName, String oldLine, String newLine) {
        List<String> lines = readAllLines(fileName);
        int index = lines.indexOf(oldLine);
        if (index >= 0) {
            lines.set(index, newLine);
            return writeAllLines(fileName, lines);
        }
        return false;
    }

    /**
     * Read objects from a file
     *
     * @param <T> The type of objects to read
     * @param fileName The name of the file to read from
     * @param parser A function to parse each line into an object
     * @return List of parsed objects
     */
    public static <T> List<T> readObjects(String fileName, Function<String, T> parser) {
        List<String> lines = readAllLines(fileName);
        List<T> objects = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                try {
                    T object = parser.apply(line);
                    objects.add(object);
                } catch (Exception e) {
                    System.err.println("Error parsing line: " + e.getMessage());
                }
            }
        }

        return objects;
    }

    /**
     * Write objects to a file
     *
     * @param <T> The type of objects to write
     * @param fileName The name of the file to write to
     * @param objects The objects to write
     * @param formatter A function to format each object as a string
     * @return true if write was successful, false otherwise
     */
    public static <T> boolean writeObjects(String fileName, List<T> objects, Function<T, String> formatter) {
        List<String> lines = new ArrayList<>();

        for (T object : objects) {
            try {
                String line = formatter.apply(object);
                lines.add(line);
            } catch (Exception e) {
                System.err.println("Error formatting object: " + e.getMessage());
            }
        }

        return writeAllLines(fileName, lines);
    }

    /**
     * Backup a file
     *
     * @param fileName The name of the file to backup
     * @return true if backup was successful, false otherwise
     */
    public static boolean backupFile(String fileName) {
        String backupFileName = fileName + ".bak";

        Path sourcePath = Paths.get(DATA_DIRECTORY + File.separator + fileName);
        Path targetPath = Paths.get(DATA_DIRECTORY + File.separator + backupFileName);

        if (!Files.exists(sourcePath)) {
            return false;
        }

        try {
            Files.copy(sourcePath, targetPath);
            return true;
        } catch (IOException e) {
            System.err.println("Error backing up file: " + e.getMessage());
            return false;
        }
    }

    /**
     * Restore a file from backup
     *
     * @param fileName The name of the file to restore
     * @return true if restore was successful, false otherwise
     */
    public static boolean restoreFile(String fileName) {
        String backupFileName = fileName + ".bak";

        Path sourcePath = Paths.get(DATA_DIRECTORY + File.separator + backupFileName);
        Path targetPath = Paths.get(DATA_DIRECTORY + File.separator + fileName);

        if (!Files.exists(sourcePath)) {
            return false;
        }

        try {
            Files.copy(sourcePath, targetPath);
            return true;
        } catch (IOException e) {
            System.err.println("Error restoring file: " + e.getMessage());
            return false;
        }
    }
}
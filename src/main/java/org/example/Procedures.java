package org.example;

import com.mysql.cj.protocol.Resultset;

import java.sql.*;

public class Procedures {
    private static final String URL = "jdbc:mysql://207.154.236.26:3306/esport";
    private static final String USER = "devtester";
    private static final String PASSWORD = "testuser";

    public static void joinTournament(int playerId, int tournamentId) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = conn.prepareCall("{CALL joinTournament(?, ?)}")) {

            stmt.setInt(1, playerId);
            stmt.setInt(2, tournamentId);
            stmt.execute();

            System.out.println("Player registered successfully.");
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
        }
    }
    public static void submitMatchResult(int match_id, int winner_id) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = conn.prepareCall("{CALL submitMatchResult(?, ?)}")) {

            stmt.setInt(1, match_id);
            stmt.setInt(2, winner_id);
            stmt.execute();

            System.out.println("Match result submitted successfully.");
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
        }
    }
    // Prepared statement with same functionality as joinTournament
    public static void joinTournamentPreparedStatement(int playerId, int tournamentId) {

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement checkStmt = conn.prepareStatement("SELECT 1 FROM tournament_registrations WHERE tournament_id = ? AND player_id = ?");
             PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO tournament_registrations (player_id, tournament_id, registered_at) VALUES (?, ?, NOW())")) {

            // Check if player is already registered
            checkStmt.setInt(1, tournamentId);
            checkStmt.setInt(2, playerId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                System.out.println("Player has already registered for the tournament.");
                return;  // Stop execution if player is already registered
            }

            // Insert new registration
            insertStmt.setInt(1, playerId);
            insertStmt.setInt(2, tournamentId);
            int rowsAffected = insertStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Player registered successfully.");
            } else {
                System.out.println("Registration failed.");
            }

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
        }
    }
    public static void submitMatchResultPreparedStatement(int match_id, int winner_id) {

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement playerids = conn.prepareStatement("SELECT player1_id, player2_id FROM matches WHERE match_id = ?");
             PreparedStatement insertStmt = conn.prepareStatement("UPDATE matches SET winner_id = ? WHERE match_id = ?")) {

            playerids.setInt(1, match_id);
            ResultSet prs = playerids.executeQuery();
            if (prs.next()){
                int player1_id = prs.getInt("player1_id");
                int player2_id = prs.getInt("player2_id");
                if (winner_id != player1_id && winner_id != player2_id){
                    System.out.println("Winner id is not a player in the match");
                    return;
                }
            }



            // Insert new registration
            insertStmt.setInt(1, winner_id);
            insertStmt.setInt(2, match_id);
            int rowsAffected = insertStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Match result submitted.");
            } else {
                System.out.println("Match result failed while submitting.");
            }

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
        }
    }

}

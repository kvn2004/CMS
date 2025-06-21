package lk.vihanganimsara.cms.model;

import lk.vihanganimsara.cms.dto.ComplainDto;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/20/2025 11:11 PM
 * Project: CMS
 * --------------------------------------------
 **/

public class UserComplaintManagementModel {
    public boolean saveComplain(ComplainDto complain, DataSource dataSource) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = dataSource.getConnection();

            preparedStatement = connection.prepareStatement(
                    "INSERT INTO complaints (user_id, title, description, status) VALUES (?, ?, ?, ?)"
            );
            preparedStatement.setInt(1, Integer.parseInt(complain.getUserID()));
            preparedStatement.setString(2, complain.getTitle());
            preparedStatement.setString(3, complain.getDescription());
            preparedStatement.setString(4, complain.getStatus());

            int rows = preparedStatement.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<ComplainDto> getAllComplaints(int userId, DataSource dataSource) {
        List<ComplainDto> complaints = new ArrayList<>();

        try (Connection con = dataSource.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT id, title, description, status FROM complaints WHERE user_id = ?"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ComplainDto dto = new ComplainDto();
                dto.setId(rs.getInt("id")); // Set complaint ID
                dto.setUserID(String.valueOf(userId)); // Set user ID
                dto.setTitle(rs.getString("title"));
                dto.setDescription(rs.getString("description"));
                dto.setStatus(rs.getString("status"));
                complaints.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving complaints", e); // Better error handling
        }

        return complaints;
    }

    public boolean deleteComplaint(int complaintId, DataSource ds) {
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM complaints WHERE id = ?")) {
            ps.setInt(1, complaintId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateComplaint(ComplainDto complaint, DataSource ds) {
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE complaints SET title = ?, description = ?, status = ? WHERE id = ?")) {
            ps.setString(1, complaint.getTitle());
            ps.setString(2, complaint.getDescription());
            ps.setString(3, complaint.getStatus());
            ps.setInt(4, complaint.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}

package lk.vihanganimsara.cms.model;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/21/2025 1:01 PM
 * Project: CMS
 * --------------------------------------------
 **/


import lk.vihanganimsara.cms.dto.ComplainDto;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminComplaintManagementModel {

    public List<ComplainDto> getAllComplaints(DataSource dataSource) {
        List<ComplainDto> complaints = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ComplainDto dto = new ComplainDto();
                dto.setId(rs.getInt("id"));
                dto.setUserID(String.valueOf(rs.getInt("user_id")));
                dto.setTitle(rs.getString("title"));
                dto.setDescription(rs.getString("description"));
                dto.setStatus(rs.getString("status"));
                complaints.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving complaints", e);
        }

        return complaints;
    }

    public boolean updateComplaintStatus(ComplainDto complaint, DataSource ds) {
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE complaints SET status=? WHERE id=?")) {

            ps.setString(1, complaint.getStatus());
            ps.setInt(2, complaint.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteComplaint(int complaintId, DataSource ds) {
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM complaints WHERE id=?")) {

            ps.setInt(1, complaintId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}


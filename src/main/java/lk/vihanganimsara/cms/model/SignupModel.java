package lk.vihanganimsara.cms.model;

import jakarta.annotation.Resource;
import lk.vihanganimsara.cms.dto.UserDto;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/16/2025 4:46 PM
 * Project: CMS
 * --------------------------------------------
 **/
public class SignupModel {
    //    private final DataSource dataSource;
//
//    public SignupModel() {
//        BasicDataSource ds = new BasicDataSource();
//        ds.setUrl("jdbc:mysql://localhost:3306/cms_db?useSSL=false");
//        ds.setUsername("root");
//        ds.setPassword("kvn2004");
//        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
//        ds.setInitialSize(5); // Reduced for testing, adjust as needed
//        ds.setMaxTotal(10);  // Reduced for testing, adjust as needed
//        this.dataSource = ds;
//    }
//    @Resource(name = "java:comp/env/jdbc/TaskDB")
//    private DataSource dataSource;

    public boolean userSignup(UserDto userDto, DataSource dataSource) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean success = false;

        try {
            connection = dataSource.getConnection();
            preparedStatement = connection.prepareStatement(
                    "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)"
            );
            preparedStatement.setString(1, userDto.getUsername());
            preparedStatement.setString(2, userDto.getPassword());
            preparedStatement.setString(3, userDto.getEmail());
            preparedStatement.setString(4, userDto.getRole());

            int rowsAffected = preparedStatement.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            success = false;
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Cleanup Error: " + e.getMessage());
            }
        }
        return success;
    }
}
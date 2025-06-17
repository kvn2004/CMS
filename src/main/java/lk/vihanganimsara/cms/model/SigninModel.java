package lk.vihanganimsara.cms.model;

import lk.vihanganimsara.cms.dto.UserDto;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/18/2025 2:30 AM
 * Project: CMS
 * --------------------------------------------
 **/

public class SigninModel {
    public boolean userSignin(UserDto userDto, DataSource dataSource) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean success = false;

        try {
            connection = dataSource.getConnection();
            preparedStatement = connection.prepareStatement(
                    "SELECT * FROM users WHERE email = ? AND password = ?"
            );
            preparedStatement.setString(1, userDto.getEmail());
            preparedStatement.setString(2, userDto.getPassword());

            ResultSet rowsAffected = preparedStatement.executeQuery();
            System.out.println(rowsAffected);
            success = rowsAffected.next();
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

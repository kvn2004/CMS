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
    public UserDto userSignin(UserDto userDto, DataSource dataSource) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        UserDto loggedInUser = null;

        try {
            connection = dataSource.getConnection();
            preparedStatement = connection.prepareStatement(
                    "SELECT id, username, email, role FROM users WHERE email = ? AND password = ?"
            );
            preparedStatement.setString(1, userDto.getEmail());
            preparedStatement.setString(2, userDto.getPassword());

            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                // ✅ User found – get ID and other info
                int id = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String role = resultSet.getString("role");
                String email = resultSet.getString("email");

                // Create a new UserDto to return
                loggedInUser = new UserDto(id, username, userDto.getPassword(), email, role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return loggedInUser;
    }


}

package lk.vihanganimsara.cms.dto;

import lombok.*;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/16/2025 4:45 PM
 * Project: CMS
 * --------------------------------------------
 **/
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UserDto {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String role;
}

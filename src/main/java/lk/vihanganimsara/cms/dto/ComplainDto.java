package lk.vihanganimsara.cms.dto;

import lombok.*;

/**
 * --------------------------------------------
 * Author: Vihanga Nimsara(kvn2004)
 * GitHub: https://github.com/kvn2004
 * --------------------------------------------
 * Created: 6/20/2025 11:12 PM
 * Project: CMS
 * --------------------------------------------
 **/
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ComplainDto {
    private int id; // complaint ID (must be defined!)
    private String UserID;
    private String title;
    private String description;
    private String status;
}

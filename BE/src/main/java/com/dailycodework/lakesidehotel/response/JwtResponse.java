package com.dailycodework.lakesidehotel.response;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author Simpson Alfred
 */

@Data

@NoArgsConstructor
public class JwtResponse {
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private String token;
    private String type = "Bearer";
    private List<String> roles;

    public JwtResponse(Long id, String firstName, String lastName, String email, String token, List<String> roles) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.token = token;
        this.roles = roles;
    }
}

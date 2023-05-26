package locker.api.dto.auth.request;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LoginRequest {

    private String phone;
    private String password;
//    private String token;
}

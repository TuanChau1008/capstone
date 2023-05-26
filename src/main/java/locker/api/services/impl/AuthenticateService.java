package locker.api.services.impl;

import locker.api.dto.auth.request.LoginRequest;
import locker.api.dto.auth.request.RegisterRequest;
import locker.api.dto.auth.response.LoginResponse;
import locker.api.dto.auth.response.RegisterResponse;

public interface AuthenticateService {
    LoginResponse login(LoginRequest loginRequest);

    RegisterResponse register(RegisterRequest registerRequest);

    Boolean verified (String otp);

}

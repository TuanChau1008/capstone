package locker.api.services.impl;

import locker.api.dto.auth.request.LoginByGmailRequest;
import locker.api.dto.auth.request.LoginRequest;
import locker.api.dto.auth.request.RegisterRequest;
import locker.api.dto.auth.response.LoginResponse;
import locker.api.dto.auth.response.RegisterResponse;

public interface AuthenticateService {
    LoginResponse login(LoginRequest loginRequest);

    LoginResponse loginGmail(LoginByGmailRequest loginByGmailRequest);

    RegisterResponse register(RegisterRequest registerRequest);

    Boolean verified (String otp);

    Boolean sendOTP (String email);

}

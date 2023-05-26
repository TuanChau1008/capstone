package locker.api.controller;

import locker.api.config.JwtConfig;
import locker.api.dto.auth.request.LoginRequest;
import locker.api.dto.auth.request.RegisterRequest;
import locker.api.dto.common.ResponseDTO;
import locker.api.repositories.RoleRepository;
import locker.api.repositories.UserRepository;
import locker.api.services.impl.AuthenticateService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.security.PermitAll;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/v1/auth")
public class AuthenticateController {
    private final AuthenticateService authenticateService;
    @PostMapping("login")
    @PermitAll
    public ResponseEntity<ResponseDTO> login(@RequestBody LoginRequest loginRequest){
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(authenticateService.login(loginRequest));
        return ResponseEntity.ok().body(responseDTO);
    }

    @PostMapping("login-by-gmail")
    @PermitAll
    public ResponseEntity<ResponseDTO> loginGmail(@RequestBody LoginRequest loginRequest){
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(authenticateService.login(loginRequest));
        return ResponseEntity.ok().body(responseDTO);
    }

    @PostMapping("register")
    @PermitAll
    public ResponseEntity<ResponseDTO> register(@RequestBody RegisterRequest registerRequest){
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(authenticateService.register(registerRequest));
        return ResponseEntity.ok().body(responseDTO);
    }

    @PostMapping("send-otp/{email}")
    @PermitAll
    public ResponseEntity<ResponseDTO> sendEmail(@PathVariable String email){
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(authenticateService.sendOTP(email));
        return ResponseEntity.ok().body(responseDTO);
    }

    @PatchMapping("send-otp/{otp}")
    @PermitAll
    public ResponseEntity<ResponseDTO> verify(@PathVariable String otp){
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(authenticateService.verified(otp));
        return ResponseEntity.ok().body(responseDTO);
    }
}

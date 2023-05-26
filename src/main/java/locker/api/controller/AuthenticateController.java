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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @PostMapping("register")
    @PermitAll
    public ResponseEntity<ResponseDTO> register(@RequestBody RegisterRequest registerRequest){
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(authenticateService.register(registerRequest));
        return ResponseEntity.ok().body(responseDTO);
    }
}

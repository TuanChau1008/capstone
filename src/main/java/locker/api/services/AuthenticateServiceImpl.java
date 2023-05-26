package locker.api.services;

import io.jsonwebtoken.Jwts;
import locker.api.config.JwtConfig;
import locker.api.dto.auth.request.LoginByGmailRequest;
import locker.api.dto.auth.request.LoginRequest;
import locker.api.dto.auth.request.RegisterRequest;
import locker.api.dto.auth.response.LoginResponse;
import locker.api.dto.auth.response.RegisterResponse;
import locker.api.dto.common.EmailDTO;
import locker.api.entities.User;
import locker.api.repositories.RoleRepository;
import locker.api.repositories.UserRepository;
import locker.api.services.impl.AuthenticateService;
import locker.api.services.impl.EmailService;
import locker.api.util.Util;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthenticateServiceImpl implements AuthenticateService {
    private final AuthenticationManager authenticationManager;

    private final PasswordEncoder passwordEncoder;
    private final JwtConfig jwtConfig;

    private final RoleRepository roleRepository;

    private final UserRepository userRepository;

    private final EmailService emailService;

    @Override
    public LoginResponse login(LoginRequest loginRequest) {
        Authentication authentication = new UsernamePasswordAuthenticationToken(loginRequest.getPhone(), loginRequest.getPassword());
        try {
            Authentication authenticate = authenticationManager.authenticate(authentication);
            if (authenticate.isAuthenticated()) {
                User userAuthenticated = userRepository.findByPhone(authenticate.getName().split(";")[1]);

                // lấy full name nếu cus bị null thì lấy sitter
                String token = Jwts.builder().setSubject(authenticate.getName())
                        .claim(("authorities"), authenticate.getAuthorities()).claim("id", userAuthenticated.getId())
                        .claim("role", userAuthenticated.getRole().getName())
//                        .claim("status", userAuthenticated.getStatus())
//                        .claim("fullName", userAuthenticated.getFullName())
                        .setIssuedAt((new Date())).setExpiration(java.sql.Date.valueOf(LocalDate.now().plusDays(1)))
                        .signWith(jwtConfig.secretKey()).compact();

                LoginResponse loginResponse = LoginResponse.builder()
                        .token(jwtConfig.getTokenPrefix() + token).build();
                return loginResponse;
            } else {
                throw new ResponseStatusException(HttpStatus.valueOf(400), "sai tài khoảng hoặc mật khẩu");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.valueOf(400), "Sai tài khoản hoặc mật khẩu");
        }
    }

    @Override
    public LoginResponse loginGmail(LoginByGmailRequest loginByGmailRequest) {
        try {
            User user = null;

            User _user = userRepository.findByEmail(loginByGmailRequest.getEmail());
            if (_user != null) user = _user;
            else {
                user = User.builder()
                        .email(loginByGmailRequest.getEmail())
                        .role(roleRepository.findByName("USER"))
                        .status("ACTIVE")
                        .build();
                userRepository.save(user);
            }
            Authentication authenticate = new UsernamePasswordAuthenticationToken(user.getEmail(), null);
            User userAuthenticated = userRepository.findByEmail(authenticate.getName().split(";")[0]);
            String token = Jwts.builder().setSubject(authenticate.getName())
                    .claim(("authorities"), authenticate.getAuthorities())
                    .claim("id", userAuthenticated.getId())
//                .claim("fullName", userAuthenticated.getFullName())
                    .claim("role", userAuthenticated.getRole().getName())
                    .claim("status", userAuthenticated.getStatus())
                    .setIssuedAt((new Date())).setExpiration(java.sql.Date.valueOf(LocalDate.now().plusDays(1)))
                    .signWith(jwtConfig.secretKey()).compact();
            LoginResponse loginResponse = LoginResponse.builder()
                    .token(jwtConfig.getTokenPrefix() + token).build();
            return loginResponse;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.valueOf(400), "Sai tài khoản hoặc mật khẩu");
        }
    }

    @Override
    public RegisterResponse register(RegisterRequest registerRequest) {

        if (userRepository.findByPhone(registerRequest.getPhone()) != null)
            throw new ResponseStatusException(HttpStatus.valueOf(400), "Số điện thoại đã được đăng kí");
        if (userRepository.findByEmail(registerRequest.getEmail()) != null)
            throw new ResponseStatusException(HttpStatus.valueOf(400), "Email đã được đăng kí!!");
        try {
            User user = User.builder()
                    .phone(registerRequest.getPhone())
                    .password(passwordEncoder.encode(registerRequest.getPassword()))
                    .role(roleRepository.findByName("USER"))
                    .status("NO_VERIFIED")
                    .email(registerRequest.getEmail())
                    .otp(Util.generateOtp(5))
                    .build();
            user = userRepository.save(user);

            RegisterResponse registerResponse = RegisterResponse.builder()
                    .email(user.getEmail())
                    .phone(user.getPhone())
                    .build();
            return registerResponse;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.valueOf(400), "Không thể đăng ký vào hệ thống");
        }
    }

    @Override
    public Boolean verified(String otp) {
        User user = userRepository.findByOtp(otp);
        if (user != null) {
            user.setStatus("ACTIVE");
            user.setOtp("");
            userRepository.save(user);
        }
        else throw new ResponseStatusException(HttpStatus.valueOf(400), "Mã OTP bị sai");
        return true;
    }

    @Override
    public Boolean sendOTP(String email) {
        User user = userRepository.findByEmail(email);
        if (user == null) throw new ResponseStatusException(HttpStatus.valueOf(400), "Không tìm thấy email");
        EmailDTO emailDTO = EmailDTO.builder()
                .email(user.getEmail())
                .massage("Mã OTP Để xác thực của bạn là " + user.getOtp())
                .subject("Xác thực tài khoản LOCKER")
                .build();
        emailService.sendSimpleMail(emailDTO);
        return true;
    }

}

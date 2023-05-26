package locker.api.controller;

import locker.api.dto.auth.request.LoginRequest;
import locker.api.dto.common.ResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RequiredArgsConstructor
@RestController
@RequestMapping("api/v1/test")
public class TestAPIController {

    @GetMapping("admin-role")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public ResponseEntity<ResponseDTO> testAdminRole(){
        ResponseDTO responseDTO = ResponseDTO.builder()
                .data("Bạn là Admin")
                .build();
        return  ResponseEntity.ok().body(responseDTO);
    }
    @GetMapping("user-role")
    @PreAuthorize("hasAnyRole('USER')")
    public ResponseEntity<ResponseDTO> testUserRole(){
        ResponseDTO responseDTO = ResponseDTO.builder()
                .data("Bạn là user")
                .build();
        return  ResponseEntity.ok().body(responseDTO);
    }
}

package locker.api.authentication;

import locker.api.entities.User;
import locker.api.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MyUserService implements UserDetailsService {
    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User account = userRepository.showByPhoneOrEmail(username);
        if(account == null){
            throw new UsernameNotFoundException("USER_NOT_FOUND");
        }
        return new MyUserDetail(account);
    }
}


package locker.api.repositories;

import locker.api.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User,Integer> {
    @Query("SELECT u FROM User u WHERE u.phone = :username or u.email = :username")
    User showByPhoneOrEmail(String username);

    User findByEmail(String email);

    User findByPhone(String phone);

    User findByOtp(String otp);
}

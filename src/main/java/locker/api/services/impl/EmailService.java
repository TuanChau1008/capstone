package locker.api.services.impl;

import locker.api.dto.common.EmailDTO;

public interface EmailService {
    String sendSimpleMail(EmailDTO emailDTO);
}

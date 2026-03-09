package util;

import models.OrderDetail;
import java.util.List;

/**
 * @deprecated Moved to {@link services.EmailService}.
 *             This stub delegates to it for backward compatibility.
 *             Prefer importing {@code services.EmailService} directly.
 */
@Deprecated
public class EmailService {

    private EmailService() {}

    /** @deprecated Use {@link services.EmailService#sendVerificationEmail} instead. */
    @Deprecated
    public static boolean sendVerificationEmail(String userEmail, String userName,
            String code, String verifyLink) {
        return services.EmailService.sendVerificationEmail(userEmail, userName, code, verifyLink);
    }

    /** @deprecated Use {@link services.EmailService#sendOrderEmail} instead. */
    @Deprecated
    public static boolean sendOrderEmail(String userEmail, String userName,
            int orderId, List<OrderDetail> items) {
        return services.EmailService.sendOrderEmail(userEmail, userName, orderId, items);
    }
}



# Cấu trúc thư mục `web/`

Tổ chức theo **nghiệp vụ (auth, payment, blog, public)** để dễ quản lý UI/UX.

## Cây thư mục

```
web/
├── auth/                    # Đăng nhập, đăng ký, quên MK, OTP, thông tin cá nhân
│   ├── login.jsp
│   ├── signup.jsp
│   ├── forgot-password.jsp
│   ├── reset-password.jsp
│   ├── verify-otp.jsp
│   ├── change-password-profile.jsp
│   └── information.jsp
├── payment/                 # Thanh toán PayOS
│   ├── payment.jsp
│   ├── payment-success.jsp
│   └── payment-cancel.jsp
├── blog/                    # Tin tức, bài viết
│   ├── blog.jsp
│   └── blog_detail.jsp
├── public/                  # Trang công khai
│   ├── home.jsp             # Landing
│   ├── chat.jsp
│   ├── doctor-info.jsp
│   ├── phieukham.jsp
│   └── success.jsp
├── img/                     # Hình ảnh, video
├── js/                      # Script (home.js, calendar, dashboard...)
├── styles/                  # CSS (home.css, dashboard...)
├── scss/                    # Nguồn SCSS
├── fonts/
├── includes/                 # Header, footer, components
├── jsp/                     # JSP theo role
│   ├── doctor/
│   ├── manager/
│   ├── patient/
│   ├── staff/
│   ├── admin/
│   └── email_templates/
├── META-INF/
└── WEB-INF/                 # web.xml, taglib, error 404, lib
```

## URL tương ứng

| Nghiệp vụ | URL (context root) |
|-----------|--------------------|
| Đăng nhập | `/auth/login.jsp` |
| Đăng ký | `/auth/signup.jsp` |
| Quên mật khẩu | `/auth/forgot-password.jsp` |
| Trang chủ (landing) | `/public/home.jsp` (welcome: `LandingPageServlet` → forward đây) |
| Thanh toán | `/payment/payment.jsp`, `/payment/payment-success.jsp`, `/payment/payment-cancel.jsp` |
| Blog | `/blog/blog.jsp`, `/blog/blog_detail.jsp` |
| Chat | `/public/chat.jsp` |

## Quy ước

- **Tài nguyên tĩnh**: dùng `${pageContext.request.contextPath}/img/...`, `.../styles/...`, `.../js/...` trong JSP nằm trong thư mục con (auth, payment, blog, public).
- **Form action / link**: dùng context path khi ở trong thư mục con (vd: `${pageContext.request.contextPath}/ResetPasswordServlet`).
- **Servlet redirect**: dùng `auth/login.jsp`, `public/home.jsp`, `payment/payment-success.jsp` (relative) hoặc `request.getContextPath() + "/auth/login.jsp"`.

## Lưu ý

- Trước khi đổi nhánh Git: `git add` và `git commit` để tránh mất code.
- Filter (AuthenticationFilter, RoleFilter) đã cấu hình danh sách trang công khai theo đường dẫn mới.

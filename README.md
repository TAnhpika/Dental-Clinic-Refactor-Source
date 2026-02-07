# Hệ thống Quản lý Phòng khám Nha khoa

Ứng dụng web JSP/Servlet quản lý lịch hẹn, bệnh nhân, bác sĩ, nhân viên, thanh toán và dịch vụ nha khoa.

## Yêu cầu

- Java 11+
- Apache Tomcat 10+
- SQL Server (hoặc tương thích)
- Maven/NetBeans (build)

## Cấu hình

1. **Cơ sở dữ liệu:** Import script trong `src/dental_clinic.sql` và `DatabaseProjectBenhVien/`.
2. **Biến môi trường:** Copy `.env.example` thành `.env` và điền giá trị (Google OAuth, PayOS, Gemini, SMTP, v.v.). Xem chi tiết trong `.env.example`.
3. **Thư viện:** Project dùng thư mục `library_Assignment/` (cấu hình trong `nbproject/project.properties`).

## Chạy

- NetBeans: Mở project, chọn Run.
- Tomcat: Build WAR và deploy lên Tomcat; đảm bảo biến môi trường hoặc file `.env` được nạp (VM option `-Denv.file=/đường/dẫn/.env` nếu cần).

## Tài liệu kèm theo

- **Hướng Dẫn Sử Dụng.md** – Hướng dẫn sử dụng hệ thống cho người dùng.
- **dental_clinic_db_diagram.md** – Sơ đồ cơ sở dữ liệu (nếu có).

## Bảo mật

- Không commit file `.env` hoặc file chứa key/secret.
- Các key (Google, PayOS, Gemini, SMTP…) đọc từ biến môi trường hoặc file `.env`.

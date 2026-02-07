-- ============================================================
-- Thêm bác sĩ mẫu vào [dbo].[Doctors]
-- Bảng Doctors cần: user_id (phải tồn tại trong [dbo].[users], role DOCTOR)
-- ============================================================

-- Bước 1: Thêm user (role DOCTOR) nếu chưa có - để lấy user_id cho bác sĩ
-- (Bỏ qua nếu bạn đã có sẵn user_id dùng cho bác sĩ)
IF NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE email = N'bs.khamcoban@happysmile.com')
    INSERT INTO [dbo].[users] (password_hash, email, role) VALUES (N'12345', N'bs.khamcoban@happysmile.com', N'DOCTOR');
IF NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE email = N'bs.vesinh@happysmile.com')
    INSERT INTO [dbo].[users] (password_hash, email, role) VALUES (N'12345', N'bs.vesinh@happysmile.com', N'DOCTOR');
IF NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE email = N'bs.chinhnha@happysmile.com')
    INSERT INTO [dbo].[users] (password_hash, email, role) VALUES (N'12345', N'bs.chinhnha@happysmile.com', N'DOCTOR');
IF NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE email = N'bs.phauthuat@happysmile.com')
    INSERT INTO [dbo].[users] (password_hash, email, role) VALUES (N'12345', N'bs.phauthuat@happysmile.com', N'DOCTOR');
IF NOT EXISTS (SELECT 1 FROM [dbo].[users] WHERE email = N'bs.thammy@happysmile.com')
    INSERT INTO [dbo].[users] (password_hash, email, role) VALUES (N'12345', N'bs.thammy@happysmile.com', N'DOCTOR');
GO

-- Bước 2: Thêm bác sĩ mẫu (chuyên khoa trùng với category trong Services)
INSERT INTO [dbo].[Doctors] (user_id, full_name, phone, address, date_of_birth, gender, specialty, license_number, status)
SELECT u.user_id, N'BS. Nguyễn Khám Cơ Bản', N'0901000101', N'Q.1, TP.HCM', '1985-01-10', N'male', N'Khám cơ bản', N'BS-KCB-001', N'active'
FROM [dbo].[users] u WHERE u.email = N'bs.khamcoban@happysmile.com' AND NOT EXISTS (SELECT 1 FROM [dbo].[Doctors] d WHERE d.user_id = u.user_id);

INSERT INTO [dbo].[Doctors] (user_id, full_name, phone, address, date_of_birth, gender, specialty, license_number, status)
SELECT u.user_id, N'BS. Trần Vệ Sinh', N'0902000202', N'Q.3, TP.HCM', '1988-05-20', N'female', N'Vệ sinh răng', N'BS-VSR-001', N'active'
FROM [dbo].[users] u WHERE u.email = N'bs.vesinh@happysmile.com' AND NOT EXISTS (SELECT 1 FROM [dbo].[Doctors] d WHERE d.user_id = u.user_id);

INSERT INTO [dbo].[Doctors] (user_id, full_name, phone, address, date_of_birth, gender, specialty, license_number, status)
SELECT u.user_id, N'BS. Lê Chỉnh Nha', N'0903000303', N'Q.5, TP.HCM', '1982-11-15', N'male', N'Chỉnh nha', N'BS-CN-001', N'active'
FROM [dbo].[users] u WHERE u.email = N'bs.chinhnha@happysmile.com' AND NOT EXISTS (SELECT 1 FROM [dbo].[Doctors] d WHERE d.user_id = u.user_id);

INSERT INTO [dbo].[Doctors] (user_id, full_name, phone, address, date_of_birth, gender, specialty, license_number, status)
SELECT u.user_id, N'BS. Phạm Phẫu Thuật', N'0904000404', N'Q.7, TP.HCM', '1979-03-08', N'male', N'Phẫu thuật', N'BS-PT-001', N'active'
FROM [dbo].[users] u WHERE u.email = N'bs.phauthuat@happysmile.com' AND NOT EXISTS (SELECT 1 FROM [dbo].[Doctors] d WHERE d.user_id = u.user_id);

INSERT INTO [dbo].[Doctors] (user_id, full_name, phone, address, date_of_birth, gender, specialty, license_number, status)
SELECT u.user_id, N'BS. Hoàng Thẩm Mỹ', N'0905000505', N'Q.10, TP.HCM', '1990-07-22', N'female', N'Thẩm mỹ', N'BS-TM-001', N'active'
FROM [dbo].[users] u WHERE u.email = N'bs.thammy@happysmile.com' AND NOT EXISTS (SELECT 1 FROM [dbo].[Doctors] d WHERE d.user_id = u.user_id);

GO
PRINT 'Insert sample doctors completed.';

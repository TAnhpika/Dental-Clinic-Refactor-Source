-- ============================================================
-- Điền bảng Specialties từ toàn bộ chuyên khoa có trong:
--   1) Services (cột category)
--   2) Doctors (cột specialty)
-- Chạy sau khi đã tạo bảng [dbo].[Specialties]
-- ============================================================

-- 1. Tạo bảng Specialties nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Specialties')
BEGIN
    CREATE TABLE [dbo].[Specialties] (
        [specialty_id]   INT            IDENTITY (1, 1) NOT NULL,
        [specialty_name] NVARCHAR (255) NOT NULL,
        [description]    NVARCHAR (500) NULL,
        [created_at]     DATETIME2 (7)  DEFAULT (getdate()) NULL,
        PRIMARY KEY CLUSTERED ([specialty_id] ASC),
        UNIQUE NONCLUSTERED ([specialty_name] ASC)
    );
    CREATE NONCLUSTERED INDEX [IX_Specialties_Name] ON [dbo].[Specialties]([specialty_name] ASC);
    PRINT 'Created table Specialties';
END
GO

-- 2. Fill từ Services.category (các chuyên khoa có trong dịch vụ)
INSERT INTO [dbo].[Specialties] ([specialty_name])
SELECT DISTINCT LTRIM(RTRIM(s.[category]))
FROM [dbo].[Services] s
WHERE s.[category] IS NOT NULL
  AND LTRIM(RTRIM(s.[category])) <> ''
  AND NOT EXISTS (
      SELECT 1 FROM [dbo].[Specialties] sp
      WHERE LTRIM(RTRIM(sp.specialty_name)) = LTRIM(RTRIM(s.category))
  );
PRINT 'Inserted specialties from Services.category: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' row(s)';
GO

-- 3. Fill từ Doctors.specialty (các chuyên khoa của bác sĩ, tránh trùng)
INSERT INTO [dbo].[Specialties] ([specialty_name])
SELECT DISTINCT LTRIM(RTRIM(d.[specialty]))
FROM [dbo].[Doctors] d
WHERE d.[specialty] IS NOT NULL
  AND LTRIM(RTRIM(d.[specialty])) <> ''
  AND NOT EXISTS (
      SELECT 1 FROM [dbo].[Specialties] sp
      WHERE LTRIM(RTRIM(sp.specialty_name)) = LTRIM(RTRIM(d.specialty))
  );
PRINT 'Inserted specialties from Doctors.specialty: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' row(s)';
GO

-- 4. (Tuỳ chọn) Gán Services.specialty_id theo category = specialty_name (nếu bảng Services đã có cột specialty_id)
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Services') AND name = 'specialty_id')
BEGIN
    UPDATE s
    SET s.specialty_id = sp.specialty_id
    FROM [dbo].[Services] s
    INNER JOIN [dbo].[Specialties] sp ON LTRIM(RTRIM(sp.specialty_name)) = LTRIM(RTRIM(s.category));
    PRINT 'Updated Services.specialty_id from category: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' row(s)';

    -- Service nào không khớp -> gán "Khác"
    IF EXISTS (SELECT 1 FROM [dbo].[Services] WHERE specialty_id IS NULL)
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] WHERE specialty_name = N'Khác')
            INSERT INTO [dbo].[Specialties] ([specialty_name]) VALUES (N'Khác');
        UPDATE [dbo].[Services]
        SET specialty_id = (SELECT TOP 1 specialty_id FROM [dbo].[Specialties] WHERE specialty_name = N'Khác')
        WHERE specialty_id IS NULL;
        PRINT 'Assigned NULL Services to specialty Khác.';
    END
END
GO

PRINT 'Fill Specialties from Services and Doctors completed.';
-- Kiểm tra kết quả:
-- SELECT * FROM [dbo].[Specialties] ORDER BY specialty_name;

-- ============================================================
-- Migration: Thêm bảng Specialties và liên kết Services với chuyên khoa
-- Mỗi dịch vụ tương ứng 1 chuyên khoa (giống bác sĩ)
-- Chạy trên DB đã có bảng Services và Doctors
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

-- 2. Nạp chuyên khoa từ Doctors (tránh trùng)
INSERT INTO [dbo].[Specialties] ([specialty_name])
SELECT DISTINCT LTRIM(RTRIM(d.[specialty]))
FROM [dbo].[Doctors] d
WHERE d.[specialty] IS NOT NULL AND LTRIM(RTRIM(d.[specialty])) <> ''
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] s WHERE LTRIM(RTRIM(s.specialty_name)) = LTRIM(RTRIM(d.specialty)));
PRINT 'Inserted specialties from Doctors';
GO

-- 3. Nạp chuyên khoa từ Services.category (nếu có category chưa có trong Specialties)
INSERT INTO [dbo].[Specialties] ([specialty_name])
SELECT DISTINCT LTRIM(RTRIM(srv.[category]))
FROM [dbo].[Services] srv
WHERE srv.[category] IS NOT NULL AND LTRIM(RTRIM(srv.[category])) <> ''
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] s WHERE LTRIM(RTRIM(s.specialty_name)) = LTRIM(RTRIM(srv.category)));
PRINT 'Inserted specialties from Services.category';
GO

-- 4. Thêm cột specialty_id vào Services (nếu chưa có)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Services') AND name = 'specialty_id')
BEGIN
    ALTER TABLE [dbo].[Services] ADD [specialty_id] INT NULL;
    PRINT 'Added column Services.specialty_id';
END
GO

-- 5. Gán specialty_id cho Services theo category = specialty_name
UPDATE srv
SET srv.specialty_id = s.specialty_id
FROM [dbo].[Services] srv
INNER JOIN [dbo].[Specialties] s ON LTRIM(RTRIM(s.specialty_name)) = LTRIM(RTRIM(srv.category));
PRINT 'Updated Services.specialty_id from category';
GO

-- 6. Đặt NOT NULL và FK (chỉ khi dữ liệu đã đầy đủ)
-- Nếu có service nào category không khớp chuyên khoa nào -> gán specialty_id = 1 hoặc tạo "Khác"
IF EXISTS (SELECT 1 FROM [dbo].[Services] WHERE specialty_id IS NULL)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] WHERE specialty_name = N'Khác')
        INSERT INTO [dbo].[Specialties] ([specialty_name]) VALUES (N'Khác');
    UPDATE [dbo].[Services] SET specialty_id = (SELECT TOP 1 specialty_id FROM [dbo].[Specialties] WHERE specialty_name = N'Khác') WHERE specialty_id IS NULL;
END
GO

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Services') AND name = 'specialty_id')
BEGIN
    ALTER TABLE [dbo].[Services] ALTER COLUMN [specialty_id] INT NOT NULL;
    IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Services_Specialties')
    BEGIN
        ALTER TABLE [dbo].[Services]
        ADD CONSTRAINT [FK_Services_Specialties] FOREIGN KEY ([specialty_id]) REFERENCES [dbo].[Specialties]([specialty_id]);
        PRINT 'Added FK_Services_Specialties';
    END
    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Services_SpecialtyId' AND object_id = OBJECT_ID('dbo.Services'))
    BEGIN
        CREATE NONCLUSTERED INDEX [IX_Services_SpecialtyId] ON [dbo].[Services]([specialty_id] ASC);
    END
END
GO

PRINT 'Migration Add_Specialties_And_Link_Services completed.';

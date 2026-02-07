-- ============================================================
-- Backfill Services.specialty_id (chạy sau khi đã tạo bảng Specialties và cột + FK)
-- ============================================================

-- 1. Nạp chuyên khoa từ Doctors (tránh trùng)
INSERT INTO [dbo].[Specialties] ([specialty_name])
SELECT DISTINCT LTRIM(RTRIM(d.[specialty]))
FROM [dbo].[Doctors] d
WHERE d.[specialty] IS NOT NULL AND LTRIM(RTRIM(d.[specialty])) <> ''
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] s WHERE LTRIM(RTRIM(s.specialty_name)) = LTRIM(RTRIM(d.specialty)));
GO

-- 2. Nạp chuyên khoa từ Services.category
INSERT INTO [dbo].[Specialties] ([specialty_name])
SELECT DISTINCT LTRIM(RTRIM(srv.[category]))
FROM [dbo].[Services] srv
WHERE srv.[category] IS NOT NULL AND LTRIM(RTRIM(srv.[category])) <> ''
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] s WHERE LTRIM(RTRIM(s.specialty_name)) = LTRIM(RTRIM(srv.category)));
GO

-- 3. Gán specialty_id theo category = specialty_name
UPDATE srv
SET srv.specialty_id = s.specialty_id
FROM [dbo].[Services] srv
INNER JOIN [dbo].[Specialties] s ON LTRIM(RTRIM(s.specialty_name)) = LTRIM(RTRIM(srv.category));
GO

-- 4. Service nào chưa có chuyên khoa -> gán "Khác"
IF NOT EXISTS (SELECT 1 FROM [dbo].[Specialties] WHERE specialty_name = N'Khác')
    INSERT INTO [dbo].[Specialties] ([specialty_name]) VALUES (N'Khác');

UPDATE [dbo].[Services]
SET specialty_id = (SELECT TOP 1 specialty_id FROM [dbo].[Specialties] WHERE specialty_name = N'Khác')
WHERE specialty_id IS NULL;
GO

-- 5. Đặt NOT NULL (chỉ chạy nếu đã backfill hết, FK đã tạo)
BEGIN TRY
    ALTER TABLE [dbo].[Services] ALTER COLUMN [specialty_id] INT NOT NULL;
    PRINT 'Services.specialty_id set to NOT NULL.';
END TRY
BEGIN CATCH
    PRINT 'Could not set NOT NULL (maybe already NOT NULL or FK missing): ' + ERROR_MESSAGE();
END CATCH
GO

-- 6. Index (bỏ qua nếu đã có)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Services_SpecialtyId' AND object_id = OBJECT_ID('dbo.Services'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Services_SpecialtyId] ON [dbo].[Services]([specialty_id] ASC);
    PRINT 'Created IX_Services_SpecialtyId.';
END
GO

PRINT 'Backfill Services.specialty_id completed.';

-- Script cập nhật giá dịch vụ "Khám tổng quát" thành 50,000 VNĐ
-- Tác giả: TranHongPhuoc
-- Ngày tạo: 2025-01-02

USE [dental_clinic_db]
GO

-- Cập nhật giá dịch vụ "Khám tổng quát" từ 100,000 VNĐ thành 50,000 VNĐ
UPDATE [dbo].[Services] 
SET [price] = 50000,
    [updated_at] = GETDATE()
WHERE [service_name] = N'Khám tổng quát' 
  AND [status] = 'active';

-- Kiểm tra kết quả cập nhật
SELECT [service_id], [service_name], [price], [status], [updated_at]
FROM [dbo].[Services] 
WHERE [service_name] = N'Khám tổng quát';

-- Hiển thị tất cả dịch vụ để kiểm tra
SELECT [service_id], [service_name], [price], [category], [status]
FROM [dbo].[Services] 
WHERE [status] = 'active'
ORDER BY [price] ASC;

PRINT '✅ Đã cập nhật giá dịch vụ "Khám tổng quát" thành 50,000 VNĐ thành công!'; 
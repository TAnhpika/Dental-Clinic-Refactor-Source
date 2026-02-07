-- Bảng tham chiếu Chuyên khoa (dùng chung cho Bác sĩ và Dịch vụ)
-- Mỗi dịch vụ tương ứng 1 chuyên khoa; mỗi bác sĩ cũng thuộc 1 chuyên khoa
CREATE TABLE [dbo].[Specialties] (
    [specialty_id]   INT            IDENTITY (1, 1) NOT NULL,
    [specialty_name] NVARCHAR (255) NOT NULL,
    [description]    NVARCHAR (500) NULL,
    [created_at]     DATETIME2 (7)  DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([specialty_id] ASC),
    UNIQUE NONCLUSTERED ([specialty_name] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_Specialties_Name]
    ON [dbo].[Specialties]([specialty_name] ASC);


GO

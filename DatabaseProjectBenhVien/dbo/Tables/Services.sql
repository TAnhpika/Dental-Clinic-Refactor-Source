-- Bảng Specialties phải được tạo trước (dbo.Tables/Specialties.sql)
CREATE TABLE [dbo].[Services] (
    [service_id]   INT             IDENTITY (1, 1) NOT NULL,
    [service_name] NVARCHAR (255)  NOT NULL,
    [description]  NVARCHAR (1000) NULL,
    [price]        MONEY           NOT NULL,
    [status]       NVARCHAR (50)   DEFAULT ('active') NOT NULL,
    [category]     NVARCHAR (100)  NOT NULL,
    [specialty_id] INT             NOT NULL,
    [created_at]   DATETIME2 (7)   DEFAULT (getdate()) NULL,
    [updated_at]   DATETIME2 (7)   DEFAULT (getdate()) NULL,
    [created_by]   NVARCHAR (100)  NULL,
    [image]        NVARCHAR (500)  NULL,
    PRIMARY KEY CLUSTERED ([service_id] ASC),
    CONSTRAINT [FK_Services_Specialties] FOREIGN KEY ([specialty_id]) REFERENCES [dbo].[Specialties]([specialty_id]),
    CHECK ([price]>=(0)),
    CHECK ([status]='discontinued' OR [status]='inactive' OR [status]='active')
);


GO

CREATE NONCLUSTERED INDEX [IX_Services_Price]
    ON [dbo].[Services]([price] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_Services_Name]
    ON [dbo].[Services]([service_name] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_Services_Status]
    ON [dbo].[Services]([status] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_Services_Category]
    ON [dbo].[Services]([category] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_Services_SpecialtyId]
    ON [dbo].[Services]([specialty_id] ASC);


GO


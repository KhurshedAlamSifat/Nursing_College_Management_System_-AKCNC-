USE [DB_AKCNC]
GO
/****** Object:  Table [dbo].[acc_StudentDue_2021_to_2030]    Script Date: 5/2/2023 10:02:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acc_StudentDue_2021_to_2030](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransectionIdentifier] [varchar](50) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[TrackingId] [varchar](50) NULL,
	[EffectiveYear] [int] NOT NULL,
	[EffectiveMonthSerial] [int] NOT NULL,
	[EffectiveYearAndMonthSerial] [varchar](10) NOT NULL,
	[StudentId] [int] NOT NULL,
	[FeeHeadId] [int] NOT NULL,
	[DefaultAmount] [decimal](18, 2) NOT NULL,
	[WaiverPercentage] [decimal](5, 2) NULL,
	[AppliedAmount] [decimal](18, 2) NOT NULL,
	[ChargeBy] [varchar](20) NOT NULL,
	[ShortStatus] [varchar](20) NOT NULL,
	[LongStatus] [varchar](50) NULL,
	[StudentFeeMappingId] [int] NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Invoice_TransectionIdentifier] [varchar](50) NULL,
	[StudentNewBalance] [decimal](18, 2) NULL,
	[PaidBy] [nvarchar](50) NULL,
	[PaidDate] [datetime] NULL,
	[Note] [varchar](100) NULL,
	[DeveloperNote] [varchar](50) NULL,
 CONSTRAINT [PK_acc_StudentDue_2021_to_2030] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

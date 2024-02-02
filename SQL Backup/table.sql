USE [school]
GO
/****** Object:  Table [dbo].[_acc_Expense]    Script Date: 1/11/2023 6:23:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_acc_Expense](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseCategoryId] [int] NULL,
	[ExpenseBy] [nvarchar](50) NULL,
	[ExpenseDate] [datetime] NULL,
	[Amount] [decimal](10, 2) NULL,
	[Purpose] [nvarchar](max) NULL,
	[Attechment] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_acc_Expense] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_acc_ExpenseCategory]    Script Date: 1/11/2023 6:23:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_acc_ExpenseCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseCategory] [nvarchar](250) NULL,
 CONSTRAINT [PK_acc_ExpenseCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_acc_Income]    Script Date: 1/11/2023 6:23:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_acc_Income](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IncomeCategoryId] [int] NULL,
	[Date] [datetime] NULL,
	[Amount] [decimal](10, 2) NULL,
	[Attachment] [nvarchar](250) NULL,
	[Details] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_acc_Income] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_acc_IncomeCategory]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_acc_IncomeCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IncomeCategory] [nvarchar](250) NULL,
 CONSTRAINT [PK_acc_IncomeCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acc_FeeHead]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acc_FeeHead](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FcCode] [varchar](50) NOT NULL,
	[FullName] [varchar](100) NOT NULL,
	[DisplayName] [varchar](10) NOT NULL,
	[ClassId] [int] NULL,
	[ChargeBy] [varchar](20) NOT NULL,
	[DefaultAmount] [decimal](18, 2) NOT NULL,
	[IsActive] [varchar](10) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[PriorityOrder] [int] NOT NULL,
 CONSTRAINT [PK_acc_FeeHead] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_FeeHead_FeeTitle_ClassId] UNIQUE NONCLUSTERED 
(
	[FullName] ASC,
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acc_StudentDue_2021_to_2030]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acc_StudentDue_2021_to_2030](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransectionIdentifier] [varchar](50) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[TrackingId] [varchar](50) NULL,
	[Invoice_TransectionIdentifier] [varchar](50) NULL,
	[EffectiveYear] [int] NOT NULL,
	[EffectiveMonthSerial] [int] NOT NULL,
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
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[Note] [varchar](100) NULL,
	[DeveloperNote] [varchar](50) NULL,
 CONSTRAINT [PK_acc_StudentDue_2021_to_2030] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acc_StudentFeeInvoice]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acc_StudentFeeInvoice](
	[Id] [int] NOT NULL,
	[TransectionIdentifier] [uniqueidentifier] NOT NULL,
	[DepositedAmount] [decimal](18, 2) NOT NULL,
	[UpdatedBalance] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_acc_StudentFeeInvoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acc_StudentFeeMapping]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acc_StudentFeeMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[FeeHeadId] [int] NOT NULL,
	[DefaultAmount] [decimal](18, 2) NOT NULL,
	[WaiverPercentage] [decimal](5, 2) NULL,
	[AppliedAmount] [decimal](18, 2) NOT NULL,
	[IsActive] [varchar](10) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_acc_StudentFeeMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_StudentId_FeeHeadId] UNIQUE NONCLUSTERED 
(
	[StudentId] ASC,
	[FeeHeadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acc_StudentInvoice_2021_to_2030]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acc_StudentInvoice_2021_to_2030](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransectionIdentifier] [varchar](50) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[TrackingId] [varchar](50) NULL,
	[StudentId] [int] NOT NULL,
	[EffectiveYear] [int] NOT NULL,
	[DepositedAmount] [decimal](18, 2) NOT NULL,
	[UpdatedBalance] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Note] [varchar](100) NULL,
	[DeveloperNote] [varchar](50) NULL,
 CONSTRAINT [PK_acc_StudentInvoice_2021_to_2030] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ad_ApplicantsQuota]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_ApplicantsQuota](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [bigint] NULL,
	[QuotaId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ad_Application]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_Application](
	[Id] [bigint] IDENTITY(100000,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[FathersName] [nvarchar](100) NULL,
	[MothersName] [nvarchar](100) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Address] [nvarchar](100) NULL,
	[PostOffice] [nvarchar](50) NULL,
	[PostCode] [nvarchar](10) NULL,
	[ThanaId] [int] NULL,
	[MobileHome] [nvarchar](20) NULL,
	[GenderId] [int] NULL,
	[ReligionId] [int] NULL,
	[CircularId] [int] NULL,
	[ApplicationDate] [date] NULL,
	[DateofBirth] [date] NULL,
	[Image] [nvarchar](150) NULL,
	[PaymentStatus] [bit] NULL,
	[PaymentCode] [nvarchar](50) NULL,
	[PaymentMethodId] [int] NULL,
	[PayDate] [date] NULL,
	[Email] [nvarchar](100) NULL,
	[IsSelected] [bit] NULL,
	[Code] [int] NULL,
	[Nationality] [nvarchar](100) NULL,
	[Reference] [nvarchar](150) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	[IsAdmitted] [bit] NULL,
	[GroupId] [int] NULL,
	[Marks] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ad_Application] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ad_Circular]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_Circular](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[ClassId] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[ApplicationFee] [decimal](18, 2) NULL,
	[Title] [nvarchar](100) NULL,
	[Details] [nvarchar](max) NULL,
	[Attachment] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[Vacancy] [int] NULL,
	[ResultPublished] [bit] NULL,
	[AdmissionFee] [decimal](18, 0) NULL,
	[PassMarks] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ad_ExamSchedule]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_ExamSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CircularId] [int] NULL,
	[ExamDate] [date] NULL,
	[ExamStartTime] [nvarchar](50) NULL,
	[ExamEndTime] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK__ad_ExamS__3214EC071A69E950] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_APIAccess]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_APIAccess](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[AccessKey] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[CreateDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_BloodGroup]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_BloodGroup](
	[Id] [int] NOT NULL,
	[BloodGroup] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_ClassName]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_ClassName](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](50) NULL,
	[ClassNumber] [int] NULL,
	[TotalSubject] [int] NULL,
 CONSTRAINT [PK_bs_ClassName] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_ClassRoutine]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_ClassRoutine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
	[ShiftId] [int] NULL,
	[SectionId] [int] NULL,
	[Period] [int] NULL,
	[SubjectId] [int] NULL,
	[StartTime] [nvarchar](50) NULL,
	[EndTime] [nvarchar](50) NULL,
	[Day] [nvarchar](50) NULL,
	[TeacherId] [int] NULL,
 CONSTRAINT [PK_bs_ClassRoutine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Content]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Content](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
	[ShiftId] [int] NULL,
	[SectionId] [int] NULL,
	[Sequence] [int] NULL,
	[Title] [nvarchar](200) NULL,
	[FileName] [nvarchar](200) NULL,
	[VisibleFileName] [nvarchar](100) NULL,
	[YoutubeId] [nvarchar](200) NULL,
	[Status] [nvarchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[Updatedate] [datetime] NULL,
 CONSTRAINT [PK_bs_Content] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Designation]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Designation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Designation] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_Designation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_District]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_District](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DivisionId] [int] NULL,
	[District] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_District] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Division]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Division](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Division] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_Devision] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_EventCalendar]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_EventCalendar](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](200) NULL,
	[title] [nvarchar](200) NULL,
	[event_start] [datetime] NULL,
	[event_end] [datetime] NULL,
	[all_day] [bit] NULL,
 CONSTRAINT [PK_ECICalendarEvent_Test] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_ExamRoutine]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_ExamRoutine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
	[ShiftId] [int] NULL,
	[ExamDate] [nvarchar](30) NULL,
	[StartTime] [nvarchar](10) NULL,
	[EndTime] [nvarchar](10) NULL,
	[SubjectId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ExamTypeId] [int] NULL,
 CONSTRAINT [PK_bs_ExamRoutine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_ExamType]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_ExamType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamType] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_ExamType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Gender]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Gender](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Gender] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_Gender] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_GeneralSetting]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_GeneralSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Theme] [nvarchar](50) NULL,
	[DateFormat] [nvarchar](50) NULL,
	[TimeZone] [nvarchar](250) NULL,
	[Button] [nvarchar](50) NULL,
	[Panel] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_GeneralSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Group]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_HomePageSetup]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_HomePageSetup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Sequence] [int] NULL,
	[Title] [nvarchar](50) NULL,
	[Content] [nvarchar](max) NOT NULL,
	[ImageLink] [nvarchar](200) NULL,
	[YoutubeLink] [nvarchar](200) NULL,
	[Status] [nvarchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[Updatedate] [datetime] NULL,
 CONSTRAINT [PK_bs_HomePage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Nationality]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Nationality](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nationality] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_Nationality] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_News]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_News](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Date] [datetime] NULL,
	[ShortDescription] [nvarchar](250) NULL,
	[Details] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_bs_News] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Notice]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Notice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[ShortDescription] [nvarchar](250) NULL,
	[Details] [nvarchar](max) NULL,
	[Files] [nvarchar](120) NULL,
	[Date] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK__bs_Notic__3214EC0702925FBF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Notification]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[SendEmail] [bit] NULL,
	[SendSMS] [bit] NULL,
 CONSTRAINT [PK_bs_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_PaymentMethod]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_PaymentMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MethodName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Profession]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Profession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Profession] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_Profession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Qualification]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Qualification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Qualification] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_Qualification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Quota]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Quota](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuotaName] [nvarchar](50) NULL,
	[QuotaPercent] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_RegistrationNo]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_RegistrationNo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegNo] [int] NULL,
 CONSTRAINT [PK_bs_RegistrationNo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Religion]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Religion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Religion] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_Religion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_SchoolInformation]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_SchoolInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [nvarchar](50) NULL,
	[Logo] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Type] [nvarchar](50) NULL,
	[EstablishedDate] [datetime] NULL,
	[EstablishedBy] [nvarchar](250) NULL,
	[Address] [nvarchar](250) NULL,
	[EstablishedYear] [nvarchar](5) NULL,
 CONSTRAINT [PK_bs_SchoolInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Section]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Section](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Section] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_Section] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Shift]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Shift](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Shift] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_Shift] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_SMSGetway]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_SMSGetway](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[URL] [nvarchar](250) NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_SMSGetway] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_StaticContent]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_StaticContent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PageName] [nvarchar](50) NULL,
	[Contents] [nvarchar](max) NULL,
 CONSTRAINT [PK_bs_StaticContent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Subject]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Subject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectNameId] [int] NULL,
	[CategoryId] [int] NULL,
	[PaperName] [nvarchar](50) NULL,
	[PaperNo] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_bs_Subject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_SubjectCategory]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_SubjectCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectCategory] [nvarchar](250) NULL,
	[Example] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_SubjectCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_SubjectName]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_SubjectName](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectName] [nvarchar](50) NULL,
 CONSTRAINT [PK_bs_SubjectName] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Thana]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Thana](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DistrictId] [int] NULL,
	[Thana] [nvarchar](250) NULL,
 CONSTRAINT [PK_bs_Thana] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_UniqueVisit]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_UniqueVisit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NULL,
 CONSTRAINT [PK_bs_UniqueVisit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bs_Year]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bs_Year](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [nvarchar](50) NULL,
	[IsDefault] [bit] NULL,
 CONSTRAINT [PK_bs_Year] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email_Configuration]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email_Configuration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Server] [nvarchar](50) NULL,
	[Port] [int] NULL,
	[SSL] [bit] NULL,
 CONSTRAINT [PK_Email_Configuration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailConfig]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailConfig](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](250) NULL,
	[DisplayEmail] [nvarchar](250) NULL,
	[ReplyToEmail] [nvarchar](250) NULL,
	[SMTPServer] [nvarchar](250) NULL,
	[Port] [int] NULL,
	[SSL] [bit] NULL,
	[Authentication] [bit] NULL,
	[UserName] [nvarchar](250) NULL,
	[Password] [nvarchar](250) NULL,
	[IsEmailSent] [bit] NULL,
 CONSTRAINT [PK_EmailConfig] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailTemplate]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](200) NOT NULL,
	[Subject] [nvarchar](200) NOT NULL,
	[Variables] [nvarchar](500) NULL,
	[Body] [ntext] NULL,
 CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[er_StudentToClass]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[er_StudentToClass](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
	[ShiftId] [int] NULL,
	[SectionId] [int] NULL,
	[Year] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[RollNo] [int] NULL,
 CONSTRAINT [PK_ss_StudentToClass] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[er_SubjectToClass]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[er_SubjectToClass](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[PaperNo] [int] NULL,
	[CategoryId] [int] NULL,
	[IsOptional] [bit] NULL,
	[ResultCount] [bit] NULL,
 CONSTRAINT [PK_er_SubjectToClass] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[er_SubjectToStudent]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[er_SubjectToStudent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentToClassId] [int] NULL,
	[SubjectId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[IsOptional] [bit] NULL,
 CONSTRAINT [PK_er_SubjectToStudent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fee_PaymentForClass]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fee_PaymentForClass](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[YearId] [int] NULL,
	[Month] [nvarchar](50) NULL,
	[PaymentTypeId] [int] NULL,
	[Amount] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
 CONSTRAINT [PK_fee_PaymentForClass] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fee_PaymentType]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fee_PaymentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PaymentType] [nvarchar](256) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_fee_PaymentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fee_Scholarship]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fee_Scholarship](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[Years] [int] NOT NULL,
	[Months] [int] NOT NULL,
	[Amount] [decimal](18, 2) NULL,
	[Remarks] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[Updatedate] [datetime] NULL,
 CONSTRAINT [PK_ss_Scholarship] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC,
	[Years] ASC,
	[Months] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jb_JobApplication]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jb_JobApplication](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NULL,
	[FatherName] [varchar](50) NULL,
	[MotherName] [varchar](50) NULL,
	[DateOfBirth] [date] NULL,
	[ReligionId] [int] NULL,
	[GenderId] [int] NULL,
	[NID] [varchar](20) NULL,
	[MobileNumber] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[MPO_NTRCA] [varchar](20) NULL,
	[NationalityId] [int] NULL,
	[PresentAddress] [varchar](400) NULL,
	[PermanentAddress] [varchar](400) NULL,
	[FaceImageFileName] [varchar](50) NULL,
	[SignatureImageFileName] [varchar](50) NULL,
	[EducationMasterBoard] [varchar](50) NULL,
	[EducationMasterCollege] [varchar](100) NULL,
	[EducationMasterGroup] [varchar](50) NULL,
	[EducationMasterCgpa] [varchar](50) NULL,
	[EducationMasterPassingYear] [int] NULL,
	[EducationHonorsBoard] [varchar](50) NULL,
	[EducationHonorsCollege] [varchar](100) NULL,
	[EducationHonorsGroup] [varchar](50) NULL,
	[EducationHonorsCgpa] [varchar](50) NULL,
	[EducationHonorsPassingYear] [int] NULL,
	[EducationHscBoard] [varchar](50) NULL,
	[EducationHscCollege] [varchar](100) NULL,
	[EducationHscGroup] [varchar](50) NULL,
	[EducationHscCgpa] [varchar](50) NULL,
	[EducationHscPassingYear] [int] NULL,
	[EducationSscBoard] [varchar](50) NULL,
	[EducationSscCollege] [varchar](100) NULL,
	[EducationSscGroup] [varchar](50) NULL,
	[EducationSscCgpa] [varchar](50) NULL,
	[EducationSscPassingYear] [int] NULL,
	[EducationJscBoard] [varchar](50) NULL,
	[EducationJscCollege] [varchar](100) NULL,
	[EducationJscGroup] [varchar](50) NULL,
	[EducationJscCgpa] [varchar](50) NULL,
	[EducationJscPassingYear] [int] NULL,
	[TrainingCourseName_1] [varchar](100) NULL,
	[TrainingInstituteName_1] [varchar](100) NULL,
	[TrainingInstituteAddress_1] [varchar](100) NULL,
	[TrainingResult_1] [varchar](20) NULL,
	[TrainingStartDate_1] [varchar](20) NULL,
	[TrainingRunning_1] [varchar](10) NULL,
	[TrainingEndDate_1] [varchar](20) NULL,
	[TrainingCourseName_2] [varchar](100) NULL,
	[TrainingInstituteName_2] [varchar](100) NULL,
	[TrainingInstituteAddress_2] [varchar](100) NULL,
	[TrainingResult_2] [varchar](20) NULL,
	[TrainingStartDate_2] [varchar](20) NULL,
	[TrainingRunning_2] [varchar](10) NULL,
	[TrainingEndDate_2] [varchar](20) NULL,
	[TrainingCourseName_3] [varchar](100) NULL,
	[TrainingInstituteName_3] [varchar](100) NULL,
	[TrainingInstituteAddress_3] [varchar](100) NULL,
	[TrainingResult_3] [varchar](20) NULL,
	[TrainingStartDate_3] [varchar](20) NULL,
	[TrainingRunning_3] [varchar](10) NULL,
	[TrainingEndDate_3] [varchar](20) NULL,
	[ExperienceInstitute_1] [varchar](100) NULL,
	[ExperienceDepartment_1] [varchar](50) NULL,
	[ExperienceDesignation_1] [varchar](50) NULL,
	[ExperienceAddress_1] [varchar](100) NULL,
	[ExperienceStartDate_1] [varchar](20) NULL,
	[ExperienceRunning_1] [varchar](20) NULL,
	[ExperienceEndDate_1] [varchar](50) NULL,
	[ExperienceInstitute_2] [varchar](100) NULL,
	[ExperienceDepartment_2] [varchar](50) NULL,
	[ExperienceDesignation_2] [varchar](50) NULL,
	[ExperienceAddress_2] [varchar](100) NULL,
	[ExperienceStartDate_2] [varchar](20) NULL,
	[ExperienceRunning_2] [varchar](20) NULL,
	[ExperienceEndDate_2] [varchar](50) NULL,
	[ExperienceInstitute_3] [varchar](100) NULL,
	[ExperienceDepartment_3] [varchar](50) NULL,
	[ExperienceDesignation_3] [varchar](50) NULL,
	[ExperienceAddress_3] [varchar](100) NULL,
	[ExperienceStartDate_3] [varchar](20) NULL,
	[ExperienceRunning_3] [varchar](20) NULL,
	[ExperienceEndDate_3] [varchar](50) NULL,
 CONSTRAINT [PK_jb_Application] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_Book]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_Book](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[SubCategoryId] [int] NOT NULL,
	[TrackingId] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[TitleEng] [nvarchar](150) NOT NULL,
	[TitleBan] [nvarchar](150) NULL,
	[Author] [varchar](250) NULL,
	[ISBN] [varchar](50) NULL,
	[EditionId] [int] NULL,
	[CountryId] [int] NULL,
	[PublisherId] [int] NULL,
	[LanguageId] [int] NULL,
	[VolumeNo] [int] NULL,
	[SelfNo] [int] NULL,
	[CellNo] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[LendingStatus] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[Keywords] [nvarchar](100) NULL,
	[CoverPhoto] [varchar](150) NULL,
	[BookLendingId] [int] NULL,
 CONSTRAINT [PK_lb_Book] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Book_TrackingNum] UNIQUE NONCLUSTERED 
(
	[TrackingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_BookLending]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_BookLending](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NOT NULL,
	[UserId] [nvarchar](50) NOT NULL,
	[IssueDate] [date] NOT NULL,
	[TargatedReturnDate] [date] NULL,
	[StatusUpdationDate] [date] NULL,
	[Status] [varchar](20) NOT NULL,
	[Note] [varchar](100) NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDateTime] [datetime] NULL,
 CONSTRAINT [PK_lb_BookLending] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_BookRequest]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_BookRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NULL,
	[PersonId] [int] NULL,
	[ApplyDate] [datetime] NULL,
 CONSTRAINT [PK_lb_BookRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_Category]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](250) NULL,
 CONSTRAINT [PK_lb_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_Country]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](50) NULL,
 CONSTRAINT [PK_lb_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_Edition]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_Edition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Edition] [nvarchar](50) NULL,
 CONSTRAINT [PK_lb_Edition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_IssueBook]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_IssueBook](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NULL,
	[PersonId] [int] NULL,
	[IssueDate] [datetime] NULL,
	[ReturnDate] [datetime] NULL,
	[IsReturn] [bit] NULL,
	[IssueBy] [nvarchar](50) NULL,
	[ReceiveBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_lb_IssueBook] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_Language]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Language] [nvarchar](50) NULL,
 CONSTRAINT [PK_lb_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_Publisher]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_Publisher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Publisher] [nvarchar](250) NULL,
 CONSTRAINT [PK_lb_Publisher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lb_SubCategory]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lb_SubCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[SubCategory] [nvarchar](250) NULL,
 CONSTRAINT [PK_lb_SubCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nt_NoticeForClass]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nt_NoticeForClass](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[ClassId] [int] NULL,
	[NoticeId] [int] NULL,
 CONSTRAINT [PK_nt_NoticeForClass] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nt_NoticeForStudent]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nt_NoticeForStudent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SutdentToClassId] [int] NULL,
	[NoticeId] [int] NULL,
	[IsSeen] [bit] NULL,
	[SeenDate] [datetime] NULL,
 CONSTRAINT [PK_nt_StudentNotice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nt_NoticeForTeacher]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nt_NoticeForTeacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherId] [int] NULL,
	[NoticeId] [int] NULL,
	[IsSeen] [bit] NULL,
	[SeenDate] [datetime] NULL,
 CONSTRAINT [PK_nt_NoticeForTeacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nt_SeenNotice]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nt_SeenNotice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[NoticeId] [int] NULL,
	[IsSeen] [bit] NULL,
	[SeenDate] [datetime] NULL,
 CONSTRAINT [PK_nt_SeenNotice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_Allowance]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_Allowance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Allowance] [nvarchar](50) NULL,
 CONSTRAINT [PK_pr_Allowance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_AllowanceToType]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_AllowanceToType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NULL,
	[AllowanceId] [int] NULL,
	[AllowancePercent] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_pr_AllowanceToType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_Deduction]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_Deduction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Deduction] [nvarchar](50) NULL,
 CONSTRAINT [PK_pr_Deduction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_DeductionToType]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_DeductionToType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NULL,
	[DeductionId] [int] NULL,
	[DeductionPercent] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_pr_DeductionToType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_Increment]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_Increment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NULL,
	[StaffId] [int] NOT NULL,
	[IncrementAmount] [decimal](8, 2) NULL,
	[IncrementDate] [date] NULL,
 CONSTRAINT [PK_pr_Increment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_SalaryScale]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_SalaryScale](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Scale] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_pr_SalaryScale] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_StaffToType]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_StaffToType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NULL,
	[PinCode] [nvarchar](50) NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_pr_StaffToType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pr_Type]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pr_Type](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Basic] [decimal](8, 2) NULL,
	[ScaleId] [int] NULL,
 CONSTRAINT [PK_pr_Type] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PunchData]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchData](
	[RegNo] [nvarchar](50) NULL,
	[CDate] [nvarchar](8) NULL,
	[CTime] [nvarchar](6) NULL,
	[CardNo] [nvarchar](50) NULL,
	[LtId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RFID]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RFID](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [nvarchar](150) NULL,
	[CardNumber] [nvarchar](500) NULL,
	[GateNo] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_RFID] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RFID_Zitu]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RFID_Zitu](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CardTag_ID] [int] NOT NULL,
	[CardNo] [nvarchar](250) NOT NULL,
	[Vehicle] [nvarchar](250) NULL,
	[Driver] [nvarchar](250) NULL,
 CONSTRAINT [PK_RFID_Zitu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleSetup]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleSetup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Priority] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreateDate] [date] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[UpdateDate] [date] NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rs_FailSystem]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rs_FailSystem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectToClassId] [int] NULL,
	[SubjectiveFailMarks] [int] NULL,
	[ObjectiveFailMarks] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[Practical] [int] NULL,
 CONSTRAINT [PK_rs_FailSystem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rs_Grade]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rs_Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GradeName] [nvarchar](10) NULL,
	[GradePoint] [decimal](5, 2) NULL,
	[StartMarks] [decimal](5, 2) NULL,
	[EndMarks] [decimal](5, 2) NULL,
 CONSTRAINT [PK_rs_Grade] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rs_ObtainMarks]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rs_ObtainMarks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentToClassId] [int] NULL,
	[SubjectId] [int] NULL,
	[ExamTypeId] [int] NULL,
	[YearId] [int] NULL,
	[SubjectiveMarks] [decimal](5, 2) NULL,
	[ObjectiveMarks] [decimal](5, 2) NULL,
	[PracticalMarks] [decimal](5, 2) NULL,
	[OtherMarks] [decimal](5, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[BaseMarks] [decimal](5, 2) NULL,
	[CT1] [decimal](5, 2) NULL,
	[CT2] [decimal](5, 2) NULL,
	[CT3] [decimal](5, 2) NULL,
	[Grade] [nvarchar](5) NULL,
	[GradePoint] [decimal](5, 2) NULL,
	[IsPublished] [bit] NULL,
	[CTOutOf] [decimal](5, 2) NULL,
 CONSTRAINT [PK_rs_ObtainMarks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rs_Result]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rs_Result](
	[StudentToClassId] [int] NOT NULL,
	[YearId] [int] NOT NULL,
	[ExamTypeId] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[Marks] [decimal](18, 2) NULL,
	[Grade] [nvarchar](5) NULL,
	[GradePoint] [decimal](5, 2) NULL,
	[IsPublished] [bit] NULL,
	[Positions] [int] NULL,
	[ActualMarks] [decimal](5, 2) NULL,
 CONSTRAINT [PK_rs_Result] PRIMARY KEY CLUSTERED 
(
	[StudentToClassId] ASC,
	[YearId] ASC,
	[ExamTypeId] ASC,
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rt_ClassRoutine]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rt_ClassRoutine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PeriodId] [int] NULL,
	[ClassId] [int] NULL,
	[Years] [int] NULL,
	[ShiftId] [int] NULL,
	[GroupId] [int] NULL,
	[SectionId] [int] NULL,
	[Days] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rt_Period]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rt_Period](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Period] [nvarchar](50) NULL,
	[StartTime] [nvarchar](50) NULL,
	[EndTime] [nvarchar](50) NULL,
	[ShiftId] [int] NULL,
	[Orders] [int] NULL,
 CONSTRAINT [PK_rt_Period] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rt_SubAndTeacher]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rt_SubAndTeacher](
	[Id] [int] NULL,
	[RoutineId] [int] NULL,
	[SubjectId] [int] NULL,
	[TeacherId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SMSTemplete]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SMSTemplete](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Variable] [nvarchar](50) NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_SMSTemplete] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ss_Attendence]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ss_Attendence](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentToClassId] [int] NULL,
	[Date] [datetime] NULL,
	[IsPresent] [bit] NULL,
	[Month] [nvarchar](50) NULL,
	[Year] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[AttendenceType] [tinyint] NULL,
 CONSTRAINT [PK_ss_Attendence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ss_Payment]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ss_Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[Year] [nvarchar](50) NULL,
	[Month] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[DueAmount] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[TotalGiven] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[TxnID] [nvarchar](100) NULL,
	[PayerMobile] [nvarchar](50) NULL,
	[IsConfirmed] [bit] NULL,
	[PaymentTypeId] [int] NULL,
	[PayMode] [nvarchar](50) NULL,
 CONSTRAINT [PK_ss_Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ss_Payment_dbbl]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ss_Payment_dbbl](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[Date] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[TxnID] [nvarchar](100) NULL,
	[PayerMobile] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ss_Student]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ss_Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,
	[RegNo] [nvarchar](50) NOT NULL,
	[AdmissionDate] [datetime] NULL,
	[AdmissionYear] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[CardId] [nvarchar](20) NULL,
	[CardNo] [nvarchar](30) NULL,
	[ApplicationId] [bigint] NULL,
	[IsAdmitted] [bit] NULL,
	[Status] [int] NULL,
	[DisabledReg] [nvarchar](50) NULL,
	[DisabledPersonId] [int] NULL,
	[CurrentBalance] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ss_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ss_Student_TC]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ss_Student_TC](
	[Id] [int] NOT NULL,
	[PersonId] [int] NULL,
	[RegNo] [nvarchar](50) NOT NULL,
	[AdmissionDate] [datetime] NULL,
	[AdmissionYear] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[CardId] [nvarchar](20) NULL,
	[CardNo] [nvarchar](30) NULL,
	[ApplicationId] [bigint] NULL,
	[IsAdmitted] [bit] NULL,
	[Status] [int] NULL,
	[DisabledReg] [nvarchar](50) NULL,
	[DisabledPersonId] [int] NULL,
	[CurrentBalance] [decimal](18, 2) NULL,
	[TcDate] [datetime] NULL,
	[Reason] [nvarchar](150) NULL,
 CONSTRAINT [PK__ss_Stude__3214EC074AC89440] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[st_ParmanentAddress]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[st_ParmanentAddress](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DivisionId] [int] NULL,
	[DistrictId] [int] NULL,
	[ThanaId] [int] NULL,
	[PostOffice] [nvarchar](250) NULL,
	[PostalCode] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_st_ParmanentAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[st_Person]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[st_Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameEng] [nvarchar](250) NULL,
	[NameBan] [nvarchar](250) NULL,
	[FatherNameEng] [nvarchar](250) NULL,
	[FatherNameBan] [nvarchar](250) NULL,
	[MotherNameEng] [nvarchar](250) NULL,
	[MotherNameBan] [nvarchar](250) NULL,
	[ReligionId] [int] NULL,
	[Nationality] [nvarchar](250) NULL,
	[DateofBirth] [datetime] NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[PhoneHome] [nvarchar](50) NULL,
	[MobileHome] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[BloodGroup] [nvarchar](50) NULL,
	[FatherNId] [nvarchar](50) NULL,
	[MotherNId] [nvarchar](50) NULL,
	[IsFreedomFighter] [bit] NULL,
	[IsTribal] [bit] NULL,
	[IsPhysicallyDefect] [bit] NULL,
	[FatherIncome] [int] NULL,
	[MotherIncome] [int] NULL,
	[FatherPhone] [nvarchar](50) NULL,
	[MotherPhone] [nvarchar](50) NULL,
	[FatherImage] [nvarchar](250) NULL,
	[MotherImage] [nvarchar](250) NULL,
	[FatherQualificationId] [int] NULL,
	[FatherProfessionId] [int] NULL,
	[MotherQualificationId] [int] NULL,
	[MotherProfessionId] [int] NULL,
	[PersonImage] [nvarchar](250) NULL,
	[GenderId] [int] NULL,
	[BirthCertificate] [nvarchar](50) NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_st_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[st_PresentAddress]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[st_PresentAddress](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,
	[DivisionId] [int] NULL,
	[DistrictId] [int] NULL,
	[ThanaId] [int] NULL,
	[PostOffice] [nvarchar](250) NULL,
	[PostalCode] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
 CONSTRAINT [PK_st_PresentAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskManager]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskManager](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextBan] [nvarchar](256) NULL,
	[TextEng] [nvarchar](256) NULL,
	[URL] [nvarchar](256) NULL,
	[ParentId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[ForAll] [bit] NULL,
	[OrderColumn] [int] NULL,
	[Icon] [nvarchar](100) NULL,
 CONSTRAINT [PK_TaskManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskPermission]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskPermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NULL,
	[RoleName] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_TaskPermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rs_Marks]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rs_Marks](
	[Id] [int] NOT NULL,
	[StudentToClassId] [int] NULL,
	[SubjectId] [int] NULL,
	[ExamTypeId] [int] NULL,
	[YearId] [int] NULL,
	[SubjectiveMarks] [decimal](5, 2) NULL,
	[ObjectiveMarks] [decimal](5, 2) NULL,
	[PracticalMarks] [decimal](5, 2) NULL,
	[OtherMarks] [decimal](5, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[BaseMarks] [decimal](5, 2) NULL,
	[CT1] [decimal](5, 2) NULL,
	[CT2] [decimal](5, 2) NULL,
	[CT3] [decimal](5, 2) NULL,
	[Grade] [nvarchar](5) NULL,
	[GradePoint] [decimal](5, 2) NULL,
	[IsPublished] [bit] NULL,
	[SbID] [int] NULL,
	[SubjectName] [nvarchar](50) NULL,
	[Subjects] [nvarchar](56) NULL,
	[ClassId] [int] NULL,
	[GroupId] [int] NULL,
	[PaperNo] [int] NULL,
	[CategoryId] [int] NULL,
	[IsOptional] [bit] NULL,
	[CTOutOf] [decimal](5, 2) NULL,
	[ResultCount] [bit] NULL,
	[TotalSubject] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tr_Attendence]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tr_Attendence](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherId] [int] NULL,
	[Date] [datetime] NULL,
	[InTime] [nvarchar](50) NULL,
	[OutTime] [nvarchar](50) NULL,
	[Year] [nvarchar](50) NULL,
	[Month] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_tr_Attendence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tr_Education]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tr_Education](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DegreeName] [nvarchar](256) NULL,
	[Board] [nvarchar](256) NULL,
	[Grade] [nvarchar](50) NULL,
	[PassingYear] [nvarchar](50) NULL,
	[Subject] [nvarchar](50) NULL,
	[GPAScale] [nvarchar](50) NULL,
	[TeacherId] [int] NULL,
	[ResultDivision] [nvarchar](50) NULL,
 CONSTRAINT [PK_tr_Education] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tr_Leave]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tr_Leave](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DesignationId] [int] NULL,
	[Subject] [nvarchar](100) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [bit] NULL,
	[ApprovalFrom] [datetime] NULL,
	[ApprovalTo] [datetime] NULL,
	[ApprovedBy] [nvarchar](50) NULL,
	[ApprovedDate] [datetime] NULL,
	[Comments] [nvarchar](250) NULL,
	[AppliedDate] [datetime] NULL,
	[PinCode] [nvarchar](20) NULL,
 CONSTRAINT [PK_tr_Leave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tr_Payment]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tr_Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherId] [int] NULL,
	[Month] [nvarchar](50) NULL,
	[Year] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Amount] [int] NULL,
 CONSTRAINT [PK_tr_Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tr_Teacher]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tr_Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DesignationId] [int] NULL,
	[TeacherPin] [nvarchar](50) NULL,
	[Joindate] [datetime] NULL,
	[UserName] [nvarchar](250) NULL,
	[PersonId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[NId] [nvarchar](50) NULL,
 CONSTRAINT [PK_tr_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tr_Training]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tr_Training](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TrainingName] [nvarchar](256) NULL,
	[InstituteName] [nvarchar](256) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[TeacherId] [int] NULL,
	[Topics] [nvarchar](256) NULL,
	[Duration] [int] NULL,
 CONSTRAINT [PK_tr_Training] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/11/2023 6:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[Email] [nvarchar](150) NULL,
	[LastLoginDate] [date] NULL,
	[WrongPasswordAttempt] [int] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreateDate] [date] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[UpdateDate] [date] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ad_Application] ADD  CONSTRAINT [DF_ad_Application_ApplicationDate]  DEFAULT (getdate()) FOR [ApplicationDate]
GO
ALTER TABLE [dbo].[ad_Application] ADD  CONSTRAINT [DF_ad_Application_PaymentStatus]  DEFAULT ((0)) FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[ad_Application] ADD  CONSTRAINT [DF_ad_Application_IsSelected]  DEFAULT ((0)) FOR [IsSelected]
GO
ALTER TABLE [dbo].[ad_Application] ADD  CONSTRAINT [DF_ad_Application_Reference]  DEFAULT ('N/A') FOR [Reference]
GO
ALTER TABLE [dbo].[ad_Application] ADD  CONSTRAINT [DF_ad_Application_IsAdmitted]  DEFAULT ((0)) FOR [IsAdmitted]
GO
ALTER TABLE [dbo].[ad_Circular] ADD  CONSTRAINT [DF_ad_Circular_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ad_Circular] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ad_Circular] ADD  CONSTRAINT [DF_ad_Circular_ResultPublished]  DEFAULT ((0)) FOR [ResultPublished]
GO
ALTER TABLE [dbo].[ad_Circular] ADD  CONSTRAINT [DF_ad_Circular_PassMarks]  DEFAULT ((0)) FOR [PassMarks]
GO
ALTER TABLE [dbo].[ad_ExamSchedule] ADD  CONSTRAINT [DF_ad_ExamSchedule_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[bs_APIAccess] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[bs_ClassName] ADD  CONSTRAINT [DF_bs_ClassName_TotalResultSubject]  DEFAULT ((1)) FOR [TotalSubject]
GO
ALTER TABLE [dbo].[er_SubjectToClass] ADD  CONSTRAINT [DF_er_SubjectToClass_ResultCount]  DEFAULT ((1)) FOR [ResultCount]
GO
ALTER TABLE [dbo].[fee_PaymentForClass] ADD  CONSTRAINT [DF_fee_PaymentForClass_GroupId]  DEFAULT ((1)) FOR [GroupId]
GO
ALTER TABLE [dbo].[fee_Scholarship] ADD  CONSTRAINT [DF_ss_Scholarship_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[nt_NoticeForStudent] ADD  CONSTRAINT [DF_nt_StudentNotice_IsSeen]  DEFAULT ((0)) FOR [IsSeen]
GO
ALTER TABLE [dbo].[RFID] ADD  CONSTRAINT [DF_RFID_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[rs_ObtainMarks] ADD  CONSTRAINT [DF_rs_ObtainMarks_Grade]  DEFAULT (N'N/A') FOR [Grade]
GO
ALTER TABLE [dbo].[rs_ObtainMarks] ADD  CONSTRAINT [DF_rs_ObtainMarks_GradePoint]  DEFAULT ((0)) FOR [GradePoint]
GO
ALTER TABLE [dbo].[rs_ObtainMarks] ADD  CONSTRAINT [DF_rs_ObtainMarks_IsPublished]  DEFAULT ((0)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[rs_ObtainMarks] ADD  CONSTRAINT [DF_rs_ObtainMarks_CTOutOf]  DEFAULT ((0)) FOR [CTOutOf]
GO
ALTER TABLE [dbo].[rs_Result] ADD  CONSTRAINT [DF_rs_Result_GradePoint]  DEFAULT ((0)) FOR [GradePoint]
GO
ALTER TABLE [dbo].[rs_Result] ADD  CONSTRAINT [DF_rs_Result_IsPublished]  DEFAULT ((0)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[rs_Result] ADD  CONSTRAINT [DF_rs_Result_Positions]  DEFAULT ((100000)) FOR [Positions]
GO
ALTER TABLE [dbo].[rt_ClassRoutine] ADD  CONSTRAINT [DF_Table_1_Orders]  DEFAULT ((11)) FOR [ShiftId]
GO
ALTER TABLE [dbo].[rt_Period] ADD  CONSTRAINT [DF_rt_Period_Orders]  DEFAULT ((11)) FOR [Orders]
GO
ALTER TABLE [dbo].[ss_Payment] ADD  CONSTRAINT [DF_ss_Payment_DueAmount]  DEFAULT ((0)) FOR [DueAmount]
GO
ALTER TABLE [dbo].[ss_Payment] ADD  CONSTRAINT [DF_ss_Payment_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[ss_Payment] ADD  CONSTRAINT [DF_ss_Payment_TotalGiven]  DEFAULT ((0)) FOR [TotalGiven]
GO
ALTER TABLE [dbo].[ss_Payment] ADD  CONSTRAINT [DF_ss_Payment_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ss_Payment] ADD  CONSTRAINT [DF_ss_Payment_IsConfirmed]  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[ss_Payment] ADD  CONSTRAINT [DF_ss_Payment_PaymentTypeId]  DEFAULT ((0)) FOR [PaymentTypeId]
GO
ALTER TABLE [dbo].[ss_Payment_dbbl] ADD  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[ss_Student] ADD  CONSTRAINT [DF_ss_Student_IsAdmitted]  DEFAULT ((0)) FOR [IsAdmitted]
GO
ALTER TABLE [dbo].[ss_Student] ADD  CONSTRAINT [DF_ss_Student_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ss_Student_TC] ADD  CONSTRAINT [DF_ss_Student_TC_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[st_Person] ADD  CONSTRAINT [DF_st_Person_FatherIncome]  DEFAULT ((0)) FOR [FatherIncome]
GO
ALTER TABLE [dbo].[st_Person] ADD  CONSTRAINT [DF_st_Person_MotherIncome]  DEFAULT ((0)) FOR [MotherIncome]
GO
ALTER TABLE [dbo].[TaskManager] ADD  CONSTRAINT [DF_TaskManager_ForAll]  DEFAULT ((0)) FOR [ForAll]
GO
ALTER TABLE [dbo].[tr_Leave] ADD  CONSTRAINT [DF_tr_Leave_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[tr_Training] ADD  CONSTRAINT [DF_tr_Training_Duration]  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_WrongPasswordAttempt]  DEFAULT ((0)) FOR [WrongPasswordAttempt]
GO
ALTER TABLE [dbo].[ad_ApplicantsQuota]  WITH CHECK ADD  CONSTRAINT [fk_quota_applicationId] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[ad_Application] ([Id])
GO
ALTER TABLE [dbo].[ad_ApplicantsQuota] CHECK CONSTRAINT [fk_quota_applicationId]
GO
ALTER TABLE [dbo].[bs_District]  WITH CHECK ADD  CONSTRAINT [FK_bs_District_bs_Division] FOREIGN KEY([DivisionId])
REFERENCES [dbo].[bs_Division] ([Id])
GO
ALTER TABLE [dbo].[bs_District] CHECK CONSTRAINT [FK_bs_District_bs_Division]
GO
ALTER TABLE [dbo].[ss_Payment]  WITH CHECK ADD  CONSTRAINT [FK_ss_Payment_ss_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[ss_Student] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ss_Payment] CHECK CONSTRAINT [FK_ss_Payment_ss_Student]
GO
ALTER TABLE [dbo].[st_ParmanentAddress]  WITH CHECK ADD  CONSTRAINT [FK_st_ParmanentAddress_st_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[st_Person] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[st_ParmanentAddress] CHECK CONSTRAINT [FK_st_ParmanentAddress_st_Person]
GO
ALTER TABLE [dbo].[st_PresentAddress]  WITH CHECK ADD  CONSTRAINT [FK_st_PresentAddress_st_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[st_Person] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[st_PresentAddress] CHECK CONSTRAINT [FK_st_PresentAddress_st_Person]
GO
ALTER TABLE [dbo].[tr_Attendence]  WITH CHECK ADD  CONSTRAINT [FK_tr_Attendence_tr_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[tr_Teacher] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tr_Attendence] CHECK CONSTRAINT [FK_tr_Attendence_tr_Teacher]
GO
ALTER TABLE [dbo].[tr_Education]  WITH CHECK ADD  CONSTRAINT [FK_tr_Education_tr_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[tr_Teacher] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tr_Education] CHECK CONSTRAINT [FK_tr_Education_tr_Teacher]
GO
ALTER TABLE [dbo].[tr_Payment]  WITH CHECK ADD  CONSTRAINT [FK_tr_Payment_tr_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[tr_Teacher] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tr_Payment] CHECK CONSTRAINT [FK_tr_Payment_tr_Teacher]
GO
ALTER TABLE [dbo].[tr_Teacher]  WITH CHECK ADD  CONSTRAINT [FK_tr_Teacher_st_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[st_Person] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tr_Teacher] CHECK CONSTRAINT [FK_tr_Teacher_st_Person]
GO
ALTER TABLE [dbo].[tr_Training]  WITH CHECK ADD  CONSTRAINT [FK_tr_Training_tr_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[tr_Teacher] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tr_Training] CHECK CONSTRAINT [FK_tr_Training_tr_Teacher]
GO

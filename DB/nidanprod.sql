USE [master]
GO
/****** Object:  Database [NidanERP]    Script Date: 28/06/2017 05:34:05 PM ******/
CREATE DATABASE [NidanERP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NidanERP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NidanERP.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NidanERP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NidanERP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NidanERP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NidanERP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NidanERP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NidanERP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NidanERP] SET ARITHABORT OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NidanERP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NidanERP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NidanERP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NidanERP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NidanERP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NidanERP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NidanERP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NidanERP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NidanERP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NidanERP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NidanERP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NidanERP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NidanERP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NidanERP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NidanERP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NidanERP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NidanERP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NidanERP] SET  MULTI_USER 
GO
ALTER DATABASE [NidanERP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NidanERP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NidanERP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NidanERP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NidanERP] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NidanERP', N'ON'
GO
USE [NidanERP]
GO
/****** Object:  Table [dbo].[Absence]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Absence](
	[AbsenceId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelAbsenceEntitlementId] [int] NOT NULL,
	[AbsenceTypeId] [int] NOT NULL,
	[AbsenceStatusId] [int] NOT NULL,
	[AbsenceStatusByUser] [nvarchar](128) NULL,
	[AbsenceStatusDateTimeUtc] [datetime2](7) NULL,
	[Description] [nvarchar](max) NULL,
	[ReturnToWorkCompleted] [bit] NULL,
	[DoctorsNoteSupplied] [bit] NULL,
 CONSTRAINT [PK_Absence] PRIMARY KEY CLUSTERED 
(
	[AbsenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsenceDay]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsenceDay](
	[AbsenceDayId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsenceId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[AM] [bit] NOT NULL CONSTRAINT [DF_AbsenceDay_AM]  DEFAULT ((0)),
	[PM] [bit] NOT NULL CONSTRAINT [DF_AbsenceDay_PM]  DEFAULT ((0)),
	[Duration] [float] NOT NULL,
 CONSTRAINT [PK_AbsenceDay] PRIMARY KEY CLUSTERED 
(
	[AbsenceDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePeriod]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePeriod](
	[AbsencePeriodId] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_AbsencePeriod] PRIMARY KEY CLUSTERED 
(
	[AbsencePeriodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicy]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicy](
	[AbsencePolicyId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[WorkingPatternId] [int] NULL,
 CONSTRAINT [PK_AbsencePolicy] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicyEntitlement]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicyEntitlement](
	[AbsencePolicyEntitlementId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsenceTypeId] [int] NOT NULL,
	[FrequencyId] [int] NOT NULL,
	[Entitlement] [float] NOT NULL,
	[MaximumCarryForward] [float] NOT NULL,
	[IsUnplanned] [bit] NOT NULL,
	[IsPaid] [bit] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[HasEntitlement] [bit] NOT NULL,
 CONSTRAINT [PK_AbsencePolicyEntitlement] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyEntitlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsencePolicyPeriod]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsencePolicyPeriod](
	[AbsencePolicyPeriodId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[AbsencePeriodId] [int] NOT NULL,
 CONSTRAINT [PK_AbsencePolicyPeriod] PRIMARY KEY CLUSTERED 
(
	[AbsencePolicyPeriodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AbsenceStatus]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AbsenceStatus](
	[AbsenceStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AbsenceStatus] PRIMARY KEY CLUSTERED 
(
	[AbsenceStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AbsenceType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbsenceType](
	[AbsenceTypeId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_AbsenceType] PRIMARY KEY CLUSTERED 
(
	[AbsenceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Admission]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admission](
	[AdmissionId] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationId] [int] NOT NULL,
	[BatchId] [int] NULL,
	[CentreId] [int] NOT NULL,
	[AdmissionDate] [date] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
 CONSTRAINT [PK_Admission] PRIMARY KEY CLUSTERED 
(
	[AdmissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Alert]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alert](
	[AlertId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Alert] PRIMARY KEY CLUSTERED 
(
	[AlertId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AreaOfInterest]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AreaOfInterest](
	[AreaOfInterestId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_AreaOfInterest] PRIMARY KEY CLUSTERED 
(
	[AreaOfInterestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[OrganisationId] [int] NULL,
	[PersonnelId] [int] NULL,
	[CentreId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsersAlertSchedule]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsersAlertSchedule](
	[AspnetUsersAlertScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[AspNetUsersId] [nvarchar](128) NOT NULL,
	[AlertId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsersAlertSchedule] PRIMARY KEY CLUSTERED 
(
	[AspnetUsersAlertScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Attendance](
	[AttendanceId] [int] IDENTITY(1,1) NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[StudentCode] [varchar](100) NOT NULL,
	[InHour] [int] NULL,
	[InMinute] [int] NULL,
	[InTimeSpan] [varchar](50) NULL,
	[OutHour] [int] NULL,
	[OutMinute] [int] NULL,
	[OutTimeSpan] [varchar](50) NULL,
	[IsPresent] [bit] NULL,
	[AttendanceDate] [date] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED 
(
	[AttendanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Batch]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Batch](
	[BatchId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Intake] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[BatchStartDate] [date] NOT NULL,
	[BatchEndDate] [date] NOT NULL,
	[NumberOfHolidays] [int] NOT NULL,
	[NumberOfHoursDaily] [int] NOT NULL,
	[BatchStartTimeHours] [int] NOT NULL,
	[BatchStartTimeMinutes] [int] NOT NULL,
	[BatchStartTimeSpan] [varchar](10) NOT NULL,
	[BatchEndTimeHours] [int] NOT NULL,
	[BatchEndTimeMinutes] [int] NOT NULL,
	[BatchEndTimeSpan] [varchar](10) NOT NULL,
	[AssessmentDate] [date] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[Remarks] [varchar](1000) NULL,
	[Month] [int] NOT NULL,
	[NumberOfInstallment] [int] NOT NULL,
	[FirstInstallment] [int] NULL,
	[SecondInstallment] [int] NULL,
	[ThirdInstallment] [int] NULL,
	[FourthInstallment] [int] NULL,
	[FifthInstallment] [int] NULL,
	[SixthInstallment] [int] NULL,
	[SeventhInstallment] [int] NULL,
	[EighthInstallment] [int] NULL,
	[NinethInstallment] [int] NULL,
	[TenthInstallment] [int] NULL,
	[EleventhInstallment] [int] NULL,
	[TwelvethInstallment] [int] NULL,
	[RoomId] [int] NULL,
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[BatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchAttendance]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchAttendance](
	[BatchAttendanceId] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NULL,
	[AttendanceId] [int] NULL,
	[SubjectId] [int] NULL,
	[SessionId] [int] NULL,
	[Topic] [varchar](500) NULL,
	[BatchTrainerId] [int] NULL,
	[PersonnelId] [int] NULL,
	[StudentCode] [varchar](100) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_BatchAttendance] PRIMARY KEY CLUSTERED 
(
	[BatchAttendanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchDay]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchDay](
	[BatchDayId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[IsMonday] [bit] NOT NULL,
	[IsTuesday] [bit] NOT NULL,
	[IsWednesday] [bit] NOT NULL,
	[IsThursday] [bit] NOT NULL,
	[IsFriday] [bit] NOT NULL,
	[IsSaturday] [bit] NOT NULL,
	[IsSunday] [bit] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_BatchDay] PRIMARY KEY CLUSTERED 
(
	[BatchDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BatchTimePrefer]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BatchTimePrefer](
	[BatchTimePreferId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_BatchTimePrefer] PRIMARY KEY CLUSTERED 
(
	[BatchTimePreferId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchTrainer]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchTrainer](
	[BatchTrainerId] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_BatchTrainer] PRIMARY KEY CLUSTERED 
(
	[BatchTrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Brainstorming]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Brainstorming](
	[BrainstormingId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Brainstorming] PRIMARY KEY CLUSTERED 
(
	[BrainstormingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Budget]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Budget](
	[BudgetId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Building]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[BuildingId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[OrganisationId] [int] NOT NULL,
	[SiteId] [int] NOT NULL,
	[Address1] [nvarchar](100) NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CandidateFee]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CandidateFee](
	[CandidateFeeId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentDate] [datetime] NULL,
	[CandidateInstallmentId] [int] NULL,
	[PaidAmount] [decimal](18, 2) NULL,
	[PaymentModeId] [int] NOT NULL,
	[FeeTypeId] [int] NOT NULL,
	[ChequeNumber] [varchar](50) NULL,
	[ChequeDate] [datetime] NULL,
	[BankName] [varchar](1000) NULL,
	[Penalty] [decimal](18, 2) NULL,
	[InstallmentDate] [datetime] NULL,
	[StudentCode] [varchar](50) NULL,
	[InstallmentNumber] [int] NULL,
	[InstallmentAmount] [decimal](18, 2) NULL,
	[BalanceInstallmentAmount] [decimal](18, 2) NULL,
	[Particulars] [varchar](max) NULL,
	[FiscalYear] [varchar](50) NULL,
	[FollowUpDate] [datetime] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[IsPaymentDone] [bit] NOT NULL,
	[PersonnelId] [int] NULL,
	[IsPaidAmountOverride] [bit] NULL,
	[AdvancedAmount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_CandidateFee] PRIMARY KEY CLUSTERED 
(
	[CandidateFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CandidateFeeDetail]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateFeeDetail](
	[CandidateFeeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[CandidateInstallmentId] [int] NOT NULL,
	[AdmissionId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[TotalFee] [int] NOT NULL,
	[InstallmentNumber] [int] NOT NULL,
 CONSTRAINT [PK_CandidateFeeDetail] PRIMARY KEY CLUSTERED 
(
	[CandidateFeeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CandidateInstallment]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CandidateInstallment](
	[CandidateInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](50) NULL,
	[CourseFee] [decimal](18, 2) NULL,
	[DownPayment] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[NumberOfInstallment] [int] NULL,
	[LumpsumAmount] [decimal](18, 2) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[IsPercentageDiscount] [bit] NOT NULL,
	[IsTotalAmountDiscount] [bit] NOT NULL,
	[PaymentMethod] [varchar](100) NULL,
 CONSTRAINT [PK_CandidateInstallment] PRIMARY KEY CLUSTERED 
(
	[CandidateInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CasteCategory]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CasteCategory](
	[CasteCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Caste] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CasteCategory] PRIMARY KEY CLUSTERED 
(
	[CasteCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Centre]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centre](
	[CentreId] [int] IDENTITY(1,1) NOT NULL,
	[CentreCode] [varchar](100) NULL,
	[Name] [varchar](500) NOT NULL,
	[Address1] [varchar](500) NOT NULL,
	[Address2] [varchar](500) NULL,
	[Address3] [varchar](500) NULL,
	[Address4] [varchar](500) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [int] NOT NULL,
	[EmailId] [varchar](500) NOT NULL,
	[Telephone] [bigint] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Centre] PRIMARY KEY CLUSTERED 
(
	[CentreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CentreCourse]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreCourse](
	[CentreCourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreCourse] PRIMARY KEY CLUSTERED 
(
	[CentreCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreCourseInstallment]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreCourseInstallment](
	[CentreCourseInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreCourseInstallment] PRIMARY KEY CLUSTERED 
(
	[CentreCourseInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentrePettyCash]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CentrePettyCash](
	[CentrePettyCashId] [int] IDENTITY(1,1) NOT NULL,
	[CentreId] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Particulars] [varchar](500) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentrePettyCash] PRIMARY KEY CLUSTERED 
(
	[CentrePettyCashId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CentreScheme]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreScheme](
	[CentreSchemeId] [int] IDENTITY(1,1) NOT NULL,
	[SchemeId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreScheme] PRIMARY KEY CLUSTERED 
(
	[CentreSchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreSector]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreSector](
	[CentreSectorId] [int] IDENTITY(1,1) NOT NULL,
	[SectorId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreSector] PRIMARY KEY CLUSTERED 
(
	[CentreSectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentreVoucherNumber]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentreVoucherNumber](
	[CentreVoucherNumberId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CentreVoucherNumber] PRIMARY KEY CLUSTERED 
(
	[CentreVoucherNumberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Colour]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Colour](
	[ColourId] [int] NOT NULL,
	[Hex] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CompanyBuilding]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyBuilding](
	[CompanyBuildingId] [int] IDENTITY(1,1) NOT NULL,
	[BuildingId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CompanyBuilding] PRIMARY KEY CLUSTERED 
(
	[CompanyBuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Counselling]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Counselling](
	[CounsellingId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[CourseOfferedId] [int] NOT NULL,
	[PreferTiming] [varchar](500) NULL,
	[Remarks] [varchar](max) NULL,
	[CreatedDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[RemarkByBranchManager] [varchar](max) NULL,
	[SectorId] [int] NULL,
	[PsychomatricTest] [varchar](100) NULL,
	[ConversionProspect] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[RemarkByBm] [varchar](max) NULL,
	[IsRegistrationDone] [bit] NOT NULL,
 CONSTRAINT [PK_Counselling] PRIMARY KEY CLUSTERED 
(
	[CounsellingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Course]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[SectorId] [int] NOT NULL,
	[SchemeId] [int] NULL,
	[CourseTypeId] [int] NULL,
	[Description] [varchar](1000) NULL,
	[Duration] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseInstallment]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseInstallment](
	[CourseInstallmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[CourseId] [int] NOT NULL,
	[Fee] [int] NOT NULL,
	[DownPayment] [int] NOT NULL,
	[LumpsumAmount] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[NumberOfInstallment] [int] NULL,
	[CentreId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_CourseInstallment] PRIMARY KEY CLUSTERED 
(
	[CourseInstallmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseSubject]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSubject](
	[CourseSubjectId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_CourseSubject] PRIMARY KEY CLUSTERED 
(
	[CourseSubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CourseType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseType](
	[CourseTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[CourseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[District]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[District](
	[DistrictId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[StateId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Document]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Document](
	[DocumentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](100) NOT NULL,
	[StudentName] [varchar](500) NULL,
	[FileName] [varchar](4000) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Location] [varchar](max) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DownloadedDateTime] [datetime] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentType](
	[DocumentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[BasePath] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED 
(
	[DocumentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmergencyContact]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmergencyContact](
	[EmergencyContactId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[Relationship] [varchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Forenames] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[CountryId] [int] NULL,
	[Address1] [nvarchar](100) NULL,
	[Address2] [nvarchar](100) NULL,
	[Address3] [nvarchar](100) NULL,
	[Address4] [nvarchar](100) NULL,
	[Postcode] [nvarchar](12) NULL,
	[Telephone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NULL,
 CONSTRAINT [PK_EmergencyContact] PRIMARY KEY CLUSTERED 
(
	[EmergencyContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employment]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employment](
	[EmploymentId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[TerminationDate] [datetime2](7) NULL,
	[BuildingId] [int] NOT NULL,
	[ReportsToPersonnelId] [int] NULL,
	[JobTitle] [nvarchar](100) NULL,
	[JobDescription] [nvarchar](max) NULL,
	[EndEmploymentReasonId] [int] NULL,
	[WorkingPatternId] [int] NULL,
	[PublicHolidayPolicyId] [int] NOT NULL,
	[AbsencePolicyId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
 CONSTRAINT [PK_Employment] PRIMARY KEY CLUSTERED 
(
	[EmploymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmploymentDepartment]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentDepartment](
	[EmploymentDepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EmploymentDepartment] PRIMARY KEY CLUSTERED 
(
	[EmploymentDepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmploymentTeam]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentTeam](
	[EmploymentTeamId] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EmploymentTeam] PRIMARY KEY CLUSTERED 
(
	[EmploymentTeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EnquiryId] [int] IDENTITY(100,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[AlternateMobile] [bigint] NULL,
	[EmailId] [varchar](500) NOT NULL,
	[DateOfBirth] [date] NULL,
	[Age] [int] NOT NULL,
	[Address1] [varchar](500) NOT NULL,
	[Address2] [varchar](500) NULL,
	[Address3] [varchar](500) NULL,
	[Address4] [varchar](500) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [int] NOT NULL,
	[GuardianName] [varchar](500) NULL,
	[GuardianContactNo] [bigint] NULL,
	[OccupationId] [int] NOT NULL,
	[ReligionId] [int] NOT NULL,
	[CasteCategoryId] [int] NOT NULL,
	[Gender] [varchar](100) NOT NULL,
	[EducationalQualificationId] [int] NOT NULL,
	[YearOfPassOut] [varchar](100) NULL,
	[Marks] [varchar](100) NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[HowDidYouKnowAboutId] [int] NOT NULL,
	[PreTrainingStatus] [varchar](100) NULL,
	[EmploymentStatus] [varchar](100) NULL,
	[Promotional] [varchar](100) NULL,
	[EnquiryDate] [date] NULL,
	[StudentCode] [varchar](100) NULL,
	[EnquiryStatus] [varchar](100) NULL,
	[EmployerName] [varchar](500) NULL,
	[EmployerContactNo] [varchar](50) NULL,
	[EmployerAddress] [varchar](max) NULL,
	[AnnualIncome] [int] NULL,
	[SchemeId] [int] NULL,
	[EnquiryTypeId] [int] NOT NULL,
	[StudentTypeId] [int] NOT NULL,
	[SectorId] [int] NOT NULL,
	[BatchTimePreferId] [int] NOT NULL,
	[AppearingQualification] [varchar](500) NULL,
	[YearOfExperience] [int] NULL,
	[PlacementNeeded] [varchar](100) NULL,
	[Remarks] [varchar](max) NULL,
	[FollowUpDate] [datetime] NULL,
	[PreferredMonthForJoining] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[ConversionProspect] [int] NULL,
	[OtherInterestedCourse] [varchar](500) NULL,
	[RemarkByBranchManager] [varchar](max) NULL,
	[IsCounsellingDone] [bit] NOT NULL,
	[IsRegistrationDone] [bit] NOT NULL,
	[IsAdmissionDone] [bit] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnquiryCourse]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryCourse](
	[EnquiryCourseId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryCourse] PRIMARY KEY CLUSTERED 
(
	[EnquiryCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EnquiryType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnquiryType](
	[EnquiryTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryType] PRIMARY KEY CLUSTERED 
(
	[EnquiryTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Event]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[CreatedBy] [varchar](200) NULL,
	[CreatedDateTime] [datetime] NULL,
	[ApprovedBy] [int] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Event1] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Eventday]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Eventday](
	[EventdayId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Eventday] PRIMARY KEY CLUSTERED 
(
	[EventdayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventFunctionType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventFunctionType](
	[EventFunctionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_EventFunctionType] PRIMARY KEY CLUSTERED 
(
	[EventFunctionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Expense]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Expense](
	[ExpenseId] [int] IDENTITY(1,1) NOT NULL,
	[VoucherNumber] [varchar](500) NULL,
	[ExpenseHeaderId] [int] NOT NULL,
	[CashMemoNumbers] [varchar](500) NOT NULL,
	[DebitAmount] [decimal](18, 2) NOT NULL,
	[RupeesInWord] [varchar](500) NOT NULL,
	[PaidTo] [varchar](500) NOT NULL,
	[Particulars] [varchar](max) NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
 CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED 
(
	[ExpenseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExpenseHeader]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExpenseHeader](
	[ExpenseHeaderId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_ExpenseHeader] PRIMARY KEY CLUSTERED 
(
	[ExpenseHeaderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExpenseProject]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpenseProject](
	[ExpenseProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_ExpenseProject] PRIMARY KEY CLUSTERED 
(
	[ExpenseProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FeeType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FeeType](
	[FeeTypeId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FeeType] PRIMARY KEY CLUSTERED 
(
	[FeeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FollowUp]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUp](
	[FollowUpId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpDateTime] [datetime] NULL CONSTRAINT [DF_FollowUp_FollowUpDateTime]  DEFAULT (((1900)-(1))-(1)),
	[MobilizationId] [int] NULL,
	[EnquiryId] [int] NULL,
	[CounsellingId] [int] NULL,
	[RegistrationId] [int] NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Remark] [varchar](max) NULL,
	[Closed] [bit] NULL,
	[ReadDateTime] [datetime] NOT NULL CONSTRAINT [DF_FollowUp_ReadDateTime]  DEFAULT (((1900)-(1))-(1)),
	[CreatedDateTime] [datetime] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Mobile] [bigint] NULL,
	[IntrestedCourseId] [int] NOT NULL,
	[FollowUpType] [varchar](200) NULL,
	[AlternateMobile] [bigint] NULL,
	[FollowUpURL] [varchar](2000) NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
	[AdmissionId] [int] NULL,
 CONSTRAINT [PK_FollowUp] PRIMARY KEY CLUSTERED 
(
	[FollowUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FollowUpHistory]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUpHistory](
	[FollowUpHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpId] [int] NOT NULL,
	[FollowUpType] [varchar](200) NOT NULL,
	[Remarks] [varchar](max) NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemarks] [varchar](max) NULL,
	[FollowUpDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_FollowUpHistory] PRIMARY KEY CLUSTERED 
(
	[FollowUpHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Frequency]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Frequency](
	[FrequencyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Periods] [int] NOT NULL,
 CONSTRAINT [PK_Frequency] PRIMARY KEY CLUSTERED 
(
	[FrequencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Holiday]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Holiday](
	[HolidayId] [int] IDENTITY(1,1) NOT NULL,
	[HolidayDate] [date] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[WeekDay] [varchar](100) NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED 
(
	[HolidayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Host]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Host](
	[HostId] [smallint] IDENTITY(1,1) NOT NULL,
	[HostName] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Host] PRIMARY KEY CLUSTERED 
(
	[HostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HowDidYouKnowAbout]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HowDidYouKnowAbout](
	[HowDidYouKnowAboutId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_HowDidYouKnowAboutUs] PRIMARY KEY CLUSTERED 
(
	[HowDidYouKnowAboutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mobilization]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mobilization](
	[MobilizationId] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[CentreId] [int] NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[AlternateMobile] [bigint] NULL,
	[InterestedCourseId] [int] NOT NULL,
	[QualificationId] [int] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[Remark] [varchar](max) NULL,
	[MobilizerStatus] [varchar](100) NULL,
	[StudentLocation] [varchar](500) NULL,
	[OtherInterestedCourse] [varchar](1000) NULL,
	[GeneratedDate] [date] NOT NULL,
	[MobilizationTypeId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
	[Close] [varchar](5) NULL,
	[ClosingRemark] [varchar](max) NULL,
 CONSTRAINT [PK_Mobilization] PRIMARY KEY CLUSTERED 
(
	[MobilizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MobilizationType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MobilizationType](
	[MobilizationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_MobilizationType] PRIMARY KEY CLUSTERED 
(
	[MobilizationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Occupation]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Occupation](
	[OccupationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Occupation] PRIMARY KEY CLUSTERED 
(
	[OccupationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organisation]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisation](
	[OrganisationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Organisation_1] PRIMARY KEY CLUSTERED 
(
	[OrganisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OtherFee]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OtherFee](
	[OtherFeeId] [int] IDENTITY(1,1) NOT NULL,
	[VoucherId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ProjectId] [int] NULL,
	[ExpenseHeaderId] [int] NOT NULL,
	[CashMemo] [varchar](500) NOT NULL,
	[Unit] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[Description] [varchar](max) NULL,
	[DebitAmount] [decimal](18, 2) NOT NULL,
	[RupeesInWord] [varchar](max) NOT NULL,
	[PaidTo] [varchar](500) NOT NULL,
	[Particulars] [varchar](max) NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[PrintDate] [datetime] NULL,
	[Approved] [bit] NULL,
	[ApprovedBy] [int] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
 CONSTRAINT [PK_OtherFee] PRIMARY KEY CLUSTERED 
(
	[OtherFeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentMode]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentMode](
	[PaymentModeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED 
(
	[PaymentModeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Personnel]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Personnel](
	[PersonnelId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Forenames] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[DOB] [datetime2](7) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Address1] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NULL,
	[Address3] [nvarchar](100) NULL,
	[Address4] [nvarchar](100) NULL,
	[Postcode] [nvarchar](12) NOT NULL,
	[Telephone] [varchar](15) NULL,
	[Mobile] [varchar](15) NULL,
	[NINumber] [varchar](10) NULL,
	[BankAccountNumber] [varchar](10) NULL,
	[BankSortCode] [varchar](6) NULL,
	[BankAccountName] [nvarchar](100) NULL,
	[BankAddress1] [nvarchar](100) NULL,
	[BankAddress2] [nvarchar](100) NULL,
	[BankAddress3] [nvarchar](100) NULL,
	[BankAddress4] [nvarchar](100) NULL,
	[BankPostcode] [nvarchar](12) NULL,
	[BankTelephone] [varchar](15) NULL,
	[Email] [varchar](256) NOT NULL,
	[CurrentEmploymentId] [int] NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED 
(
	[PersonnelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonnelAbsenceEntitlement]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelAbsenceEntitlement](
	[PersonnelAbsenceEntitlementId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NOT NULL,
	[AbsencePolicyPeriodId] [int] NOT NULL,
	[AbsenceTypeId] [int] NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Entitlement] [float] NULL,
	[CarriedOver] [float] NULL,
	[Used] [float] NULL,
	[Remaining] [float] NULL,
	[MaximumCarryForward] [float] NULL,
	[FrequencyId] [int] NOT NULL,
	[EmploymentId] [int] NOT NULL,
 CONSTRAINT [PK_PersonnelAbsenceEntitlement] PRIMARY KEY CLUSTERED 
(
	[PersonnelAbsenceEntitlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Planning]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Planning](
	[PlanningId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Planning] PRIMARY KEY CLUSTERED 
(
	[PlanningId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Postevent]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Postevent](
	[PosteventId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[Completed] [varchar](10) NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Postevent] PRIMARY KEY CLUSTERED 
(
	[PosteventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Project]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[CentreId] [int] NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PublicHoliday]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHoliday](
	[PublicHolidayId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PublicHolidayPolicyId] [int] NOT NULL,
 CONSTRAINT [PK_PublicHoliday] PRIMARY KEY CLUSTERED 
(
	[PublicHolidayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PublicHolidayPolicy]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHolidayPolicy](
	[PublicHolidayPolicyId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_PublicHolidayPolicy] PRIMARY KEY CLUSTERED 
(
	[PublicHolidayPolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Qualification]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Qualification](
	[QualificationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Qualification] PRIMARY KEY CLUSTERED 
(
	[QualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[EventFunctionTypeId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registration](
	[RegistrationId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [varchar](50) NULL,
	[EnquiryId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[CourseInstallmentId] [int] NOT NULL,
	[CandidateFeeId] [int] NOT NULL,
	[CandidateInstallmentId] [int] NOT NULL,
	[Remarks] [varchar](max) NULL,
	[FollowupDate] [datetime] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[IsAdmissionDone] [bit] NOT NULL,
	[RegistrationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[RegistrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegistrationPaymentReceipt]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegistrationPaymentReceipt](
	[RegistrationPaymentReceiptId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CounsellingId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Fees] [int] NOT NULL,
	[ChequeNo] [varchar](100) NOT NULL,
	[ChequeDate] [date] NOT NULL,
	[BankName] [varchar](500) NOT NULL,
	[Particulars] [varchar](500) NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[RegistrationDate] [date] NOT NULL,
	[FollowUpDate] [date] NULL,
	[Remarks] [varchar](max) NULL,
	[FinancialYear] [varchar](100) NOT NULL,
 CONSTRAINT [PK_RegistrationPaymentReceipt] PRIMARY KEY CLUSTERED 
(
	[RegistrationPaymentReceiptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Religion]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Religion](
	[ReligionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Religion] PRIMARY KEY CLUSTERED 
(
	[ReligionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Room]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Number] [int] NOT NULL,
	[Floor] [int] NOT NULL,
	[OccupiedStartDate] [date] NULL,
	[OccupiedEndDate] [date] NULL,
	[OccupiedStartTime] [varchar](50) NULL,
	[OccupiedEndTime] [varchar](50) NULL,
	[RoomTypeId] [int] NOT NULL,
	[Capacity] [int] NOT NULL,
	[SquareFeet] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomAvailable]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoomAvailable](
	[RoomAvailableId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[Day] [varchar](10) NOT NULL,
	[StartTimeHours] [int] NOT NULL,
	[StartTimeMinutes] [int] NOT NULL,
	[StartTimeSpan] [varchar](10) NOT NULL,
	[EndTimeHours] [int] NOT NULL,
	[EndTimeMinutes] [int] NOT NULL,
	[EndTimeSpan] [varchar](10) NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoomType](
	[RoomTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED 
(
	[RoomTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Scheme]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Scheme](
	[SchemeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Scheme] PRIMARY KEY CLUSTERED 
(
	[SchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sector](
	[SectorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[SchemeId] [int] NOT NULL,
 CONSTRAINT [PK_Sector] PRIMARY KEY CLUSTERED 
(
	[SectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Session]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Session](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Duration] [varchar](500) NOT NULL,
	[CourseTypeId] [int] NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Site](
	[SiteId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CountryId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Site] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[State]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentType]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentType](
	[StudentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_StudentType] PRIMARY KEY CLUSTERED 
(
	[StudentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[CourseId] [int] NULL,
	[TrainerId] [int] NULL,
	[CourseTypeId] [int] NOT NULL,
	[TotalMarks] [int] NOT NULL,
	[PassingMarks] [int] NOT NULL,
	[NoOfAttemptsAllowed] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubjectCourse]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectCourse](
	[SubjectCourseId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SubjectCourse] PRIMARY KEY CLUSTERED 
(
	[SubjectCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubjectTrainer]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectTrainer](
	[SubjectTrainerId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[TrainerId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SubjectTrainer] PRIMARY KEY CLUSTERED 
(
	[SubjectTrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Taluka]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Taluka](
	[TalukaId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[DistrictId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Taluka] PRIMARY KEY CLUSTERED 
(
	[TalukaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Team]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[ColourId] [int] NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FileName] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Template] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trainer]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trainer](
	[TrainerId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Address1] [varchar](100) NOT NULL,
	[Address2] [varchar](100) NULL,
	[Address3] [varchar](100) NULL,
	[Address4] [varchar](100) NULL,
	[TalukaId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[DistrictId] [int] NOT NULL,
	[PinCode] [nvarchar](12) NOT NULL,
	[Gender] [varchar](100) NULL,
	[AadharNo] [bigint] NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EmailId] [varchar](500) NOT NULL,
	[Certified] [varchar](100) NULL,
	[CertificationNo] [varchar](500) NULL,
	[SectorId] [int] NOT NULL,
	[CourseId] [int] NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[PersonnelId] [int] NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Trainer] PRIMARY KEY CLUSTERED 
(
	[TrainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainerAvailable]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainerAvailable](
	[TrainerAvailableId] [int] IDENTITY(1,1) NOT NULL,
	[TrainerId] [int] NOT NULL,
	[BatchId] [int] NOT NULL,
	[Day] [varchar](10) NOT NULL,
	[StartTimeHours] [int] NOT NULL,
	[StartTimeMinutes] [int] NOT NULL,
	[StartTimeSpan] [varchar](10) NOT NULL,
	[EndTimeHours] [int] NOT NULL,
	[EndTimeMinutes] [int] NOT NULL,
	[EndTimeSpan] [varchar](10) NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_TrainerAvailable] PRIMARY KEY CLUSTERED 
(
	[TrainerAvailableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainerDocument]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainerDocument](
	[TrainerDocumentId] [int] IDENTITY(1,1) NOT NULL,
	[TrainerId] [int] NOT NULL,
	[TrainerName] [varchar](500) NULL,
	[FileName] [varchar](4000) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Location] [varchar](max) NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DownloadedDateTime] [datetime] NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NULL,
 CONSTRAINT [PK_TrainerDocument] PRIMARY KEY CLUSTERED 
(
	[TrainerDocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Voucher](
	[VoucherId] [int] IDENTITY(1,1) NOT NULL,
	[VoucherNumber] [varchar](100) NULL,
	[CashMemo] [varchar](500) NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Voucher] PRIMARY KEY CLUSTERED 
(
	[VoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WorkingPattern]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPattern](
	[WorkingPatternId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_WorkingPattern] PRIMARY KEY CLUSTERED 
(
	[WorkingPatternId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkingPatternDay]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingPatternDay](
	[WorkingPatternDayId] [int] IDENTITY(1,1) NOT NULL,
	[WorkingPatternId] [int] NOT NULL,
	[DayOfWeek] [smallint] NOT NULL,
	[AM] [bit] NOT NULL,
	[PM] [bit] NOT NULL,
 CONSTRAINT [PK_WorkingPatternDay] PRIMARY KEY CLUSTERED 
(
	[WorkingPatternDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[AdmissionGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[AdmissionGrid]
AS 
Select
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=Case when CI.PaymentMethod='MonthlyInstallment' then CI.CourseFee else CI.LumpsumAmount end,
PaidAmount=sum(CF.PaidAmount),
PendingAmount = Case when CI.PaymentMethod='MonthlyInstallment' then CI.CourseFee - sum(PaidAmount) else CI.LumpsumAmount - sum(PaidAmount) end,
A.AdmissionDate,
A.AdmissionId,
CentreName=C.Name,
C.CentreId
from Admission A
INNER JOIN REGISTRATION R ON R.RegistrationId =  A.RegistrationId
INNER JOIN ENQUIRY E ON E.EnquiryId = R.EnquiryId
left JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN CandidateInstallment CI on CI.StudentCode = E.StudentCode
INNER JOIN CandidateFee CF on CF.CandidateInstallmentId = CI.CandidateInstallmentId
INNER JOIN Centre C on C.CentreId = A.CentreId
group by
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
C.CentreId,
C.Name,
A.AdmissionId,
CI.PaymentMethod,
CI.LumpsumAmount




GO
/****** Object:  View [dbo].[AdmissionSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[AdmissionSearchField]
AS 
SELECT 

	 CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=CI.CourseFee,
PaidAmount=sum(CF.PaidAmount),
PendingAmount = CI.CourseFee - sum(CF.PaidAmount),
A.AdmissionDate,
A.AdmissionId,
CentreName=C.Name,
C.CentreId,

 ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  +ISNULL(C.Name, '')+ISNULL(B.Name, '')
	  + ISNULL(CONVERT(varchar,AdmissionDate, 101), '') 
	  + ISNULL(CONVERT(varchar,AdmissionDate, 103), '') 
	  + ISNULL(CONVERT(varchar,AdmissionDate, 105), '') 
	  + ISNULL(CONVERT(varchar,AdmissionDate, 126), '') AS SearchField

from Admission A
INNER JOIN REGISTRATION R ON R.RegistrationId =  A.RegistrationId
INNER JOIN ENQUIRY E ON E.EnquiryId = R.EnquiryId
INNER JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN CandidateInstallment CI on CI.StudentCode = E.StudentCode
INNER JOIN CandidateFee CF on CF.CandidateInstallmentId = CI.CandidateInstallmentId
INNER JOIN Centre C on C.CentreId = A.CentreId
group by
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
C.CentreId,
C.Name,
A.AdmissionId

  

GO
/****** Object:  View [dbo].[AttendanceGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[AttendanceGrid]
AS 
Select
StudentCode=E.StudentCode,
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
B.BatchId,
InTime = Convert(varchar ,AT.InHour)+' : '+Convert(varchar ,AT.InMinute)+' '+AT.InTimeSpan,
OutTime = Convert(varchar ,AT.OutHour)+' : '+Convert(varchar ,AT.OutMinute)+' '+AT.OutTimeSpan,
CentreName=C.Name,
C.CentreId,
Topic=BA.Topic


from Admission A 
INNER JOIN Batch B on A.BatchId=b.BatchId
INNER JOIN Registration R on R.RegistrationId=A.RegistrationId
INNER JOIN Enquiry E on E.StudentCode=R.StudentCode
left JOIN Attendance AT on AT.StudentCode=E.StudentCode
left JOIN BatchAttendance BA on BA.AttendanceId=AT.AttendanceId
INNER JOIN Centre C on C.CentreId = A.CentreId


group by
E.StudentCode,
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.BatchId,
AT.InHour,
AT.InMinute,
AT.InTimeSpan,
AT.OutHour,
AT.OutMinute,
AT.OutTimeSpan,
C.CentreId,
C.Name,
BA.Topic



GO
/****** Object:  View [dbo].[CandidateFeeGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[CandidateFeeGrid]
AS 
Select
CandidateFeeId,
PaymentDate,
candidatefee. CandidateInstallmentId,
PaidAmount,
PaymentMode = PM.Name,
FeeType = case  When InstallmentNumber is null then FT.Name else CONVERT(varchar(100), FT.Name +'-'+ convert(varchar(100), ISNULL(InstallmentNumber,''))) end,
ChequeNumber,
ChequeDate,
BankName,
Penalty,
InstallmentDate,
StudentCode,
InstallmentNumber,
InstallmentAmount,
BalanceInstallmentAmount,
Particulars,
FiscalYear,
FollowUpDate,
CentreId,
Organisation=O.Name,
IsPaymentDone,
PersonnelId,
IsPaidAmountOverride,
AdvancedAmount,
CF.NextInstallmentDate
from [dbo].[CandidateFee] candidatefee



Left join (
select  NextInstallmentDate = min(installmentdate),CandidateInstallmentId  
from [dbo].[CandidateFee]
where IsPaymentDone = 0 group by CandidateInstallmentId 
) CF on candidatefee.CandidateInstallmentId = CF.CandidateInstallmentId 
inner join FeeType FT on FT.FeeTypeId=candidatefee.FeeTypeId
join PaymentMode PM on PM.PaymentModeId=candidatefee.PaymentModeId
join Organisation O on O.OrganisationId=candidatefee.OrganisationId



GO
/****** Object:  View [dbo].[CandidateFeeSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[CandidateFeeSearchField]
AS 


	  Select
C.CandidateInstallmentId,
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=CI.CourseFee,
PaidAmount=sum(PaidAmount),
PendingAmount = CI.CourseFee - sum(PaidAmount),
A.AdmissionDate,
A.AdmissionId,
CentreName=CE.Name,
CE.CentreId,

 ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  AS SearchField

from CandidateFee C
INNER JOIN CandidateInstallment CI ON CI.CandidateInstallmentId =  C.CandidateInstallmentId
INNER JOIN Enquiry E ON E.StudentCode = CI.StudentCode
INNER JOIN Registration R ON R.StudentCode = CI.StudentCode
INNER JOIN Admission A ON A.RegistrationId = R.RegistrationId
INNER JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN Centre CE on CE.CentreId = A.CentreId
group by
C.CandidateInstallmentId,
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
CE.CentreId,
CE.Name,
A.AdmissionId

     


GO
/****** Object:  View [dbo].[CandidateInstallmentGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[CandidateInstallmentGrid]
AS 
Select
C.CandidateInstallmentId,
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=Case when CI.PaymentMethod='MonthlyInstallment' then CI.CourseFee else CI.LumpsumAmount end,
PaidAmount=sum(PaidAmount),
PendingAmount = Case when CI.PaymentMethod='MonthlyInstallment' then CI.CourseFee - sum(PaidAmount) else CI.LumpsumAmount - sum(PaidAmount) end,
A.AdmissionDate,
A.AdmissionId,
CentreName=CE.Name,
CE.CentreId

from CandidateFee C
INNER JOIN CandidateInstallment CI ON CI.CandidateInstallmentId =  C.CandidateInstallmentId
INNER JOIN Enquiry E ON E.StudentCode = CI.StudentCode
INNER JOIN Registration R ON R.StudentCode = CI.StudentCode
INNER JOIN Admission A ON A.RegistrationId = R.RegistrationId
left JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN Centre CE on CE.CentreId = A.CentreId
group by
C.CandidateInstallmentId,
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
CE.CentreId,
CE.Name,
A.AdmissionId,
CI.PaymentMethod,
CI.LumpsumAmount


GO
/****** Object:  View [dbo].[CandidateInstallmentSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[CandidateInstallmentSearchField]
AS 
Select
C.CandidateInstallmentId,
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
BatchName=B.Name,
TotalFee=CI.CourseFee,
PaidAmount=sum(PaidAmount),
PendingAmount = CI.CourseFee - sum(PaidAmount),
A.AdmissionDate,
A.AdmissionId,
CentreName=CE.Name,
CE.CentreId,

 ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  AS SearchField

from CandidateFee C
INNER JOIN CandidateInstallment CI ON CI.CandidateInstallmentId =  C.CandidateInstallmentId
INNER JOIN Enquiry E ON E.StudentCode = CI.StudentCode
INNER JOIN Registration R ON R.StudentCode = CI.StudentCode
INNER JOIN Admission A ON A.RegistrationId = R.RegistrationId
INNER JOIN BATCH B ON B.BatchId = A.BatchId
INNER JOIN Centre CE on CE.CentreId = A.CentreId
group by
C.CandidateInstallmentId,
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
B.Name,
CI.CourseFee,
A.AdmissionDate,
CE.CentreId,
CE.Name,
A.AdmissionId

     



GO
/****** Object:  View [dbo].[CounsellingSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[CounsellingSearchField]
AS 
SELECT 

       C.CounsellingId,
      C.EnquiryId,
      C.Title,
      C.FirstName,
      C.MiddleName,
      C.LastName,
      C.CentreId,
      C.OrganisationId,
      C.PersonnelId,
      C.CourseOfferedId,
      C.PreferTiming,
      C.Remarks,
      C.FollowUpDate,
      C.RemarkByBranchManager,
      C.SectorId,
      C.PsychomatricTest,
      C.ConversionProspect,
      C.[Close],
      C.ClosingRemark,
      C.RemarkByBm,
      C.IsRegistrationDone,

	  ISNULL(C.Title, '')+ISNULL(C.FirstName, '')+ISNULL(C.MiddleName, '')+ISNULL(C.LastName, '')
	  +ISNULL(CO.Name, '')
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 101), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 103), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 105), '') 
	  + ISNULL(CONVERT(varchar,C.FollowUpDate, 126), '') as SearchField
		

	  from Counselling C WITH (NOLOCK) left join Course CO WITH (NOLOCK)
	on C.CourseOfferedId = CO.CourseId
	where C.IsRegistrationDone=0



GO
/****** Object:  View [dbo].[CourseInstallmentSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[CourseInstallmentSearchField]
AS 
SELECT 

		C.CourseInstallmentId,
      C.Name,
      C.CourseId,
      C.Fee,
      C.DownPayment,
      C.LumpsumAmount,
      C.OrganisationId,
      C.NumberOfInstallment,
      C.CentreId,
      C.CreatedDate,

	  ISNULL(C.Name, '')+ISNULL(CO.Name, '')+CONVERT(varchar, C.Fee )+ISNULL(CE.Name, '')AS SearchField



	  FROM 
	CourseInstallment C  WITH (NOLOCK) left join Course CO WITH (NOLOCK)
	on C.CourseId = CO.CourseId join Centre CE WITH(NOLOCk)
	on C.CentreId=CE.CentreId


GO
/****** Object:  View [dbo].[CourseSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[CourseSearchField]
AS 
SELECT 

		C.CourseId,
		C.Name,
		C.OrganisationId,
		C.SectorId,
		C.SchemeId,
		C.CourseTypeId,
		C.Description,
		C.Duration,

ISNULL(C.Name, '')+ISNULL(S.Name, '')+ISNULL(SC.Name, '') AS SearchField
FROM 
	Course C  WITH (NOLOCK) left join Sector S WITH (NOLOCK)
	on C.SectorId = S.SectorId join Scheme SC WITH (NOLOCK)
	on C.SchemeId=SC.SchemeId











GO
/****** Object:  View [dbo].[EnquiryDataGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[EnquiryDataGrid]
AS 

SELECT 
	E.CentreId,
	  CE.Name as [Centre Name],
      E.EnquiryId,
      CandidateName= E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.LastName,
      E.Mobile,
      E.EmailId,
	  E.DateOfBirth,
      E.Age,
      E.Address1,
	  E.Address2,
	  E.Address3,
	  E.Address4,
	  T.Name as [Taluka],
	  SE.Name as [State],
	  D.Name as [District],
	  E.PinCode,
      E.GuardianName,
      E.GuardianContactNo,
      O.Name as [Occupation],
      R.Name as [Religion],
      CC.Caste as [Caste Category],
      E.Gender,
      Q.Name as [Qualification],
      E.YearOfPassOut,
      E.Marks,
	  SC.Name as [Scheme],
	  S.Name as [Sector],
      H.Name as [How Did You Know About Us],
      E.PreTrainingStatus,
      E.EmploymentStatus,
      E.Promotional,
      E.EnquiryDate,
	  E.StudentCode,
	  E.EnquiryStatus,
      ET.Name as [Enquiry Type],
      ST.Name as [Student Type],
      BTP.Name as [Batch Time Prefer],
      E.AppearingQualification,
      E.PlacementNeeded,
	  E.ConversionProspect,
      E.Remarks,
      E.FollowUpDate,
      E.PreferredMonthForJoining,
	  E.OtherInterestedCourse,
	  E.[Close],
	  E.ClosingRemark,
	  IsCounsellingDone = case  When E.IsCounsellingDone = '0' then 'NO' else 'Yes' end,
      IsRegistrationDone = case  When E.IsRegistrationDone = '0' then 'NO' else 'Yes' end,
	  IsAdmissionDone = case  When E.IsAdmissionDone = '0' then 'NO' else 'Yes' end
		
FROM 
	Enquiry E WITH (NOLOCK) left join Religion R WITH (NOLOCK)
	on E.ReligionId=R.ReligionId join CasteCategory CC WITH (NOLOCK)
	ON E.CasteCategoryId=CC.CasteCategoryId join Qualification Q WITH (NOLOCK) 
	on E.EducationalQualificationId=Q.QualificationId join Taluka T WIth (NOLOCK)
	on E.TalukaId=T.TalukaId join District D WITH(NOLOCK)
	on E.DistrictId=D.DistrictId join State SE WITH(NOLOCK)
	on E.StateId=SE.StateId join Scheme SC WITH (NOLOCK)
	on E.SchemeId=SC.SchemeId join EnquiryType ET WITh(NOLOCK)
	on E.EnquiryTypeId=ET.EnquiryTypeId join Sector S WITH(NOLOCK)
	on E.SectorId=S.SectorId join HowDidYouKnowAbout H WITH(NOLOCk)
	on E.HowDidYouKnowAboutId=H.HowDidYouKnowAboutId join Occupation O WITH(NOLOCk)
	on E.OccupationId=O.OccupationId join Centre CE WITH(NOLOCk)
	on E.CentreId=CE.CentreId join StudentType ST WITH(NOLOCk)
	on E.StudentTypeId=ST.StudentTypeId join BatchTimePrefer BTP WITH(NOLOCk)
	On E.BatchTimePreferId=BTP.BatchTimePreferId




GO
/****** Object:  View [dbo].[EnquirySearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [dbo].[EnquirySearchField]
AS 
SELECT 

		E.EnquiryId,
      E.Title,
      E.FirstName,
      E.MiddleName,
      E.LastName,
      E.Mobile,
      E.AlternateMobile,
      E.EmailId,
      E.DateOfBirth,
      E.Age,
      E.Address1,
      E.Address2,
      E.Address3,
      E.Address4,
      E.TalukaId,
      E.StateId,
      E.DistrictId,
      E.PinCode,
      E.GuardianName,
      E.GuardianContactNo,
      E.OccupationId,
      E.ReligionId,
      E.CasteCategoryId,
      E.Gender,
      E.EducationalQualificationId,
      E.YearOfPassOut,
      E.Marks,
      E.IntrestedCourseId,
      E.HowDidYouKnowAboutId,
      E.PreTrainingStatus,
      E.EmploymentStatus,
      E.Promotional,
      E.EnquiryDate,
      E.StudentCode,
      E.EnquiryStatus,
      E.EmployerName,
      E.EmployerContactNo,
      E.EmployerAddress,
      E.AnnualIncome,
      E.SchemeId,
      E.EnquiryTypeId,
      E.StudentTypeId,
      E.SectorId,
      E.BatchTimePreferId,
      E.AppearingQualification,
      E.YearOfExperience,
      E.PlacementNeeded,
      E.Remarks,
      E.FollowUpDate,
      E.PreferredMonthForJoining,
      E.[Close],
      E.ClosingRemark,
      E.ConversionProspect,
      E.OtherInterestedCourse,
      E.RemarkByBranchManager,
      E.IsCounsellingDone,
      E.IsRegistrationDone,
      E.IsAdmissionDone,
      E.CentreId,
      E.OrganisationId,

	  ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
		+CONVERT(varchar, E.Mobile )+ISNULL(T.Name, '')+ISNULL(S.Name, '')+ISNULL(D.Name, '')
		+ISNULL(R.Name, '')+ISNULL(CC.Caste, '')+ISNULL(E.Gender, '')+ISNULL(Q.Name, '')
		+ISNULL(H.Name, '')+ISNULL(SC.Name, '')+ISNULL(SE.Name, '')+ISNULL(CE.Name, '') AS SearchField

	  from Enquiry E left join Taluka T WITH (NOLOCK)
	on E.TalukaId = T.TalukaId join State S WITH (NOLOCK)
	on E.StateId=S.StateId join District D WITH (NOLOCK)
	on E.DistrictId=D.DistrictId join Religion R WITH (NOLOCK)
	on E.ReligionId=R.ReligionId join CasteCategory CC WITH(NOLOCK)
	on E.CasteCategoryId=CC.CasteCategoryId join HowDidYouKnowAbout H WITH(NOLOCK)
	on E.HowDidYouKnowAboutId=H.HowDidYouKnowAboutId join Scheme SC WITH(NOLOCK)
	on E.SchemeId=SC.SchemeId join Sector SE WITH(NOLOCK)
	on E.SectorId=SE.SectorId join Qualification Q WITH(NOLOCK)
	on E.EducationalQualificationId=Q.QualificationId join Centre CE WITH(NOLOCK)
	on E.CentreId=CE.CentreId
	where E.[Close]='No' and E.IsRegistrationDone=0 and E.IsAdmissionDone=0





GO
/****** Object:  View [dbo].[FollowUpDataGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[FollowUpDataGrid]
AS 
select
	  F.CentreId,
	  CentreName=C.Name,
      F.FollowUpHistoryId,
      F.FollowUpId,
	  CandidateName=FU.Title+' '+FU.FirstName+' '+FU.MiddleName+' '+Fu.LastName,
      F.FollowUpType,
      COALESCE(F.Remarks,'')[Remarks],
      F.[Close],
      COALESCE(F.ClosingRemarks,'')[ClosingRemarks],
      F.FollowUpDate,
      F.CreatedDate, 
      F.OrganisationId

	  from FollowUpHistory F 
	  With(NOLOCK) left join FollowUp FU with (NOLOCK)
	  on F.FollowUpId = FU.FollowUpId join Centre C with(NOLOCK)
	  on F.CentreId=C.CentreId

	  



GO
/****** Object:  View [dbo].[FollowUpSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[FollowUpSearchField]
AS 
SELECT 

		F.FollowUpId,
      F.FollowUpDateTime,
      F.MobilizationId,
      F.EnquiryId,
      F.CounsellingId,
      F.RegistrationId,
      F.Title,
      F.FirstName,
      F.MiddleName,
      F.LastName,
      F.Remark,
      F.Closed,
      F.ReadDateTime,
      F.CreatedDateTime,
      F.OrganisationId,
      F.CentreId,
      F.Mobile,
      F.IntrestedCourseId,
      F.FollowUpType,
      F.AlternateMobile,
      F.FollowUpURL,
      F.[Close],
      F.ClosingRemark,

	  ISNULL(F.Title, '')+ISNULL(F.FirstName, '')+ISNULL(F.MiddleName, '')+ISNULL(F.LastName, '')
		+CONVERT(varchar, F.Mobile )+ISNULL(C.Name, '')+ISNULL(F.FollowUpType, '') AS SearchField

	  from 
	  FollowUp F WITH (NOLOCK) left join Course C WITH (NOLOCK)
	  on F.IntrestedCourseId = C.CourseId 
	  where F.[Close]='No'



GO
/****** Object:  View [dbo].[MobilizationDataGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[MobilizationDataGrid]
AS 
SELECT 
		M.CentreId,
		CentreName = CE.Name,
		M.MobilizationId,
		EventName=E.Name,
		CandidateName = M.Title+' '+M.FirstName+' '+M.MiddleName+' '+M.LastName,
		M.Mobile,
		InterestedCourse=C.Name,
		Qualification=Q.Name,
		M.CreatedDate,
		M.FollowUpDate,
		M.Remark,
		M.StudentLocation,
		M.OtherInterestedCourse,
		M.[Close],
		M.ClosingRemark

FROM 
	Mobilization M  WITH (NOLOCK) left join Event E WITH (NOLOCK)
	on M.Eventid = E.EventId join Course C WITH (NOLOCK)
	ON C.CourseId = m.InterestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = M.QualificationId join Personnel P WITH (NOLOCK)
	on m.PersonnelId=p.PersonnelId join Centre CE WITH (NOLOCK)
	on m.CentreId=CE.CentreId



GO
/****** Object:  View [dbo].[MobilizationSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[MobilizationSearchField]
AS 
SELECT 
		M.MobilizationId,
		M.EventId,
		M.OrganisationId,
		M.CentreId,
		M.Title,
		M.FirstName,
		M.MiddleName,
		M.LastName,
		M.Mobile,
		M.AlternateMobile,
		M.InterestedCourseId,
		M.QualificationId,
		M.CreatedDate,
		M.FollowUpDate,
		M.Remark,
		M.MobilizerStatus,
		p.Forenames[Mobilized By],
		M.StudentLocation,
		M.OtherInterestedCourse,
		M.MobilizationTypeId,
		M.GeneratedDate,
		M.PersonnelId,
        M.[Close],
        M.ClosingRemark,
		ISNULL(M.Title, '')+ISNULL(M.FirstName, '')+ISNULL(M.MiddleName, '')+ISNULL(M.LastName, '')+ISNULL(E.Name, '')+ISNULL(C.Name, '')+ISNULL(p.Forenames, '')+ISNULL(M.StudentLocation, '')+ISNULL(Mo.Name, '') + ISNULL(CONVERT(varchar,M.GeneratedDate, 101), '') + ISNULL(CONVERT(varchar,GeneratedDate, 103), '') + ISNULL(CONVERT(varchar,GeneratedDate, 105), '') + ISNULL(CONVERT(varchar,GeneratedDate, 126), '') + ISNULL(StudentLocation, '') + ISNULL(Q.Name, '') + CONVERT(varchar, m.Mobile ) AS SearchField
FROM 
	Mobilization M  WITH (NOLOCK) left join Event E WITH (NOLOCK)
	on M.Eventid = E.EventId join Course C WITH (NOLOCK)
	ON C.CourseId = m.InterestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = M.QualificationId join Personnel P WITH (NOLOCK)
	on m.PersonnelId=p.PersonnelId join MobilizationType Mo WITH (NOLOCK)
	on M.MobilizationTypeId=Mo.MobilizationTypeId
	where M.[Close]='No'









GO
/****** Object:  View [dbo].[PersonnelSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[PersonnelSearchField]
AS 
SELECT 
		PersonnelId,
		OrganisationId,
		Title,
		Forenames,
		Surname,
		DOB,
		CountryId,
		Address1,
		Address2,
		Address3,
		Address4,
		Postcode,
		Telephone,
		Mobile,
		NINumber,
		BankAccountNumber,
		BankSortCode,
		BankAccountName,
		BankAddress1,
		BankAddress2,
		BankAddress3,
		BankAddress4,
		BankPostcode,
		BankTelephone,
		Email,
		CurrentEmploymentId,
      CentreId,
	
		ISNULL(Surname, '') + ISNULL(Forenames, '') + ISNULL(Surname, '') + ISNULL(CONVERT(varchar,DOB, 101), '') + ISNULL(CONVERT(varchar,DOB, 103), '') + ISNULL(CONVERT(varchar,DOB, 105), '') + ISNULL(CONVERT(varchar,DOB, 126), '') + ISNULL(EMail, '') + ISNULL(Postcode, '') + ISNULL(Mobile, '') AS SearchField
FROM 
	Personnel  WITH (NOLOCK)















GO
/****** Object:  View [dbo].[RegistrationGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





Create VIEW [dbo].[RegistrationGrid]
AS 
Select
CandidateName = E.Title+' '+E.FirstName+' '+E.MiddleName+' '+E.Lastname,
R.RegistrationDate,
TotalFee=Case when CI.PaymentMethod='MonthlyInstallment' then CI.CourseFee else CI.LumpsumAmount end,
RegistrationAmount=CF.PaidAmount,
R.RegistrationId,
CentreName=C.Name,
PaymentMode=P.Name,
C.CentreId
from REGISTRATION R
INNER JOIN ENQUIRY E ON E.EnquiryId = R.EnquiryId
INNER JOIN CandidateInstallment CI on CI.StudentCode = E.StudentCode
INNER JOIN CandidateFee CF on CF.CandidateFeeId = R.CandidateFeeId
INNER JOIN PaymentMode P ON P.PaymentModeId=CF.PaymentModeId
INNER JOIN Centre C on C.CentreId = R.CentreId
group by
E.Title,
E.MiddleName,
E.FirstName,
E.Lastname,
CI.CourseFee,
C.CentreId,
C.Name,
CI.PaymentMethod,
CI.LumpsumAmount,
R.RegistrationDate,
CF.PaidAmount,
R.RegistrationId,
P.Name


GO
/****** Object:  View [dbo].[RegistrationSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[RegistrationSearchField]
AS 
SELECT

       R.RegistrationId,
      R.StudentCode,
      R.EnquiryId,
      R.CourseId,
      R.CourseInstallmentId,
      R.CandidateFeeId,
      R.CandidateInstallmentId,
      R.Remarks,
      R.FollowupDate,
      R.CentreId,
      R.OrganisationId,
      R.IsAdmissionDone,
      R.RegistrationDate,

	  ISNULL(E.Title, '')+ISNULL(E.FirstName, '')+ISNULL(E.MiddleName, '')+ISNULL(E.LastName, '')
	  +ISNULL(C.Name,'')+ ISNULL(CONVERT(varchar,R.RegistrationDate, 101), '') 
	  + ISNULL(CONVERT(varchar,R.RegistrationDate, 103), '') 
	  + ISNULL(CONVERT(varchar,R.RegistrationDate, 105), '') 
	  + ISNULL(CONVERT(varchar,R.RegistrationDate, 126), '')  AS SearchField

	  FROM 
	Registration R  WITH (NOLOCK) left join Course C WITH (NOLOCK)
	on R.CourseId = C.CourseId join Enquiry E WITH(NOLOCK)
	on R.EnquiryId=E.EnquiryId
	where R.IsAdmissionDone=0



GO
/****** Object:  View [dbo].[TrainerSearchField]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[TrainerSearchField]
AS 
SELECT 
		T.TrainerId,
		T.Title,
		T.FirstName,
		T.MiddleName,
		T.LastName,
		T.DateOfBirth,
		T.Address1,
		T.Address2,
		T.Address3,
		T.Address4,
		T.PinCode,
		T.TalukaId,
		T.DistrictId,
		T.StateId,
		T.Gender,
		T.AadharNo,
		T.Mobile,
		T.EmailId,
		T.Certified,
		T.CertificationNo,
		T.SectorId,
		T.CourseId,
		T.CentreId,
		T.OrganisationId,
		T.PersonnelId,
		T.CreatedDate,
		
		ISNULL(T.Title, '')+ISNULL(T.FirstName, '')+ISNULL(T.MiddleName, '')+ISNULL(T.LastName, '')
		+CONVERT(varchar, T.Mobile )+ISNULL(S.Name, '')
		+ ISNULL(CONVERT(varchar,T.DateOfBirth, 101), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 103), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 105), '') 
	  + ISNULL(CONVERT(varchar,DateOfBirth, 126), '')
	  +ISNULL(TL.Name, '')+ISNULL(ST.Name, '')+ISNULL(D.Name, '') AS SearchField
FROM 
	Trainer T  WITH (NOLOCK) left join Sector S WITH (NOLOCK)
	on T.SectorId = S.SectorId join Taluka TL WITH(NOLOCk)
	on T.TalukaId=TL.TalukaId join District D WITH(NOLOCk)
	on T.DistrictId=D.DistrictId join State ST WITH(NOLOCk)
	on T.StateId=ST.StateId













GO
/****** Object:  View [dbo].[UserAuthorisationFilter]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserAuthorisationFilter]
AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY p.PersonnelId, ur.RoleId) AS Id,
	p.PersonnelId,
	u.Id AS AspNetUsersId, 
	u.OrganisationId,
	ur.RoleId,
	r.Name AS RoleName
FROM
	AspNetUsers u
INNER JOIN
	AspNetUserRoles ur
		ON u.Id = ur.UserId
INNER JOIN
	AspNetRoles r 
		on ur.RoleId = r.Id
LEFT JOIN
	Personnel p 
		ON u.PersonnelId = p.PersonnelId













GO
/****** Object:  View [dbo].[VoucherGrid]    Script Date: 28/06/2017 05:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VoucherGrid]
AS 
SELECT 
CentreId=V.CentreId,
CentreName=C.Name,
V.CreatedDate,
VoucherNumber=V.VoucherNumber,
CashMemo=V.CashMemo,
TotalDebitAmount=sum(O.DebitAmount),
PaidTo=O.PaidTo
From Voucher V inner join OtherFee O
on V.CashMemo=O.CashMemo inner join Centre C
on V.CentreId=C.CentreId
group by
V.CreatedDate,
VoucherNumber,
V.CashMemo,
O.PaidTo,
C.Name,
V.CentreId


GO
SET IDENTITY_INSERT [dbo].[Absence] ON 

INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (65, 4, 1, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-04 14:49:09.9854584' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (69, 4, 47, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:29:42.0016821' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (71, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:39:14.5242644' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (72, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:41:31.5815424' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (73, 4, 43, 3, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 10:48:45.7573640' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Absence] ([AbsenceId], [OrganisationId], [PersonnelAbsenceEntitlementId], [AbsenceTypeId], [AbsenceStatusId], [AbsenceStatusByUser], [AbsenceStatusDateTimeUtc], [Description], [ReturnToWorkCompleted], [DoctorsNoteSupplied]) VALUES (75, 4, 45, 2, 1, N'baa66088-ea1b-43ab-b8b0-ee75523e613a', CAST(N'2017-01-06 12:00:05.8472758' AS DateTime2), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Absence] OFF
SET IDENTITY_INSERT [dbo].[AbsenceDay] ON 

INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (85, 4, 65, CAST(N'2017-01-04' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (89, 4, 69, CAST(N'2017-04-11' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (91, 4, 71, CAST(N'2017-01-16' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (92, 4, 72, CAST(N'2017-01-09' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (93, 4, 73, CAST(N'2017-01-10' AS Date), 1, 1, 1)
INSERT [dbo].[AbsenceDay] ([AbsenceDayId], [OrganisationId], [AbsenceId], [Date], [AM], [PM], [Duration]) VALUES (95, 4, 75, CAST(N'2017-01-11' AS Date), 1, 1, 1)
SET IDENTITY_INSERT [dbo].[AbsenceDay] OFF
SET IDENTITY_INSERT [dbo].[AbsencePeriod] ON 

INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (18, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (19, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[AbsencePeriod] ([AbsencePeriodId], [StartDate], [EndDate], [OrganisationId]) VALUES (20, CAST(N'2016-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4)
SET IDENTITY_INSERT [dbo].[AbsencePeriod] OFF
SET IDENTITY_INSERT [dbo].[AbsencePolicy] ON 

INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (11, 4, N'Permanent', 39)
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (36, 4, N'General', 57)
INSERT [dbo].[AbsencePolicy] ([AbsencePolicyId], [OrganisationId], [Name], [WorkingPatternId]) VALUES (38, 4, N'Test General', 56)
SET IDENTITY_INSERT [dbo].[AbsencePolicy] OFF
SET IDENTITY_INSERT [dbo].[AbsencePolicyEntitlement] ON 

INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (16, 4, 3, 1, 10, 4, 1, 1, 11, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (33, 4, 2, 2, 10, 5, 0, 0, 11, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (40, 4, 3, 1, 15, 7, 0, 1, 38, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (46, 4, 3, 1, 12, 8, 1, 1, 36, 1)
INSERT [dbo].[AbsencePolicyEntitlement] ([AbsencePolicyEntitlementId], [OrganisationId], [AbsenceTypeId], [FrequencyId], [Entitlement], [MaximumCarryForward], [IsUnplanned], [IsPaid], [AbsencePolicyId], [HasEntitlement]) VALUES (50, 4, 2, 2, 3, 2, 1, 1, 36, 1)
SET IDENTITY_INSERT [dbo].[AbsencePolicyEntitlement] OFF
SET IDENTITY_INSERT [dbo].[AbsencePolicyPeriod] ON 

INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (15, 4, 11, 20)
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (29, 4, 38, 18)
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (44, 4, 36, 18)
INSERT [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId], [OrganisationId], [AbsencePolicyId], [AbsencePeriodId]) VALUES (45, 4, 36, 19)
SET IDENTITY_INSERT [dbo].[AbsencePolicyPeriod] OFF
SET IDENTITY_INSERT [dbo].[AbsenceStatus] ON 

INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (1, N'Unapproved')
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (2, N'Approved')
INSERT [dbo].[AbsenceStatus] ([AbsenceStatusId], [Name]) VALUES (3, N'Declined')
SET IDENTITY_INSERT [dbo].[AbsenceStatus] OFF
SET IDENTITY_INSERT [dbo].[AbsenceType] ON 

INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (2, 4, N'Casual', 9)
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (3, 4, N'Earned', 27)
INSERT [dbo].[AbsenceType] ([AbsenceTypeId], [OrganisationId], [Name], [ColourId]) VALUES (4, 4, N'Doctor''s Appointment', 27)
SET IDENTITY_INSERT [dbo].[AbsenceType] OFF
SET IDENTITY_INSERT [dbo].[Admission] ON 

INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (30, 23, 17, 5, CAST(N'2017-06-01' AS Date), 4, 67)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (31, 24, 17, 5, CAST(N'2017-06-03' AS Date), 4, 68)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (32, 27, 17, 5, CAST(N'2017-06-03' AS Date), 4, 69)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (33, 26, 17, 5, CAST(N'2017-06-03' AS Date), 4, 30)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (34, 28, 18, 5, CAST(N'2017-06-05' AS Date), 4, 71)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (35, 25, 19, 5, CAST(N'2017-06-06' AS Date), 4, 72)
INSERT [dbo].[Admission] ([AdmissionId], [RegistrationId], [BatchId], [CentreId], [AdmissionDate], [OrganisationId], [PersonnelId]) VALUES (36, 29, 18, 5, CAST(N'2017-06-10' AS Date), 4, 73)
SET IDENTITY_INSERT [dbo].[Admission] OFF
SET IDENTITY_INSERT [dbo].[AreaOfInterest] ON 

INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (0, N'IT', 4)
INSERT [dbo].[AreaOfInterest] ([AreaOfInterestId], [Name], [OrganisationId]) VALUES (1, N'ITEs', 4)
SET IDENTITY_INSERT [dbo].[AreaOfInterest] OFF
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'1', N'SuperAdmin', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'2', N'Admin', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'3', N'User', N'ApplicationRole')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Discriminator]) VALUES (N'4', N'Trainer', N'ApplicationRole')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'01b40bcf-c599-473c-854c-4effa911ec1e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'032c1e43-fba7-47f8-a477-9a09dcf82daa', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'04ee5f8b-e018-4a17-aac9-b6019cfce276', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0a6b1e2b-4ac3-414e-8738-9e5a4d9b6e36', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0b23dc04-f364-45ba-b98e-fb0a49f94656', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0f13e616-a95a-47a5-9995-60cbc592c3d1', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0f7a08f6-1a5a-4319-a5fd-1f2fa719634d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'10f5e02b-c762-4565-8b2d-0f43aa081319', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'116fc575-4a86-4f13-b997-fe9f32d305ff', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1700c28e-d342-4959-bb7d-641d66f6719f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1ca4f2bf-dd06-44a4-aa09-2b4dcf5b4a79', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1cdf0155-d903-4718-8df2-0b398b40f1ca', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1f2db86c-81fb-4eec-9d5f-0c780eafb590', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'209a9149-18d6-47e5-b880-53cc8aeb856f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'246e2f76-68bd-486a-8468-c54851c87541', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'269ee34f-44b5-4374-9d16-ee31c8de0974', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2992313b-87d5-4229-8c3a-6578d222e293', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2ac20a85-a6dc-4429-92e1-15b00f08adb8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2b9a1443-fa62-4cb0-aec7-b7b5770436ac', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2c4ebd78-f541-440c-b9de-fad81a0f5a98', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d921f72-b892-4cca-b294-210592790854', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2f4ebcc1-5ff9-4f9f-a31d-66c47aee5894', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2fcffb9e-89f7-416d-8b52-981212f1cc95', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2fd4cd69-4a25-46e0-af8c-2ed5d28f610f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'30ee0b23-785a-4d06-a95d-0f7b6d9ce31f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'316f648b-6ca2-4d98-9f93-c7afdd943789', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'320ac667-ee90-48a2-9b53-fb9c10ec0d61', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'33bb0ae7-2832-4072-8622-fec97b97b71b', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'34ab16e8-1e47-4561-8998-aa9bda9451cd', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'368eb845-84c0-4b41-a3fe-4b8e17566012', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'38279ad7-91c8-4968-932c-0a5a05ab495c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3deed64b-69ec-49fc-905f-a73cd5582f3c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'40ee8af2-4d7c-4a93-af2b-118d78db6b81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'431aa089-ac08-48d6-b671-e1087f85bcb8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4741b301-d9dc-4c8e-b029-a8688a0a0308', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'475e52f8-bb3b-4834-ae84-17842b12b0c8', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'491e3deb-c570-47f1-aec9-b649ac239db2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4cdce9f5-89a3-4680-a211-1c0913bf58bf', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'50b3a684-5599-4a40-9f0f-47a5c37e8e15', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52abb99d-d48a-4d32-ba55-bbb89bece8de', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'52f41cd9-bc88-42d4-8d34-90b259d6fd46', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'552b29ce-8872-4f8c-b8dd-747ae4333e4e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'55a1f00f-cd0b-491f-b04b-57803b0db161', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'58bfb3ef-4949-4d43-8c89-a1409d16a08a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'594e3477-339d-4749-8b89-58d75936a640', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f4dd0b1-b3e8-4203-bc10-1df868bf5963', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'634bc7d0-dca0-42be-9321-d854d5d3ec69', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'648b8178-35bf-4223-8ebf-7649977683c7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6cabb6dd-2875-4589-8ab7-923610c62349', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6cf75ade-561f-4fdc-a1e5-fa57cd9ef8ce', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6ef120ae-6041-4314-86ee-884093da1a68', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'777e2ec6-d74a-4707-a1ef-16c96f73248d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7d585050-8a4a-4d9a-960b-2228875ddc46', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8157d325-2c95-4811-82b3-b215fd49afa4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87731cf8-8a27-4efe-8f6a-7ed3b2b5f255', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87856032-423b-4815-aeb8-69b7e4683a22', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8abcec0a-82c9-4688-8e1f-61d13e3e4d9a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8acf06ba-e517-4b6e-abcb-359024cc2ad9', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8d5d253b-be78-4705-b9cb-a1c04276c6ee', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9126ad61-924c-4ec3-8eaf-05386fb9a999', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'995a714c-8876-41ab-8e48-1c79b01d459f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9b923fee-8028-493a-b54d-666fb6397a75', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9bb0610e-788e-4dfc-93b6-82af4c016765', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4110fcf-efe0-4055-986e-02e1d2affbc4', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a79cb6fc-1cba-4f32-96f9-e1e4e9890ee5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a7c5b186-bec2-4efe-a36d-55ba5c5ae34a', N'4')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aab6fc24-4f57-4de7-9979-3b790eef72c9', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ae397432-e4aa-44a6-80a6-dc9bea2a251e', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'afdca75e-d51d-410b-abfc-a3fb0b61a198', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b38dc1bf-0691-4edf-9428-7b205a07f80d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b7ca56c6-e0b1-4d0c-8657-01ee818a377f', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bb141879-1336-4a91-8640-506a9d1f71bf', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bbe75a61-9216-4c97-8e5c-2a85ec3b6885', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c1a636b0-4939-4da5-8e76-bbb2c876d82b', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c2971d39-34ae-4165-89dc-78fedde57f81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c42d62c2-1c0b-4f32-8c0f-c13ab60e3073', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c7ef57ec-c373-49bc-bbcb-f677b6dea483', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ca1a33e0-4455-484c-a494-2d6ee9921359', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cd588053-3088-4ad2-b26d-22b0822fe855', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ceddcad2-e6ab-4046-a109-11c1c8b5ffa3', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e2ae65fc-51f3-4d01-8c0c-063c4abd0da2', N'3')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e3482627-f15f-4d8d-b347-572e78e41dae', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e772c2cb-ed43-4763-b597-6c0397fae623', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'ea78e966-60fc-42d3-8fd2-68e826d1c56d', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f0f886e4-57fa-4bd2-86bd-e9c6687b5be6', N'4')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f1e97402-9a85-4dbc-8919-fcaf4318f7c7', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f68428ff-8dd1-49fb-8a1a-8655f3bf076d', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f72d0864-d72f-468b-940c-1a3deb3b3250', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fa4c3ca7-d0d6-4c09-9dd7-22af3c5d6abe', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fbe3dde3-c2da-4337-9667-0d363bfac5c5', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fdd6d9a2-1d33-4e76-a4e5-7988effb6d81', N'3')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'1')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'fe861a67-db8e-401f-95f3-9142300a7e84', N'superadmin@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'dac1f363-20c6-4593-a998-f35725ba23c9', NULL, 0, 0, NULL, 0, 0, N'superadmin@nidantech.com', 4, NULL, -1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f6295d2a-12ee-4d1e-ab0b-707716a24d6a', N'admin1@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'62873593-517e-4f95-9f64-0490e940528a', NULL, 0, 0, NULL, 0, 0, N'admin1@itsupportlimited.com', 1, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'24b0530f-ce19-4004-be38-a6cc1533e322', N'admin2@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'e34fdba4-6bec-417f-923f-8d95dda829b2', NULL, 0, 0, NULL, 0, 0, N'admin2@itsupportlimited.com', 2, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'afcf5153-7257-4d0e-9095-2d2286c0abbe', N'employee@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'cf421afd-9c38-457c-a6af-c521e1d602d9', NULL, 0, 0, NULL, 0, 0, N'employee@itsupportlimited.com', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'81c6963a-e6b6-40f2-8ff7-ab17a033d95f', N'admindevuk@itsupportlimited.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'87edef0d-7230-4a5e-81a5-00e45867c9b7', NULL, 0, 0, NULL, 0, 0, N'admindevuk@itsupportlimited.com', 3, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'baa66088-ea1b-43ab-b8b0-ee75523e613a', N'admindevmumbai@nidantech.com', 1, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2638a07d-1d70-4d9d-aea8-9fa592ebd519', NULL, 0, 0, NULL, 0, 0, N'admindevmumbai@nidantech.com', 4, 20, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'cded29f3-f32f-4143-86b9-30cce601d2db', N'boss@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'88943326-3aac-4de3-9952-aef532cb151b', NULL, 0, 0, NULL, 1, 0, N'boss@hr.com', 1, 3, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'4836e102-343b-4c9f-ba96-00461f4893f3', N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'cbfb458c-0f8d-4bf8-883d-0e46c5c4426b', NULL, 0, 0, NULL, 1, 0, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 4, NULL, 2)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'd9ceb6d0-4ade-4d87-ae3c-c829206620d5', N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'f0d27bfc-9683-4dfc-8bb4-9a8353c3ebe9', NULL, 0, 0, NULL, 1, 0, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', 4, 21, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'88450232-24c3-4cba-919b-7c1c4c64f4f2', N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'd29730e8-04fe-4e86-be51-b6de06e173db', NULL, 0, 0, NULL, 1, 0, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', 4, 22, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'1b4ec15b-abff-46c0-a029-df405b2d4ffb', N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'6bdbe6e5-2109-4d58-b54c-e4212315465d', NULL, 0, 0, NULL, 1, 0, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', 4, 23, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'20c83ae9-a47c-4122-8b00-2a14e98db983', N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'19e19041-015f-45d4-a2dd-5c486e2b3736', NULL, 0, 0, NULL, 1, 0, N'ff9c1c49-1fe5-41aa-a5a4-047c29fa7ff5@hr.com', 4, 24, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'424193a9-7b3f-43cc-9806-b27db02c5db4', N'sunjayp88456@gmail.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'47e90459-e1cf-41b2-a0b4-e88cc4f5266b', NULL, 0, 0, NULL, 1, 0, N'sunjayp88456@gmail.com', 4, 13, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'9349a8cd-5b5d-4ab5-80bf-9b178a0629cd', N'panontonganm@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'1108f492-9cba-4934-b5fb-652b97e11f90', NULL, 0, 0, NULL, 1, 0, N'panontonganm@andersongroup.uk.com', 1, 13, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'db5f88be-4018-4647-8776-01e9cd07753a', N'johhpaulc@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'904bfac7-a8bc-48a3-a551-7fa0e779b464', NULL, 0, 0, NULL, 1, 0, N'johhpaulc@andersongroup.uk.com', 1, 14, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'a7c5b186-bec2-4efe-a36d-55ba5c5ae34a', N'ragini@gmail.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'7f28aa2f-9b8d-4427-ac50-0ee6a743939f', NULL, 0, 0, NULL, 1, 0, N'ragini@gmail.com', 4, 65, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'2fcffb9e-89f7-416d-8b52-981212f1cc95', N'rahul@gmail.com', 0, N'AOq5Kvq/ZJqx3nKm6R4Q6UJ+LD7G1cVzPJmdIiv+O1LhY8t5ZQLHdnKA8oezm2S6Gw==', N'99643e38-0db0-4776-af43-5d90cb072d50', NULL, 0, 0, NULL, 1, 0, N'rahul@gmail.com', 4, 67, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'e772c2cb-ed43-4763-b597-6c0397fae623', N'prabhat@gmail.com', 0, N'AB24QZDbkPRaWSS2iAKeuAPCIjAPXMkbfo/pONqTOBDqZbxLhYWE3jV7Cmne/5Y2/g==', N'ab2b1702-c2de-4a7a-9db8-2c3da243378d', NULL, 0, 0, NULL, 1, 0, N'prabhat@gmail.com', 4, 68, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'aed476a0-3739-44a0-bd2f-b11a3287689c', N'kristineg@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'4fbc5e0a-e3d2-4622-bd35-04a8502f5268', NULL, 0, 0, NULL, 1, 0, N'kristineg@andersongroup.uk.com', 1, 15, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'06586b59-4429-436d-9b26-800d880483df', N'dev@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'e56d3f92-2be7-4ecf-8a0f-f6118507987a', NULL, 0, 0, NULL, 1, 0, N'christophers@andersongroup.uk.com', 1, 16, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'ccd7d6ea-f514-40a8-9530-dd7744c5706c', N'dikshas@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'2ddce434-0ca5-4fa4-ae56-e49b62937034', NULL, 0, 0, NULL, 1, 0, N'dikshas@andersongroup.uk.com', 4, 16, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'77ec2e78-ed30-4b70-8fdf-7498a3f85492', N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'c5549f22-06e2-4870-9cb8-65b062d5b575', NULL, 0, 0, NULL, 1, 0, N'67f677f3-a905-483e-afd9-b3932e14e8ba@hr.com', 4, 14, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'817cad52-7b2e-4bf3-994d-2c9c91e03cd2', N'pankajc1@andersongroup.uk.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'7a1cdaa8-6e74-431e-ba28-63ee84ab43a7', NULL, 0, 0, NULL, 1, 0, N'pankajc1@andersongroup.uk.com', 4, 15, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'a4a988b5-e38b-4c70-a20b-bed97a8db4cb', N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'3d770f21-d1c7-44a7-a221-11e5cbcfa887', NULL, 0, 0, NULL, 1, 0, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', 4, 25, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f68428ff-8dd1-49fb-8a1a-8655f3bf076d', N'bmthane@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'21f0007e-2cc7-4f38-8449-94e44f47ec9c', NULL, 0, 0, NULL, 1, 0, N'bmthane@nidantech.com', 4, 26, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'634bc7d0-dca0-42be-9321-d854d5d3ec69', N'ci_jbp@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'08ff6cf4-678c-4140-8959-6fe39bb0ae04', NULL, 0, 0, NULL, 1, 0, N'ci_jbp@nidantech.com', 4, 28, 4)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'52f41cd9-bc88-42d4-8d34-90b259d6fd46', N'ci_ngp@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'746807cd-ed15-42b6-96c2-6557b0963800', NULL, 0, 0, NULL, 1, 0, N'ci_ngp@nidantech.com', 4, 29, 3)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'6cabb6dd-2875-4589-8ab7-923610c62349', N'bmvaishali@nidantech.com', 0, N'AAmuYdVcwfyvri+pKSdq1fDhPzxrHGR4xNVNXO2+E6lff1YWbpYHSIPVe4zcEjYSxw==', N'0096d556-9a7a-4330-aaaf-868b50d53a1f', NULL, 0, 0, NULL, 1, 0, N'bmvaishali@nidantech.com', 4, 30, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'f0f886e4-57fa-4bd2-86bd-e9c6687b5be6', N'shanaya@gmail.com', 0, N'AEaAbudMOvs5zgnly+NvDIPmzjNLKRJ57QhF0JDVLJVfcxJnQFh/DIakt5e7yC2fTg==', N'f2ac5653-aaec-476d-84e4-82f15c2d299c', NULL, 0, 0, NULL, 1, 0, N'shanaya@gmail.com', 4, 66, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'8d5d253b-be78-4705-b9cb-a1c04276c6ee', N'pratiksha@gmail.com', 0, N'ANhXi0IE5bn+CsxLbS1C5cLd7Vry7JyW9gbGmsVqtzkWj8YSxDRfEhLvxuyBNoeFBA==', N'b2d9b844-ff8d-43a9-a9ea-eb488c275df0', NULL, 0, 0, NULL, 1, 0, N'pratiksha@gmail.com', 4, 69, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'8abcec0a-82c9-4688-8e1f-61d13e3e4d9a', N'jyoti@gmail.com', 0, N'ALyCszpdNmBghD2OD2ZlWUZ/Qc49CWjA644lBpSeomXaFem8y77O2k2DgbTe0zKv0w==', N'22b06f92-33c0-45aa-b23b-35a0e835c912', NULL, 0, 0, NULL, 1, 0, N'jyoti@gmail.com', 4, 70, 5)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [OrganisationId], [PersonnelId], [CentreId]) VALUES (N'1cdf0155-d903-4718-8df2-0b398b40f1ca', N'developer@nidantech.com', 0, N'ACPlz2uHEArs62TaWCmD4L8S4vPsbNM2wtmk3AB1ebpshTVaZGLbmBKme3JnFiXrwA==', N'f6ba977e-80f1-4a7c-b2f3-592424294ba8', NULL, 0, 0, NULL, 1, 0, N'developer@nidantech.com', 4, 71, 5)
SET IDENTITY_INSERT [dbo].[Attendance] ON 

INSERT [dbo].[Attendance] ([AttendanceId], [PersonnelId], [StudentCode], [InHour], [InMinute], [InTimeSpan], [OutHour], [OutMinute], [OutTimeSpan], [IsPresent], [AttendanceDate], [CentreId], [OrganisationId]) VALUES (2, 67, N'127', 1, 30, N'AM', 3, 0, N'PM', 0, CAST(N'2017-06-01' AS Date), 5, 4)
INSERT [dbo].[Attendance] ([AttendanceId], [PersonnelId], [StudentCode], [InHour], [InMinute], [InTimeSpan], [OutHour], [OutMinute], [OutTimeSpan], [IsPresent], [AttendanceDate], [CentreId], [OrganisationId]) VALUES (4, 67, N'127', 2, 0, N'PM', 4, 0, N'PM', 0, CAST(N'2017-06-02' AS Date), 5, 4)
SET IDENTITY_INSERT [dbo].[Attendance] OFF
SET IDENTITY_INSERT [dbo].[Batch] ON 

INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (17, N'.Net Morning Batch', 10, 11, 2, 0, CAST(N'2017-06-05' AS Date), CAST(N'2018-02-12' AS Date), 0, 2, 1, 0, N'AM', 3, 0, N'PM', CAST(N'2018-02-15' AS Date), 5, 4, CAST(N'2017-05-30' AS Date), NULL, 8, 6, 6583, 6583, 6583, 6583, 6583, 6583, NULL, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (18, N'MIS Batch', 20, 10, 22, 0, CAST(N'2017-06-05' AS Date), CAST(N'2018-02-12' AS Date), 0, 2, 2, 0, N'PM', 4, 0, N'PM', CAST(N'2018-02-15' AS Date), 5, 4, CAST(N'2017-06-05' AS Date), NULL, 8, 6, 4250, 4250, 4250, 4250, 4250, 4250, NULL, NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[Batch] ([BatchId], [Name], [Intake], [CourseInstallmentId], [CourseId], [TrainerId], [BatchStartDate], [BatchEndDate], [NumberOfHolidays], [NumberOfHoursDaily], [BatchStartTimeHours], [BatchStartTimeMinutes], [BatchStartTimeSpan], [BatchEndTimeHours], [BatchEndTimeMinutes], [BatchEndTimeSpan], [AssessmentDate], [CentreId], [OrganisationId], [CreatedDate], [Remarks], [Month], [NumberOfInstallment], [FirstInstallment], [SecondInstallment], [ThirdInstallment], [FourthInstallment], [FifthInstallment], [SixthInstallment], [SeventhInstallment], [EighthInstallment], [NinethInstallment], [TenthInstallment], [EleventhInstallment], [TwelvethInstallment], [RoomId]) VALUES (19, N'Java Batch', 10, 12, 5, 0, CAST(N'2017-06-06' AS Date), CAST(N'2018-02-13' AS Date), 0, 2, 5, 0, N'PM', 7, 0, N'PM', CAST(N'2018-02-16' AS Date), 5, 4, CAST(N'2017-06-06' AS Date), NULL, 8, 6, 6666, 6666, 6666, 6666, 6666, 6666, NULL, NULL, NULL, NULL, NULL, NULL, 6)
SET IDENTITY_INSERT [dbo].[Batch] OFF
SET IDENTITY_INSERT [dbo].[BatchDay] ON 

INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (16, 4, 17, 1, 1, 0, 0, 0, 0, 0, 5)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (17, 4, 18, 1, 1, 0, 0, 0, 0, 0, 5)
INSERT [dbo].[BatchDay] ([BatchDayId], [OrganisationId], [BatchId], [IsMonday], [IsTuesday], [IsWednesday], [IsThursday], [IsFriday], [IsSaturday], [IsSunday], [CentreId]) VALUES (18, 4, 19, 1, 1, 0, 0, 0, 0, 0, 5)
SET IDENTITY_INSERT [dbo].[BatchDay] OFF
SET IDENTITY_INSERT [dbo].[BatchTimePrefer] ON 

INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (1, N'8 am To 12 pm', 4)
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (2, N'12 pm To 4 pm', 4)
INSERT [dbo].[BatchTimePrefer] ([BatchTimePreferId], [Name], [OrganisationId]) VALUES (3, N'4 pm To 8 pm', 4)
SET IDENTITY_INSERT [dbo].[BatchTimePrefer] OFF
SET IDENTITY_INSERT [dbo].[BatchTrainer] ON 

INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (16, 17, 4, 4, 5)
INSERT [dbo].[BatchTrainer] ([BatchTrainerId], [BatchId], [TrainerId], [OrganisationId], [CentreId]) VALUES (17, 19, 4, 4, 5)
SET IDENTITY_INSERT [dbo].[BatchTrainer] OFF
SET IDENTITY_INSERT [dbo].[Building] ON 

INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (1, N'PankajBuilding', 4, 12, N'Mumbai')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (2, N'PankajBuilding2', 4, 13, N'Mumbai2')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (3, N'PankajBuilding3', 4, 12, N'Mumbai3')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (4, N'PankajBuilding4', 4, 14, N'TestBuilding')
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (5, N'test1building', 4, 12, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (7, N't2building', 4, 12, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [OrganisationId], [SiteId], [Address1]) VALUES (8, N'test new', 4, 16, NULL)
SET IDENTITY_INSERT [dbo].[Building] OFF
SET IDENTITY_INSERT [dbo].[CandidateFee] ON 

INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (191, CAST(N'2017-05-30 17:06:20.917' AS DateTime), 30, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-05-30 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'127', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (192, CAST(N'2017-06-01 12:14:45.057' AS DateTime), 30, CAST(3000.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'127', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (193, CAST(N'2017-06-02 05:33:44.700' AS DateTime), 30, CAST(10000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'127', 1, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-30 00:00:00.000' AS DateTime), 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (194, CAST(N'2017-06-05 07:01:30.303' AS DateTime), 30, CAST(8000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'127', 2, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-30 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (195, CAST(N'2017-06-05 07:08:31.353' AS DateTime), 30, CAST(8000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-09-05 00:00:00.000' AS DateTime), N'127', 3, CAST(10000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-09-30 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (196, NULL, 30, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'127', 4, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-09-30 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (197, CAST(N'2017-06-01 15:59:57.820' AS DateTime), 31, CAST(10000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'136', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (198, CAST(N'2017-06-01 16:02:10.897' AS DateTime), 32, CAST(5000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'134', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (199, CAST(N'2017-06-01 16:07:40.510' AS DateTime), 33, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'133', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (200, CAST(N'2017-06-02 12:41:47.690' AS DateTime), 34, CAST(7000.00 AS Decimal(18, 2)), 1, 1, NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, NULL, NULL, N'130', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (201, CAST(N'2017-06-03 12:45:10.940' AS DateTime), 31, CAST(0.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'136', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (202, CAST(N'2017-06-05 07:12:09.153' AS DateTime), 31, CAST(20000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'136', 1, CAST(19000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-08-01 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, CAST(1000.00 AS Decimal(18, 2)))
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (203, CAST(N'2017-06-09 07:02:34.047' AS DateTime), 31, CAST(19000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'136', 2, CAST(19000.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-08-01 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (204, CAST(N'2017-06-03 13:05:15.777' AS DateTime), 34, CAST(33000.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'130', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (205, CAST(N'2017-06-03 15:29:15.447' AS DateTime), 33, CAST(3000.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'133', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (206, CAST(N'2017-06-05 10:47:50.527' AS DateTime), 33, CAST(18000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'133', 1, CAST(20000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-08-01 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (207, CAST(N'2017-06-05 10:49:05.913' AS DateTime), 33, CAST(20000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'133', 2, CAST(22000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-08-01 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (208, CAST(N'2017-06-05 12:28:47.683' AS DateTime), 35, CAST(1000.00 AS Decimal(18, 2)), 1, 1, NULL, NULL, NULL, NULL, NULL, N'138', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (209, CAST(N'2017-06-05 15:32:51.797' AS DateTime), 35, CAST(3500.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'138', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (210, CAST(N'2017-06-05 10:06:13.657' AS DateTime), 35, CAST(4000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'138', 1, CAST(4250.00 AS Decimal(18, 2)), CAST(250.00 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (211, CAST(N'2017-06-05 10:10:51.657' AS DateTime), 35, CAST(5000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'138', 2, CAST(4500.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, CAST(500.00 AS Decimal(18, 2)))
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (212, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-09-05 00:00:00.000' AS DateTime), N'138', 3, CAST(3750.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (213, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'138', 4, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (214, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-11-05 00:00:00.000' AS DateTime), N'138', 5, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (215, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-12-05 00:00:00.000' AS DateTime), N'138', 6, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (216, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'138', 1, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (217, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'138', 2, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (218, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-09-05 00:00:00.000' AS DateTime), N'138', 3, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (219, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'138', 4, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (220, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-11-05 00:00:00.000' AS DateTime), N'138', 5, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (221, NULL, 35, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-12-05 00:00:00.000' AS DateTime), N'138', 6, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (222, CAST(N'2017-06-06 11:23:26.137' AS DateTime), 32, CAST(0.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'134', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (223, CAST(N'2017-06-06 08:45:07.380' AS DateTime), 32, CAST(6000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'134', 1, CAST(6666.66 AS Decimal(18, 2)), CAST(666.66 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-12-06 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (224, CAST(N'2017-06-06 08:39:32.880' AS DateTime), 32, CAST(6000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'134', 2, CAST(7333.32 AS Decimal(18, 2)), CAST(666.66 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-12-06 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (225, CAST(N'2017-06-09 06:38:41.810' AS DateTime), 32, CAST(7000.00 AS Decimal(18, 2)), 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-09-05 00:00:00.000' AS DateTime), N'134', 3, CAST(7333.32 AS Decimal(18, 2)), CAST(333.32 AS Decimal(18, 2)), NULL, N'2017-2018', CAST(N'2017-12-06 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (226, CAST(N'2017-06-09 06:38:49.850' AS DateTime), 32, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'134', 4, CAST(6999.98 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-06 00:00:00.000' AS DateTime), 5, 4, 1, 30, 1, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (227, NULL, 32, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-11-05 00:00:00.000' AS DateTime), N'134', 5, CAST(6666.66 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-06 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (228, NULL, 32, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-12-05 00:00:00.000' AS DateTime), N'134', 6, CAST(6666.66 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-06 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (229, CAST(N'2017-06-10 18:37:49.180' AS DateTime), 36, CAST(2000.00 AS Decimal(18, 2)), 1, 1, NULL, NULL, NULL, NULL, NULL, N'131', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (230, CAST(N'2017-06-10 18:41:27.990' AS DateTime), 36, CAST(2500.00 AS Decimal(18, 2)), 1, 2, NULL, NULL, NULL, NULL, NULL, N'131', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (231, NULL, 36, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-07-05 00:00:00.000' AS DateTime), N'131', 1, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (232, NULL, 36, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-08-05 00:00:00.000' AS DateTime), N'131', 2, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (233, NULL, 36, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-09-05 00:00:00.000' AS DateTime), N'131', 3, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (234, NULL, 36, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'131', 4, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (235, NULL, 36, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-11-05 00:00:00.000' AS DateTime), N'131', 5, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (236, NULL, 36, NULL, 1, 3, NULL, NULL, NULL, NULL, CAST(N'2017-12-05 00:00:00.000' AS DateTime), N'131', 6, CAST(4250.00 AS Decimal(18, 2)), NULL, NULL, N'2017-2018', CAST(N'2017-12-05 00:00:00.000' AS DateTime), 5, 4, 0, 30, 0, NULL)
INSERT [dbo].[CandidateFee] ([CandidateFeeId], [PaymentDate], [CandidateInstallmentId], [PaidAmount], [PaymentModeId], [FeeTypeId], [ChequeNumber], [ChequeDate], [BankName], [Penalty], [InstallmentDate], [StudentCode], [InstallmentNumber], [InstallmentAmount], [BalanceInstallmentAmount], [Particulars], [FiscalYear], [FollowUpDate], [CentreId], [OrganisationId], [IsPaymentDone], [PersonnelId], [IsPaidAmountOverride], [AdvancedAmount]) VALUES (237, CAST(N'2017-06-21 15:10:45.100' AS DateTime), 37, CAST(3000.00 AS Decimal(18, 2)), 1, 1, NULL, NULL, NULL, NULL, NULL, N'132', NULL, NULL, NULL, NULL, N'2017-2018', NULL, 5, 4, 1, 30, 0, NULL)
SET IDENTITY_INSERT [dbo].[CandidateFee] OFF
SET IDENTITY_INSERT [dbo].[CandidateInstallment] ON 

INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (30, N'127', CAST(45000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, 4, NULL, 5, 4, 7, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (31, N'136', CAST(43000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), 2, NULL, 5, 4, 7, 0, 1, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (32, N'134', CAST(45000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, 6, NULL, 5, 4, 8, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (33, N'133', CAST(45000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, 2, NULL, 5, 4, 8, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (34, N'130', CAST(44000.00 AS Decimal(18, 2)), CAST(5500.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), NULL, CAST(40000.00 AS Decimal(18, 2)), 5, 4, 11, 0, 1, N'LumpsumAmount')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (35, N'138', CAST(30000.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)), NULL, 6, NULL, 5, 4, 10, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (36, N'131', CAST(30000.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)), NULL, 6, NULL, 5, 4, 10, 0, 0, N'MonthlyInstallment')
INSERT [dbo].[CandidateInstallment] ([CandidateInstallmentId], [StudentCode], [CourseFee], [DownPayment], [DiscountAmount], [NumberOfInstallment], [LumpsumAmount], [CentreId], [OrganisationId], [CourseInstallmentId], [IsPercentageDiscount], [IsTotalAmountDiscount], [PaymentMethod]) VALUES (37, N'132', CAST(43000.00 AS Decimal(18, 2)), CAST(5500.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), NULL, CAST(40000.00 AS Decimal(18, 2)), 5, 4, 11, 0, 1, N'MonthlyInstallment')
SET IDENTITY_INSERT [dbo].[CandidateInstallment] OFF
SET IDENTITY_INSERT [dbo].[CasteCategory] ON 

INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (1, N'SC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (2, N'ST', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (3, N'OBC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (4, N'MBC', 4)
INSERT [dbo].[CasteCategory] ([CasteCategoryId], [Caste], [OrganisationId]) VALUES (5, N'GEN', 4)
SET IDENTITY_INSERT [dbo].[CasteCategory] OFF
SET IDENTITY_INSERT [dbo].[Centre] ON 

INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (1, N'thane', N'NEST Thane', N'Thane', NULL, NULL, NULL, 1, 1, 1, 400602, N'bmthane@nidantech.com', 241314501, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (2, NULL, N'test', N'test', NULL, NULL, NULL, 1, 1, 1, 123456, N'test', 1234567890, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (3, NULL, N'NEST Nagpur', N'Nagpur', NULL, NULL, NULL, 1, 1, 1, 440004, N'bmngp@nidantech.com', 9689040418, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (4, NULL, N'NEST Jabalpur', N'Jabalpur', NULL, NULL, NULL, 1, 1, 1, 482002, N'bmjbp@nidantech.com', 7583833555, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (5, NULL, N'NEST Delhi', N'Vaishali, Delhi', NULL, NULL, NULL, 1, 1, 1, 201010, N'bmvaishali@nidantech.com', 8268105386, 4)
INSERT [dbo].[Centre] ([CentreId], [CentreCode], [Name], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [EmailId], [Telephone], [OrganisationId]) VALUES (6, NULL, N'NEST Pune', N'Pune', NULL, NULL, NULL, 1, 15, 1, 123456, N'bmpune@nidantech.com', 12345678, 4)
SET IDENTITY_INSERT [dbo].[Centre] OFF
SET IDENTITY_INSERT [dbo].[CentreCourse] ON 

INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (18, 22, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (19, 2, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (20, 5, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (21, 2, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (22, 5, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (23, 1, 1, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (24, 39, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (25, 42, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (26, 8, 5, 4)
INSERT [dbo].[CentreCourse] ([CentreCourseId], [CourseId], [CentreId], [OrganisationId]) VALUES (27, 13, 5, 4)
SET IDENTITY_INSERT [dbo].[CentreCourse] OFF
SET IDENTITY_INSERT [dbo].[CentreCourseInstallment] ON 

INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (8, 9, 1, 4)
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (9, 7, 1, 4)
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (11, 8, 1, 4)
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (12, 8, 5, 4)
INSERT [dbo].[CentreCourseInstallment] ([CentreCourseInstallmentId], [CourseInstallmentId], [CentreId], [OrganisationId]) VALUES (13, 7, 5, 4)
SET IDENTITY_INSERT [dbo].[CentreCourseInstallment] OFF
SET IDENTITY_INSERT [dbo].[CentrePettyCash] ON 

INSERT [dbo].[CentrePettyCash] ([CentrePettyCashId], [CentreId], [Amount], [Particulars], [CreatedDate], [CreatedBy], [OrganisationId]) VALUES (2, 5, CAST(12000.00 AS Decimal(18, 2)), N'HO Petty Cash', CAST(N'2017-06-10 08:49:50.000' AS DateTime), 30, 4)
SET IDENTITY_INSERT [dbo].[CentrePettyCash] OFF
SET IDENTITY_INSERT [dbo].[CentreScheme] ON 

INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (19, 1, 5, 4)
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (21, 2, 5, 4)
INSERT [dbo].[CentreScheme] ([CentreSchemeId], [SchemeId], [CentreId], [OrganisationId]) VALUES (22, 1, 1, 4)
SET IDENTITY_INSERT [dbo].[CentreScheme] OFF
SET IDENTITY_INSERT [dbo].[CentreSector] ON 

INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (11, 2, 5, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (13, 1, 5, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (14, 7, 5, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (15, 2, 1, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (16, 11, 1, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (17, 10, 5, 4)
INSERT [dbo].[CentreSector] ([CentreSectorId], [SectorId], [CentreId], [OrganisationId]) VALUES (18, 15, 5, 4)
SET IDENTITY_INSERT [dbo].[CentreSector] OFF
INSERT [dbo].[CentreVoucherNumber] ([CentreVoucherNumberId], [CentreId], [Number], [OrganisationId]) VALUES (1, 1, 1, 4)
INSERT [dbo].[CentreVoucherNumber] ([CentreVoucherNumberId], [CentreId], [Number], [OrganisationId]) VALUES (2, 3, 1, 4)
INSERT [dbo].[CentreVoucherNumber] ([CentreVoucherNumberId], [CentreId], [Number], [OrganisationId]) VALUES (3, 4, 1, 4)
INSERT [dbo].[CentreVoucherNumber] ([CentreVoucherNumberId], [CentreId], [Number], [OrganisationId]) VALUES (4, 5, 3, 4)
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (1, N'ff8000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (2, N'FF0000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (3, N'808080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (4, N'708090')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (5, N'000000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (6, N'FFFFE0')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (7, N'FFD700')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (8, N'FFC0CB')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (9, N'FF69B4')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (10, N'FFA07A')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (11, N'FA8072')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (12, N'DC143C')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (13, N'B22222')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (14, N'FF0000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (15, N'FF4500')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (16, N'FF8C00')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (17, N'FFA500')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (18, N'DEB887')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (19, N'F4A460')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (20, N'B8860B')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (21, N'CD853F')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (22, N'8B4513')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (23, N'A52A2A')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (24, N'800000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (25, N'556B2F')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (26, N'6B8E23')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (27, N'32CD32')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (28, N'00FF00')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (29, N'00FF7F')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (30, N'008000')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (31, N'006400')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (32, N'00FFFF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (33, N'E0FFFF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (34, N'AFEEEE')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (35, N'40E0D0')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (36, N'20B2AA')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (37, N'008080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (38, N'B0C4DE')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (39, N'87CEEB')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (40, N'00BFFF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (41, N'1E90FF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (42, N'0000FF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (43, N'000080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (44, N'DDA0DD')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (45, N'EE82EE')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (46, N'FF00FF')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (47, N'9400D3')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (48, N'800080')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (49, N'4B0082')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (50, N'6A5ACD')
INSERT [dbo].[Colour] ([ColourId], [Hex]) VALUES (51, N'6699CC')
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (7, N'ITSK DS', 4, 1)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (8, N'PankajCompany', 4, 45)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (11, N'Test1', 4, 41)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (13, N'test12345', 4, 17)
INSERT [dbo].[Company] ([CompanyId], [Name], [OrganisationId], [ColourId]) VALUES (14, N'Test123454', 4, 48)
SET IDENTITY_INSERT [dbo].[Company] OFF
SET IDENTITY_INSERT [dbo].[CompanyBuilding] ON 

INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (3, 2, 8, 4)
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (4, 3, 8, 4)
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (10, 5, 8, 4)
INSERT [dbo].[CompanyBuilding] ([CompanyBuildingId], [BuildingId], [CompanyId], [OrganisationId]) VALUES (12, 1, 7, 4)
SET IDENTITY_INSERT [dbo].[CompanyBuilding] OFF
SET IDENTITY_INSERT [dbo].[Counselling] ON 

INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (19, 128, N'Ms.', N'Maya', N'SuraJ', N'Bhosale', 5, 4, 30, 8, N'10 am', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 50, NULL, NULL, NULL, 0)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (20, 134, N'Ms.', N'Sonakshi', N'Pradeep', N'Sinha', 5, 4, 30, 5, N'3 pm', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 50, NULL, NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (21, 130, N'Ms.', N'Pratiksha', N'Rohan', N'Girase', 5, 4, 30, 2, N'5PM', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 70, N'No', NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (22, 135, N'Mr.', N'Soham', N'Mangesh', N'Aaglawe', 5, 4, 30, 13, N'5PM', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 50, NULL, NULL, NULL, 0)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (23, 137, N'Ms.', N'Tanvi', N'Amol', N'Jadhav', 5, 4, 30, 13, N'5PM', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 40, NULL, NULL, NULL, 0)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (24, 132, N'Mr.', N'Sandip', N'Raosaheb', N'Vichare', 5, 4, 30, 2, N'10 am', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-07' AS Date), NULL, 0, N'Yes', 60, N'No', NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (25, 129, N'Mr.', N'Saurabh', N'Ram', N'Surve', 5, 4, 30, 2, N'10 am', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-07' AS Date), NULL, 0, N'Yes', 50, N'No', NULL, NULL, 0)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (26, 133, N'Ms.', N'Jyoti', N'Kalpnath', N'Kodte', 5, 4, 30, 5, N'4 pm', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-03' AS Date), NULL, 0, N'Yes', 40, N'No', NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (27, 136, N'Mr.', N'Prabhat', N'NIkhil', N'Bansode', 5, 4, 30, 2, N'5PM', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 70, NULL, NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (28, 131, N'Mr.', N'Sachin', N'Somnath', N'Khavade', 5, 4, 30, 22, NULL, NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 40, NULL, NULL, NULL, 1)
INSERT [dbo].[Counselling] ([CounsellingId], [EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [OrganisationId], [PersonnelId], [CourseOfferedId], [PreferTiming], [Remarks], [CreatedDate], [FollowUpDate], [RemarkByBranchManager], [SectorId], [PsychomatricTest], [ConversionProspect], [Close], [ClosingRemark], [RemarkByBm], [IsRegistrationDone]) VALUES (29, 138, N'Ms.', N'Bhakti', N'Rahul', N'Rane', 5, 4, 30, 22, N'3 pm', NULL, CAST(N'2017-05-31' AS Date), CAST(N'2017-06-02' AS Date), NULL, 0, N'Yes', 70, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Counselling] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (24, N'PankajCountry', 4)
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (25, N'PankajCountry2', 4)
INSERT [dbo].[Country] ([CountryId], [Name], [OrganisationId]) VALUES (29, N'Test', 4)
SET IDENTITY_INSERT [dbo].[Country] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (1, N'NSDC-LSC-CILT - DIPLOMA IN LOGISTICS OPERATIONS
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (2, N'NEST-IT-NIDAN CERTIFIED - .NET Software Development Program', 4, 2, 1, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (3, N'NEST-IT-NIDAN CERTIFIED - Accounting Professional
', 4, 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (4, N'NSDC-ESSCI-NIDAN CERTIFIED - Computer Hardware & Networking
', 4, 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (5, N'NEST-IT-NIDAN CERTIFIED - Java Software Development Program', 4, 2, 1, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (6, N'NEST-IT-NIDAN CERTIFIED - Open Source Application Development Program
', 4, 2, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (7, N'NSDC-LSC-Transport Coordinator
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (8, N'NSDC-LSC-Consignment Booking Assistant
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (9, N'NSDC-LSC-Consignment Tracking Executive
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (10, N'NSDC-LSC-Warehouse Supervisor
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (11, N'NSDC-LSC-Warehouse Picker
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (12, N'NSDC-LSC-Warehouse Binner
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (13, N'NSDC-LSC-Inventory Clerk
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (14, N'NSDC-LSC-Warehouse Packer
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (15, N'NSDC-LSC-Transport Consolidator
', 4, 1, 1, NULL, NULL, 104)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (16, N'NSDC-ESSCI-Field Technician Computing & Peripherals
', 4, 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (17, N'NSDC-ESSCI-Field Technician Network & Storage
', 4, 3, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (18, N'NSDC-Apparel-Sewing Machine Operator
', 4, 4, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (19, N'NSDC-Retail-Sales Associate
', 4, 5, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (20, N'NSDC-Telecom-Customer Care Executive
', 4, 6, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (21, N'NSDC-LSC-Transport Operation Assistant
', 4, 1, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (22, N'NEST-IT-MIS
', 4, 2, 1, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (23, N'PMKVY2.0-LSC-Consignment Booking Assistant', 4, 11, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (24, N'PMKVY2.0-LSC-Documentation Assistant', 4, 11, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (25, N'PMKVY2.0-NASSCOM-Domestic Data Entry Operator', 4, 7, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (26, N'PMKVY2.0-Apparel-Sewing  Machine Operator ', 4, 13, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (27, N'PMKVY2.0-Apparel-Hand Embroiderer', 4, 13, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (28, N'PMKVY2.0-Apparel-Self Employed Tailor ', 4, 13, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (29, N'PMKVY2.0-ESSCI-Field Technician Computing and Peripherals', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (30, N'PMKVY2.0-ESSCI-Field Technician Networking and Storage', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (31, N'PMKVY2.0-ESSCI-Mobile Phone Hardware Repair Technician', 4, 14, 2, NULL, NULL, 144)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (32, N'PMKVY2.0-ESSCI-Field Engineer RACW', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (33, N'PMKVY2.0-ESSCI-LED Light Repair Technician', 4, 14, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (34, N'PMKVY2.0-BEAUTY & WELLNEES-Assistant Beauty Therapist', 4, 8, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (35, N'PMKVY2.0-BEAUTY & WELLNEES-Assistant Hair Stylist
', 4, 8, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (36, N'PMKVY2.0-BEAUTY & WELLNEES-Pedicurist & Manicurist
', 4, 8, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (37, N'PMKVY2.0-Life Sciences-Medical Sales Representative
', 4, 9, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (39, N'Others', 4, 10, 1, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (42, N'Others', 4, 15, 2, NULL, NULL, NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (44, N'test', 4, 1, 1, 1, N'test', NULL)
INSERT [dbo].[Course] ([CourseId], [Name], [OrganisationId], [SectorId], [SchemeId], [CourseTypeId], [Description], [Duration]) VALUES (45, N'test duration', 4, 2, 1, 1, N'test duration', 144)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[CourseInstallment] ON 

INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (7, N'.Net Course Installment', 2, 45000, 5000, 40000, 4, NULL, 1, CAST(N'2017-05-30' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (8, N'Java Course Installment', 5, 45000, 5000, 40000, 4, NULL, 1, CAST(N'2017-05-30' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (9, N'Logistics Course Installment', 1, 45000, 5000, 40000, 4, NULL, 1, CAST(N'2017-05-30' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (10, N'MIS Course Installment', 22, 30000, 4500, 25000, 4, NULL, 5, CAST(N'2017-05-30' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (11, N'.Net Fee Break Up for Delhi', 2, 45000, 5500, 40000, 4, NULL, 5, CAST(N'2017-05-30' AS Date))
INSERT [dbo].[CourseInstallment] ([CourseInstallmentId], [Name], [CourseId], [Fee], [DownPayment], [LumpsumAmount], [OrganisationId], [NumberOfInstallment], [CentreId], [CreatedDate]) VALUES (12, N'Java Course Installment', 5, 45000, 5000, 40000, 4, NULL, 5, CAST(N'2017-06-06' AS Date))
SET IDENTITY_INSERT [dbo].[CourseInstallment] OFF
SET IDENTITY_INSERT [dbo].[CourseType] ON 

INSERT [dbo].[CourseType] ([CourseTypeId], [Name], [OrganisationId]) VALUES (1, N'Theory', 4)
INSERT [dbo].[CourseType] ([CourseTypeId], [Name], [OrganisationId]) VALUES (2, N'Lab', 4)
SET IDENTITY_INSERT [dbo].[CourseType] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (24, N'IT', 4, 19)
INSERT [dbo].[Department] ([DepartmentId], [Name], [OrganisationId], [ColourId]) VALUES (25, N'Testing', 4, 32)
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([DistrictId], [Name], [StateId], [OrganisationId]) VALUES (1, N'Test', 1, 4)
SET IDENTITY_INSERT [dbo].[District] OFF
SET IDENTITY_INSERT [dbo].[Document] ON 

INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1023, N'116', N'Vasudha', N'Abbreviations.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Vasudha_116\Counselling History\Counselling History_4f22d629-eb72-4bdc-ab0a-c582f74f183b_Abbreviations.pdf', 6, N'4f22d629-eb72-4bdc-ab0a-c582f74f183b', CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1024, N'117', N'Sanjay', N'5-10-vol-3-2-14-gjedt.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\Sanjay_117\psychometric\psychometric_eb153f3f-5e94-492c-83e0-9912be98d31c_5-10-vol-3-2-14-gjedt.pdf', 2, N'eb153f3f-5e94-492c-83e0-9912be98d31c', CAST(N'2017-05-20 00:00:00.000' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1025, N'3', NULL, N'BOOK FRONT PAGE VISUAL C#.NET.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Thane\_3\Trainer Document\Trainer Document_aefcf662-677d-4ca4-84a2-286675dedd97_BOOK FRONT PAGE VISUAL C#.NET.pdf', 9, N'aefcf662-677d-4ca4-84a2-286675dedd97', CAST(N'2017-05-31 00:00:00.000' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1026, N'135', N'Soham', N'MIT_C2Fact.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\Soham_135\Counselling History\Counselling History_9b693808-12ab-4831-a90f-806583670635_MIT_C2Fact.pdf', 6, N'9b693808-12ab-4831-a90f-806583670635', CAST(N'2017-05-31 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1027, N'4', NULL, N'MIT_C2Fact.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_4\Trainer Document\Trainer Document_b6e8090a-e296-4516-abc9-b37f6ad56a96_MIT_C2Fact.pdf', 9, N'b6e8090a-e296-4516-abc9-b37f6ad56a96', CAST(N'2017-06-14 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1028, N'4', NULL, N'Abbreviations.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_4\Trainer Document\Trainer Document_17ac48e2-1888-4c38-bb73-482cb2da2525_Abbreviations.pdf', 9, N'17ac48e2-1888-4c38-bb73-482cb2da2525', CAST(N'2017-06-14 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1029, N'4', NULL, N'5-10-vol-3-2-14-gjedt.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_4\Trainer Document\Trainer Document_37375e1e-94f6-49b1-a248-ad51a676d645_5-10-vol-3-2-14-gjedt.pdf', 9, N'37375e1e-94f6-49b1-a248-ad51a676d645', CAST(N'2017-06-14 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1030, N'4', NULL, N'MIT_C2Fact.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_4\Trainer Document\Trainer Document_c2a9e5c8-9a04-47ec-8a1f-3df095890476_MIT_C2Fact.pdf', 9, N'c2a9e5c8-9a04-47ec-8a1f-3df095890476', CAST(N'2017-06-14 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1031, N'4', NULL, N'5-10-vol-3-2-14-gjedt.pdf', N'Counselling Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_4\Trainer Document\Trainer Document_9fab7ab0-e6d8-4935-9d2a-923d34f29f82_5-10-vol-3-2-14-gjedt.pdf', 9, N'9fab7ab0-e6d8-4935-9d2a-923d34f29f82', CAST(N'2017-06-14 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1032, N'1234', N'1234', N'MIT_C2Fact.pdf', N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\1234_1234\Expense Document\Expense Document_d8f2f74c-f06e-42e5-84e4-763a0893f00b_MIT_C2Fact.pdf', 12, N'd8f2f74c-f06e-42e5-84e4-763a0893f00b', CAST(N'2017-06-21 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1033, N'1234', N'1234', N'5-10-vol-3-2-14-gjedt.pdf', N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\1234_1234\Expense Document\Expense Document_1a410498-5025-4e2e-a144-42caa9fad4f0_5-10-vol-3-2-14-gjedt.pdf', 12, N'1a410498-5025-4e2e-a144-42caa9fad4f0', CAST(N'2017-06-21 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1034, N'131', N'Sachin', N'Abbreviations.pdf', N'Admission Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\Sachin_131\Admission Document\Admission Document_ed135746-2fd8-4990-8075-851b135fd289_Abbreviations.pdf', 15, N'ed135746-2fd8-4990-8075-851b135fd289', CAST(N'2017-06-21 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1035, N'132', N'Sandip', N'MIT_C2Fact.pdf', N'Admission Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\Sandip_132\Admission Document\Admission Document_5496fedd-2828-4935-a334-fd705661514d_MIT_C2Fact.pdf', 15, N'5496fedd-2828-4935-a334-fd705661514d', CAST(N'2017-06-21 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1036, N'1234', N'1234', N'E789 Other Fee (2).pdf', N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\1234_1234\Expense Document\Expense Document_d0924639-a876-44f0-9013-9269973548ff_E789 Other Fee (2).pdf', 12, N'd0924639-a876-44f0-9013-9269973548ff', CAST(N'2017-06-26 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1037, N'undefined', NULL, N'tv (3).pdf', N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_undefined\Expense Document\Expense Document_9bc16a75-e47e-4c11-b3d0-3d1a9a27d79b_tv (3).pdf', 12, N'9bc16a75-e47e-4c11-b3d0-3d1a9a27d79b', CAST(N'2017-06-26 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1038, N'undefined', NULL, N'tv (3).pdf', N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_undefined\Expense Document\Expense Document_476e239d-acbd-470a-85ff-41ee3512860c_tv (3).pdf', 12, N'476e239d-acbd-470a-85ff-41ee3512860c', CAST(N'2017-06-26 00:00:00.000' AS DateTime), NULL, 4, 5)
INSERT [dbo].[Document] ([DocumentId], [StudentCode], [StudentName], [FileName], [Description], [Location], [DocumentTypeId], [Guid], [CreatedDateTime], [DownloadedDateTime], [OrganisationId], [CentreId]) VALUES (1039, N'undefined', NULL, N'tv (3).pdf', N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument\NEST Delhi\_undefined\Expense Document\Expense Document_e275c77e-e098-48a7-933e-345d7ac260dd_tv (3).pdf', 12, N'e275c77e-e098-48a7-933e-345d7ac260dd', CAST(N'2017-06-26 00:00:00.000' AS DateTime), NULL, 4, 5)
SET IDENTITY_INSERT [dbo].[Document] OFF
SET IDENTITY_INSERT [dbo].[DocumentType] ON 

INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (2, N'Psychometric', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (6, N'Counselling History', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (9, N'Trainer Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (12, N'Expense Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
INSERT [dbo].[DocumentType] ([DocumentTypeId], [Name], [BasePath], [OrganisationId]) VALUES (15, N'Admission Document', N'c:\inetpub\vhosts\nidantech.org\httpdocs\NidanDocument', 4)
SET IDENTITY_INSERT [dbo].[DocumentType] OFF
SET IDENTITY_INSERT [dbo].[EmergencyContact] ON 

INSERT [dbo].[EmergencyContact] ([EmergencyContactId], [OrganisationId], [PersonnelId], [Relationship], [Title], [Forenames], [Surname], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile]) VALUES (2, 4, 20, N'Friend', N'mr', N'sanjay', N'prajapati', 25, N'krishna Paradise1', NULL, NULL, NULL, NULL, N'98213113344', NULL)
SET IDENTITY_INSERT [dbo].[EmergencyContact] OFF
SET IDENTITY_INSERT [dbo].[Employment] ON 

INSERT [dbo].[Employment] ([EmploymentId], [OrganisationId], [PersonnelId], [StartDate], [EndDate], [TerminationDate], [BuildingId], [ReportsToPersonnelId], [JobTitle], [JobDescription], [EndEmploymentReasonId], [WorkingPatternId], [PublicHolidayPolicyId], [AbsencePolicyId], [CompanyId]) VALUES (2, 4, 20, CAST(N'2016-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-01-06 00:00:00.0000000' AS DateTime2), NULL, 5, NULL, N'Test', N'Test', NULL, 56, 30, 38, 8)
INSERT [dbo].[Employment] ([EmploymentId], [OrganisationId], [PersonnelId], [StartDate], [EndDate], [TerminationDate], [BuildingId], [ReportsToPersonnelId], [JobTitle], [JobDescription], [EndEmploymentReasonId], [WorkingPatternId], [PublicHolidayPolicyId], [AbsencePolicyId], [CompanyId]) VALUES (6, 4, 21, CAST(N'2016-10-10 00:00:00.0000000' AS DateTime2), NULL, NULL, 5, NULL, N'Test', N'Test', NULL, 57, 30, 36, 8)
SET IDENTITY_INSERT [dbo].[Employment] OFF
SET IDENTITY_INSERT [dbo].[EmploymentDepartment] ON 

INSERT [dbo].[EmploymentDepartment] ([EmploymentDepartmentId], [EmploymentId], [DepartmentId], [OrganisationId]) VALUES (1, 2, 24, 4)
INSERT [dbo].[EmploymentDepartment] ([EmploymentDepartmentId], [EmploymentId], [DepartmentId], [OrganisationId]) VALUES (2, 2, 25, 4)
SET IDENTITY_INSERT [dbo].[EmploymentDepartment] OFF
SET IDENTITY_INSERT [dbo].[EmploymentTeam] ON 

INSERT [dbo].[EmploymentTeam] ([EmploymentTeamId], [EmploymentId], [TeamId], [OrganisationId]) VALUES (1, 2, 1, 4)
SET IDENTITY_INSERT [dbo].[EmploymentTeam] OFF
SET IDENTITY_INSERT [dbo].[Enquiry] ON 

INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (127, N'Mr.', N'Rahul', N'Sanjay', N'Parte', 9870754355, 6666666666, N'developer@nidantech.com', CAST(N'2017-05-25' AS Date), 22, N'Dadar', NULL, NULL, NULL, 1, 1, 1, 400709, NULL, NULL, 1, 3, 3, N'Male', 2, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-30' AS Date), N'127', N'Registration', NULL, NULL, NULL, 0, 1, 1, 1, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-01 11:32:41.017' AS DateTime), 2, N'Yes', N'Admission Done', 80, NULL, NULL, 0, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (128, N'Ms.', N'Maya', N'SuraJ', N'Bhosale', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-05-31' AS Date), 25, N'Nahur', NULL, NULL, NULL, 1, 1, 1, 400705, NULL, NULL, 4, 4, 5, N'Female', 6, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'128', NULL, NULL, NULL, NULL, 0, 1, 3, 2, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), 8, N'No', NULL, 70, NULL, NULL, 0, 0, 0, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (129, N'Mr.', N'Saurabh', N'Ram', N'Surve', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-05-31' AS Date), 24, N'Kanjurmarg', NULL, NULL, NULL, 1, 1, 1, 452185, NULL, NULL, 3, 4, 5, N'Male', 7, NULL, NULL, 0, 6, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'129', NULL, NULL, NULL, NULL, 0, 2, 1, 3, 1, 3, NULL, 0, N'Yes', NULL, CAST(N'2017-06-07 08:46:53.983' AS DateTime), 11, N'No', NULL, 60, N'Angular js', NULL, 1, 0, 0, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (130, N'Ms.', N'Pratiksha', N'Rohan', N'Girase', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-08-12' AS Date), 23, N'Kalamboli', NULL, NULL, NULL, 1, 1, 1, 784545, NULL, NULL, 2, 6, 1, N'Female', 9, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'130', N'Registration', NULL, NULL, NULL, 0, 1, 2, 2, 2, 3, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 12:02:17.877' AS DateTime), 5, N'Yes', N'Admission Done', 60, NULL, NULL, 1, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (131, N'Mr.', N'Sachin', N'Somnath', N'Khavade', 9870754355, 6665698556, N'developer@nidantech.com', CAST(N'2017-08-31' AS Date), 23, N'Dombivali', NULL, NULL, NULL, 1, 1, 1, 400708, NULL, NULL, 3, 5, 4, N'Male', 7, NULL, NULL, 0, 6, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'131', N'Registration', NULL, NULL, NULL, 0, 1, 1, 3, 1, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 05:19:49.337' AS DateTime), 2, N'Yes', N'Admission Done', 50, NULL, NULL, 1, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (132, N'Mr.', N'Sandip', N'Raosaheb', N'Vichare', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-05-31' AS Date), 20, N'Bhandup', NULL, NULL, NULL, 1, 1, 1, 400708, NULL, NULL, 5, 1, 5, N'Male', 1, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'132', N'Registration', NULL, NULL, NULL, 0, 1, 3, 2, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-07 08:47:17.003' AS DateTime), 12, N'No', NULL, 70, NULL, NULL, 0, 1, 0, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (133, N'Ms.', N'Jyoti', N'Kalpnath', N'Kodte', 9870754355, NULL, N'developer@nidantech.com', CAST(N'1993-11-05' AS Date), 24, N'Kurla', NULL, NULL, NULL, 1, 1, 1, 400754, NULL, NULL, 5, 1, 5, N'Female', 4, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'133', N'Registration', NULL, NULL, NULL, 0, 1, 2, 2, 1, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-03 00:00:00.000' AS DateTime), 10, N'Yes', N'Admission Done', 60, NULL, NULL, 1, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (134, N'Ms.', N'Sonakshi', N'Pradeep', N'Sinha', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-04-06' AS Date), 25, N'Kamothe', NULL, NULL, NULL, 1, 1, 1, 400709, NULL, NULL, 1, 1, 2, N'Female', 4, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'134', N'Registration', NULL, NULL, NULL, 0, 1, 2, 2, 2, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 06:02:20.467' AS DateTime), 2, N'Yes', N'Admission Done', 70, NULL, NULL, 1, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (135, N'Mr.', N'Soham', N'Mangesh', N'Aaglawe', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-05-20' AS Date), 20, N'Panvel', NULL, NULL, NULL, 1, 1, 1, 400098, NULL, NULL, 2, 1, 2, N'Male', 2, NULL, NULL, 0, 7, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'135', N'Counselling', NULL, NULL, NULL, 0, 2, 3, 1, 15, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 06:03:51.010' AS DateTime), 11, N'No', NULL, 60, N'Angular js', NULL, 1, 0, 0, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (136, N'Mr.', N'Prabhat', N'NIkhil', N'Bansode', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-05-05' AS Date), 25, N'Nalasopara', NULL, NULL, NULL, 1, 1, 1, 565656, NULL, NULL, 1, 2, 2, N'Male', 2, NULL, NULL, 0, 4, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'136', N'Registration', NULL, NULL, NULL, 0, 2, 1, 1, 15, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 06:09:53.547' AS DateTime), 1, N'Yes', N'Admission Done', 60, N'Designing', NULL, 1, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (137, N'Ms.', N'Tanvi', N'Amol', N'Jadhav', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-05-26' AS Date), 22, N'Ghatkopar', NULL, NULL, NULL, 1, 1, 1, 700808, NULL, NULL, 2, 4, 2, N'Female', 2, NULL, NULL, 0, 5, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'137', N'Counselling', NULL, NULL, NULL, 0, 1, 1, 2, 1, 2, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 06:11:34.350' AS DateTime), 4, N'No', NULL, 60, NULL, NULL, 1, 0, 0, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (138, N'Ms.', N'Bhakti', N'Rahul', N'Rane', 9870754355, NULL, N'developer@nidantech.com', CAST(N'2017-09-08' AS Date), 22, N'Vidyavihar', NULL, NULL, NULL, 1, 1, 1, 400708, NULL, NULL, 2, 1, 5, N'Female', 3, NULL, NULL, 0, 5, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'138', N'Registration', NULL, NULL, NULL, 0, 1, 3, 2, 1, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 06:13:07.573' AS DateTime), 1, N'Yes', N'Admission Done', 80, NULL, NULL, 1, 1, 1, 5, 4)
INSERT [dbo].[Enquiry] ([EnquiryId], [Title], [FirstName], [MiddleName], [LastName], [Mobile], [AlternateMobile], [EmailId], [DateOfBirth], [Age], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [GuardianName], [GuardianContactNo], [OccupationId], [ReligionId], [CasteCategoryId], [Gender], [EducationalQualificationId], [YearOfPassOut], [Marks], [IntrestedCourseId], [HowDidYouKnowAboutId], [PreTrainingStatus], [EmploymentStatus], [Promotional], [EnquiryDate], [StudentCode], [EnquiryStatus], [EmployerName], [EmployerContactNo], [EmployerAddress], [AnnualIncome], [SchemeId], [EnquiryTypeId], [StudentTypeId], [SectorId], [BatchTimePreferId], [AppearingQualification], [YearOfExperience], [PlacementNeeded], [Remarks], [FollowUpDate], [PreferredMonthForJoining], [Close], [ClosingRemark], [ConversionProspect], [OtherInterestedCourse], [RemarkByBranchManager], [IsCounsellingDone], [IsRegistrationDone], [IsAdmissionDone], [CentreId], [OrganisationId]) VALUES (139, N'Mr.', N'Sham', N'Pawan', N'Gaitonde', 9870754355, NULL, N'developer@nidantech.com', NULL, 20, N'Shahapur', NULL, NULL, NULL, 1, 1, 1, 400708, NULL, NULL, 3, 4, 2, N'Female', 1, NULL, NULL, 0, 3, N'Fresher', N'UnEmployed', N'Yes', CAST(N'2017-05-31' AS Date), N'139', N'Enquiry', NULL, NULL, NULL, 0, 1, 1, 1, 2, 1, NULL, 0, N'Yes', NULL, CAST(N'2017-06-02 12:27:03.390' AS DateTime), 1, N'No', NULL, 90, NULL, NULL, 0, 0, 0, 5, 4)
SET IDENTITY_INSERT [dbo].[Enquiry] OFF
SET IDENTITY_INSERT [dbo].[EnquiryCourse] ON 

INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (74, 127, 2, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (75, 128, 8, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (76, 130, 5, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (77, 130, 2, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (78, 131, 13, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (79, 132, 8, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (80, 133, 8, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (81, 134, 2, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (82, 135, 42, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (83, 136, 42, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (84, 137, 13, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (85, 138, 8, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (86, 129, 39, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (87, 139, 2, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (88, 128, 2, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (89, 132, 2, 5, 4)
INSERT [dbo].[EnquiryCourse] ([EnquiryCourseId], [EnquiryId], [CourseId], [CentreId], [OrganisationId]) VALUES (90, 129, 8, 5, 4)
SET IDENTITY_INSERT [dbo].[EnquiryCourse] OFF
SET IDENTITY_INSERT [dbo].[EnquiryType] ON 

INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (2, N'Tele-In', 4)
INSERT [dbo].[EnquiryType] ([EnquiryTypeId], [Name], [OrganisationId]) VALUES (3, N'Event', 4)
SET IDENTITY_INSERT [dbo].[EnquiryType] OFF
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (3, N'Seminar', N'Amit Sir', CAST(N'2016-11-05 00:00:00.000' AS DateTime), 1, 4, 1)
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (12, N'Test', NULL, CAST(N'2016-11-05 00:00:00.000' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Event] ([EventId], [Name], [CreatedBy], [CreatedDateTime], [ApprovedBy], [OrganisationId], [CentreId]) VALUES (14, N'Job Fair Mumbai', NULL, NULL, NULL, 4, 1)
SET IDENTITY_INSERT [dbo].[Event] OFF
SET IDENTITY_INSERT [dbo].[EventFunctionType] ON 

INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (1, N'Brain Storming', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (2, N'Planning', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (3, N'Budget', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (4, N'Event Day', 4)
INSERT [dbo].[EventFunctionType] ([EventFunctionTypeId], [Name], [OrganisationId]) VALUES (5, N'Post Event', 4)
SET IDENTITY_INSERT [dbo].[EventFunctionType] OFF
SET IDENTITY_INSERT [dbo].[Expense] ON 

INSERT [dbo].[Expense] ([ExpenseId], [VoucherNumber], [ExpenseHeaderId], [CashMemoNumbers], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [CreatedDate], [CentreId], [OrganisationId], [PersonnelId]) VALUES (5, N'NEST Delhi/June/1', 1, N'A123', CAST(1000.00 AS Decimal(18, 2)), N' One Thousand Rupees Only', N'Sagar Book Depot', N'test', 1, CAST(N'2017-06-27 06:41:29.000' AS DateTime), 5, 4, 30)
INSERT [dbo].[Expense] ([ExpenseId], [VoucherNumber], [ExpenseHeaderId], [CashMemoNumbers], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [CreatedDate], [CentreId], [OrganisationId], [PersonnelId]) VALUES (6, N'NEST Delhi/June/2', 2, N'B101,B120,B135,B150,B174,B181', CAST(918.00 AS Decimal(18, 2)), N' Nine Hundred and Eighteen Rupees Only', N'Bikaner', N'Cake Samosa', 1, CAST(N'2017-06-27 06:45:56.000' AS DateTime), 5, 4, 30)
SET IDENTITY_INSERT [dbo].[Expense] OFF
SET IDENTITY_INSERT [dbo].[ExpenseHeader] ON 

INSERT [dbo].[ExpenseHeader] ([ExpenseHeaderId], [Name], [OrganisationId]) VALUES (1, N'Printing and Stationary', 4)
INSERT [dbo].[ExpenseHeader] ([ExpenseHeaderId], [Name], [OrganisationId]) VALUES (2, N'Office Expense', 4)
SET IDENTITY_INSERT [dbo].[ExpenseHeader] OFF
SET IDENTITY_INSERT [dbo].[ExpenseProject] ON 

INSERT [dbo].[ExpenseProject] ([ExpenseProjectId], [ExpenseId], [ProjectId], [CentreId], [OrganisationId]) VALUES (7, 5, 1, 5, 4)
INSERT [dbo].[ExpenseProject] ([ExpenseProjectId], [ExpenseId], [ProjectId], [CentreId], [OrganisationId]) VALUES (9, 6, 1, 5, 4)
INSERT [dbo].[ExpenseProject] ([ExpenseProjectId], [ExpenseId], [ProjectId], [CentreId], [OrganisationId]) VALUES (10, 6, 2, 5, 4)
SET IDENTITY_INSERT [dbo].[ExpenseProject] OFF
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (1, N'Registration')
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (2, N'Admission')
INSERT [dbo].[FeeType] ([FeeTypeId], [Name]) VALUES (3, N'Installment')
SET IDENTITY_INSERT [dbo].[FollowUp] ON 

INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (50, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 51, NULL, NULL, NULL, N'Ms.', N'Vaidehi', N'Tukaram', N'Sathe', N'Will think and let you know.', NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 5555551515, 22, N'Mobilization', 1515151515, N'/Mobilization/Edit/51', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (51, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 52, NULL, NULL, NULL, N'Mr.', N'Rahul', N'Sanjay', N'Parte', N'Converted To Enquiry', NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 9999999999, 0, N'Mobilization', 6666666666, N'/Mobilization/Edit/52', N'Yes', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (52, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 53, NULL, NULL, NULL, N'Ms.', N'Kavita', N'Soham', N'Surve', N'will call us as needed', NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 9658745125, 2, N'Mobilization', 6998523669, N'/Mobilization/Edit/53', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (53, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 54, NULL, NULL, NULL, N'Mr.', N'Sham', N'Pawan', N'Gaitonde', N'Converted To Enquiry', NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 9870245680, 39, N'Mobilization', NULL, N'/Mobilization/Edit/54', N'Yes', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (54, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 55, NULL, NULL, NULL, N'Mrs.', N'Savita', N'Govind', N'Sharma', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 8702458790, 39, N'Mobilization', NULL, N'/Mobilization/Edit/55', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (55, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 56, NULL, NULL, NULL, N'Ms.', N'Ujwala', N'Pravin', N'Munde', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 7895425481, 39, N'Mobilization', NULL, N'/Mobilization/Edit/56', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (56, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 57, NULL, NULL, NULL, N'Ms.', N'Sangita', N'Shivaji', N'Sonkar', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 8715724520, 39, N'Mobilization', NULL, N'/Mobilization/Edit/57', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (57, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 58, NULL, NULL, NULL, N'Ms.', N'Chitra', N'Dilip', N'Dhwale', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 9714725415, 39, N'Mobilization', NULL, N'/Mobilization/Edit/58', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (58, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 59, NULL, NULL, NULL, N'Mr.', N'Niraj', N'Digambar', N'Sonawane', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 8541256987, 39, N'Mobilization', NULL, N'/Mobilization/Edit/59', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (59, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 60, NULL, NULL, NULL, N'Mrs.', N'Vidhi', N'Ashok', N'Rahate', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 8547854447, 39, N'Mobilization', NULL, N'/Mobilization/Edit/60', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (60, CAST(N'2017-06-01 00:00:00.000' AS DateTime), 61, NULL, NULL, NULL, N'Mr.', N'Ram', N'Sudhkar', N'Yadav', N'will come after next week', NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 8989898989, 2, N'Mobilization', 5656565656, N'/Mobilization/Edit/61', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (61, CAST(N'2017-06-01 00:00:00.000' AS DateTime), NULL, 127, NULL, 23, N'Mr.', N'Rahul', N'Sanjay', N'Parte', NULL, NULL, CAST(N'1917-05-30 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 4, 5, 9999999999, 2, N'Admission', 6666666666, N'/Registration/Edit/23', N'Yes', N'Admission Done', 30)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (62, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 128, 19, NULL, N'Ms.', N'Maya', N'SuraJ', N'Bhosale', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9870754355, 8, N'Counselling', NULL, N'/Counselling/Edit/19', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (63, CAST(N'2017-06-07 08:46:53.983' AS DateTime), NULL, 129, 25, NULL, N'Mr.', N'Saurabh', N'Ram', N'Surve', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9870754355, 2, N'Counselling', NULL, N'/Counselling/Edit/25', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (64, CAST(N'2017-06-02 12:02:17.877' AS DateTime), NULL, 130, 21, 27, N'Ms.', N'Pratiksha', N'Rohan', N'Girase', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9666666666, 2, N'Admission', NULL, N'/Registration/Edit/27', N'Yes', N'Admission Done', 32)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (65, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 131, 28, 29, N'Mr.', N'Sachin', N'Somnath', N'Khavade', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9656985698, 22, N'Admission', 6665698556, N'/Registration/Edit/29', N'Yes', N'Admission Done', 36)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (66, CAST(N'2017-06-07 08:47:17.003' AS DateTime), NULL, 132, 24, 30, N'Mr.', N'Sandip', N'Raosaheb', N'Vichare', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9870754355, 2, N'Registration', NULL, N'/Registration/Edit/30', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (67, CAST(N'2017-06-03 00:00:00.000' AS DateTime), NULL, 133, 26, NULL, N'Ms.', N'Jyoti', N'Kalpnath', N'Kodte', N'will come tomorrow', NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 8569856988, 5, N'Admission', NULL, N'/Registration/Edit/26', N'Yes', N'Admission Done', 33)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (68, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 134, 20, 25, N'Ms.', N'Sonakshi', N'Pradeep', N'Sinha', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9856565656, 5, N'Admission', NULL, N'/Registration/Edit/25', N'Yes', N'Admission Done', 35)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (69, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 135, 22, NULL, N'Mr.', N'Soham', N'Mangesh', N'Aaglawe', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 8956545452, 13, N'Counselling', NULL, N'/Counselling/Edit/22', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (70, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 136, 27, 24, N'Mr.', N'Prabhat', N'NIkhil', N'Bansode', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 8545874558, 2, N'Admission', NULL, N'/Registration/Edit/24', N'Yes', N'Admission Done', 31)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (71, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 137, 23, NULL, N'Ms.', N'Tanvi', N'Amol', N'Jadhav', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 8989898989, 13, N'Counselling', NULL, N'/Counselling/Edit/23', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (72, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 138, 29, 28, N'Ms.', N'Bhakti', N'Rahul', N'Rane', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 8989898989, 22, N'Admission', NULL, N'/Registration/Edit/28', N'Yes', N'Admission Done', 34)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (73, CAST(N'2017-06-02 00:00:00.000' AS DateTime), NULL, 139, NULL, NULL, N'Mr.', N'Sham', N'Pawan', N'Gaitonde', NULL, NULL, CAST(N'1917-05-31 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 4, 5, 9870245680, 0, N'Enquiry', NULL, N'/Enquiry/Edit/139', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (74, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 62, NULL, NULL, NULL, N'Mr.', N'Sham', N'Pawan', N'Gaitonde', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 9870245680, 39, N'Mobilization', NULL, N'/Mobilization/Edit/62', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (75, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 63, NULL, NULL, NULL, N'Mrs.', N'Savita', N'Govind', N'Sharma', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 8702458790, 39, N'Mobilization', NULL, N'/Mobilization/Edit/63', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (76, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 64, NULL, NULL, NULL, N'Ms.', N'Ujwala', N'Pravin', N'Munde', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 7895425481, 39, N'Mobilization', NULL, N'/Mobilization/Edit/64', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (77, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 65, NULL, NULL, NULL, N'Ms.', N'Sangita', N'Shivaji', N'Sonkar', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 8715724520, 39, N'Mobilization', NULL, N'/Mobilization/Edit/65', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (78, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 66, NULL, NULL, NULL, N'Ms.', N'Chitra', N'Dilip', N'Dhwale', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 9714725415, 39, N'Mobilization', NULL, N'/Mobilization/Edit/66', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (79, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 67, NULL, NULL, NULL, N'Mr.', N'Niraj', N'Digambar', N'Sonawane', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 8541256987, 39, N'Mobilization', NULL, N'/Mobilization/Edit/67', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (80, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 68, NULL, NULL, NULL, N'Mrs.', N'Vidhi', N'Ashok', N'Rahate', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 8547854447, 39, N'Mobilization', NULL, N'/Mobilization/Edit/68', N'No', NULL, NULL)
INSERT [dbo].[FollowUp] ([FollowUpId], [FollowUpDateTime], [MobilizationId], [EnquiryId], [CounsellingId], [RegistrationId], [Title], [FirstName], [MiddleName], [LastName], [Remark], [Closed], [ReadDateTime], [CreatedDateTime], [OrganisationId], [CentreId], [Mobile], [IntrestedCourseId], [FollowUpType], [AlternateMobile], [FollowUpURL], [Close], [ClosingRemark], [AdmissionId]) VALUES (81, CAST(N'2017-06-15 00:00:00.000' AS DateTime), 69, NULL, NULL, NULL, N'Mr.', N'Suhas', N'Viraj', N'Pawate', NULL, NULL, CAST(N'1917-06-13 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 4, 5, 7845124574, 39, N'Mobilization', NULL, N'/Mobilization/Edit/69', N'No', NULL, NULL)
SET IDENTITY_INSERT [dbo].[FollowUp] OFF
SET IDENTITY_INSERT [dbo].[FollowUpHistory] ON 

INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (49, 50, N'Mobilization', N'Will think and let you know.', N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (50, 51, N'Mobilization', N'will come with his parents', N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (51, 52, N'Mobilization', N'will call us as needed', N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (52, 53, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (53, 54, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (54, 55, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (55, 56, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (56, 57, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (57, 58, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (58, 59, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (59, 60, N'Mobilization', N'will come after next week', N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (60, 51, N'Mobilization', N'Converted To Enquiry', N'Yes', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (61, 61, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (62, 61, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-01 11:36:20.630' AS DateTime), CAST(N'2017-05-30 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (63, 62, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (64, 63, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (65, 64, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (66, 65, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (67, 66, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (68, 67, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (69, 68, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (70, 69, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (71, 70, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (72, 71, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (73, 72, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (74, 62, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 10:41:30.990' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (75, 68, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:02:38.723' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (76, 64, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:05:18.050' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (77, 69, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:14:10.510' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (78, 71, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:26:33.147' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (79, 66, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:29:02.787' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (80, 63, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:43:40.967' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (81, 67, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:44:00.783' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (82, 70, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:44:17.087' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (83, 65, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:44:40.067' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (84, 72, N'Counselling', NULL, N'No', NULL, CAST(N'2017-06-02 11:44:56.860' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (85, 53, N'Mobilization', N'Converted To Enquiry', N'Yes', NULL, CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (86, 73, N'Enquiry', NULL, N'No', NULL, CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-05-31 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (87, 61, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-06-01 00:00:00.000' AS DateTime), CAST(N'2017-06-01 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (88, 70, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-03 10:29:57.490' AS DateTime), CAST(N'2017-06-01 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (89, 68, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-03 10:32:10.537' AS DateTime), CAST(N'2017-06-01 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (90, 67, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-03 10:37:40.497' AS DateTime), CAST(N'2017-06-01 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (91, 67, N'Registration', N'will come tomorrow', N'No', NULL, CAST(N'2017-06-03 00:00:00.000' AS DateTime), CAST(N'2017-06-02 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (92, 64, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-04 07:11:01.687' AS DateTime), CAST(N'2017-06-02 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (93, 70, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-06-03 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (94, 64, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-06-03 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (95, 67, N'Admission', N'will come tomorrow', N'Yes', N'Admission Done', CAST(N'2017-06-03 00:00:00.000' AS DateTime), CAST(N'2017-06-03 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (96, 72, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-07 06:58:47.463' AS DateTime), CAST(N'2017-06-05 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (97, 72, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-06-05 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (98, 68, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-06-06 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (99, 65, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-12 13:07:48.970' AS DateTime), CAST(N'2017-06-10 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (100, 65, N'Admission', NULL, N'Yes', N'Admission Done', CAST(N'2017-06-02 00:00:00.000' AS DateTime), CAST(N'2017-06-10 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (101, 74, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (102, 75, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (103, 76, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (104, 77, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (105, 78, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (106, 79, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (107, 80, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (108, 81, N'Mobilization', NULL, N'No', NULL, CAST(N'2017-06-15 00:00:00.000' AS DateTime), CAST(N'2017-06-13 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[FollowUpHistory] ([FollowUpHistoryId], [FollowUpId], [FollowUpType], [Remarks], [Close], [ClosingRemarks], [FollowUpDate], [CreatedDate], [CentreId], [OrganisationId]) VALUES (109, 66, N'Registration', NULL, N'No', NULL, CAST(N'2017-06-23 09:40:44.627' AS DateTime), CAST(N'2017-06-21 00:00:00.000' AS DateTime), 5, 4)
SET IDENTITY_INSERT [dbo].[FollowUpHistory] OFF
SET IDENTITY_INSERT [dbo].[Frequency] ON 

INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (1, N'Yearly', 1)
INSERT [dbo].[Frequency] ([FrequencyId], [Name], [Periods]) VALUES (2, N'Quarterly', 2)
SET IDENTITY_INSERT [dbo].[Frequency] OFF
SET IDENTITY_INSERT [dbo].[Holiday] ON 

INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (1, CAST(N'2017-01-14' AS Date), N'Makar Sankranti / Pongal', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (2, CAST(N'2017-01-26' AS Date), N'Republic Day', 4, N'Thursday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (3, CAST(N'2017-02-24' AS Date), N'Maha Shivaratri/Shivaratri', 4, N'Friday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (4, CAST(N'2017-03-13' AS Date), N'Holi', 4, N'Monday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (5, CAST(N'2017-04-04' AS Date), N'Rama Navami', 4, N'Tuesday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (6, CAST(N'2017-04-09' AS Date), N'Mahavir Jayanti', 4, N'Sunday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (7, CAST(N'2017-04-14' AS Date), N'Good Friday/Ambedkar Jayanti', 4, N'Friday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (8, CAST(N'2017-05-10' AS Date), N'Buddha Purnima/Vesak', 4, N'Wednesday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (9, CAST(N'2017-08-07' AS Date), N'Raksha Bandhan (Rakhi)', 4, N'Monday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (10, CAST(N'2017-08-15' AS Date), N'Independence Day/Janmashtami', 4, N'Tuesday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (11, CAST(N'2017-08-25' AS Date), N'Ganesh Chaturthi/Vinayaka Chaturthi', 4, N'Friday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (12, CAST(N'2017-09-02' AS Date), N'Bakr Id/Eid ul-Adha', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (13, CAST(N'2017-09-30' AS Date), N'Dussehra (Maha Navami)', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (14, CAST(N'2017-10-01' AS Date), N'Muharram/Ashura', 4, N'Sunday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (15, CAST(N'2017-10-02' AS Date), N'Mahatma Gandhi Jayanti', 4, N'Monday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (16, CAST(N'2017-10-19' AS Date), N'Diwali/Deepavali', 4, N'Thursday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (17, CAST(N'2017-11-04' AS Date), N'Guru Nanak Jayanti', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (18, CAST(N'2017-12-02' AS Date), N'Milad un-Nabi/Id-e-Milad', 4, N'Saturday', 1)
INSERT [dbo].[Holiday] ([HolidayId], [HolidayDate], [Name], [OrganisationId], [WeekDay], [CentreId]) VALUES (19, CAST(N'2017-12-25' AS Date), N'Christmas', 4, N'Monday', 1)
SET IDENTITY_INSERT [dbo].[Holiday] OFF
SET IDENTITY_INSERT [dbo].[Host] ON 

INSERT [dbo].[Host] ([HostId], [HostName], [OrganisationId]) VALUES (7, N'nidanserver', 4)
SET IDENTITY_INSERT [dbo].[Host] OFF
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] ON 

INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (1, N'Web Site', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (2, N'SMS', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (3, N'Banner', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (4, N'News Paper', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (5, N'Reference', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (6, N'Internet', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (7, N'Pamphlet', 4)
INSERT [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId], [Name], [OrganisationId]) VALUES (8, N'Event', 4)
SET IDENTITY_INSERT [dbo].[HowDidYouKnowAbout] OFF
SET IDENTITY_INSERT [dbo].[Mobilization] ON 

INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (51, 14, 4, N'Ms.', N'Vaidehi', N'Tukaram', N'Sathe', 5, 5555551515, 1515151515, 22, 3, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), N'Will think and let you know.', NULL, N'Vasai', NULL, CAST(N'2017-05-30' AS Date), 1, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (52, 14, 4, N'Mr.', N'Rahul', N'Sanjay', N'Parte', 5, 9999999999, 6666666666, 39, 3, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), N'will come with his parents', NULL, N'Dadar', N'Corel Draw', CAST(N'2017-05-30' AS Date), 3, 30, N'Yes', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (53, 3, 4, N'Ms.', N'Kavita', N'Soham', N'Surve', 5, 9658745125, 6998523669, 2, 7, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), N'will call us as needed', NULL, N'Karjat', NULL, CAST(N'2017-05-30' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (54, 3, 4, N'Mr.', N'Sham', N'Pawan', N'Gaitonde', 5, 9870245680, NULL, 39, 1, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Shahapur', N'Designing', CAST(N'2017-05-29' AS Date), 3, 30, N'Yes', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (55, 3, 4, N'Mrs.', N'Savita', N'Govind', N'Sharma', 5, 8702458790, NULL, 39, 2, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Bhiwandi', N'', CAST(N'2017-05-29' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (56, 3, 4, N'Ms.', N'Ujwala', N'Pravin', N'Munde', 5, 7895425481, NULL, 39, 3, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Airoli', N'', CAST(N'2017-05-29' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (57, 3, 4, N'Ms.', N'Sangita', N'Shivaji', N'Sonkar', 5, 8715724520, NULL, 39, 5, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Rabale', N'', CAST(N'2017-05-29' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (58, 3, 4, N'Ms.', N'Chitra', N'Dilip', N'Dhwale', 5, 9714725415, NULL, 39, 6, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Bhandup', N'', CAST(N'2017-05-29' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (59, 3, 4, N'Mr.', N'Niraj', N'Digambar', N'Sonawane', 5, 8541256987, NULL, 39, 4, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Vikhroli', N'', CAST(N'2017-05-29' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (60, 3, 4, N'Mrs.', N'Vidhi', N'Ashok', N'Rahate', 5, 8547854447, NULL, 39, 6, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), NULL, NULL, N'Matunga', N'', CAST(N'2017-05-29' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (61, 14, 4, N'Mr.', N'Ram', N'Sudhkar', N'Yadav', 5, 8989898989, 5656565656, 2, 7, CAST(N'2017-05-30' AS Date), CAST(N'2017-06-01' AS Date), N'will come after next week', NULL, N'Pavai', NULL, CAST(N'2017-05-30' AS Date), 2, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (62, 14, 4, N'Mr.', N'Sham', N'Pawan', N'Gaitonde', 5, 9870245680, NULL, 39, 1, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Shahapur', N'Designing', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (63, 14, 4, N'Mrs.', N'Savita', N'Govind', N'Sharma', 5, 8702458790, NULL, 39, 2, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Bhiwandi', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (64, 14, 4, N'Ms.', N'Ujwala', N'Pravin', N'Munde', 5, 7895425481, NULL, 39, 3, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Airoli', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (65, 14, 4, N'Ms.', N'Sangita', N'Shivaji', N'Sonkar', 5, 8715724520, NULL, 39, 5, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Rabale', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (66, 14, 4, N'Ms.', N'Chitra', N'Dilip', N'Dhwale', 5, 9714725415, NULL, 39, 6, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Bhandup', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (67, 14, 4, N'Mr.', N'Niraj', N'Digambar', N'Sonawane', 5, 8541256987, NULL, 39, 4, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Vikhroli', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (68, 14, 4, N'Mrs.', N'Vidhi', N'Ashok', N'Rahate', 5, 8547854447, NULL, 39, 6, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Matunga', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
INSERT [dbo].[Mobilization] ([MobilizationId], [EventId], [OrganisationId], [Title], [FirstName], [MiddleName], [LastName], [CentreId], [Mobile], [AlternateMobile], [InterestedCourseId], [QualificationId], [CreatedDate], [FollowUpDate], [Remark], [MobilizerStatus], [StudentLocation], [OtherInterestedCourse], [GeneratedDate], [MobilizationTypeId], [PersonnelId], [Close], [ClosingRemark]) VALUES (69, 14, 4, N'Mr.', N'Suhas', N'Viraj', N'Pawate', 5, 7845124574, NULL, 39, 3, CAST(N'2017-06-13' AS Date), CAST(N'2017-06-15' AS Date), NULL, NULL, N'Badlapur', N'', CAST(N'2017-06-13' AS Date), 3, 30, N'No', NULL)
SET IDENTITY_INSERT [dbo].[Mobilization] OFF
SET IDENTITY_INSERT [dbo].[MobilizationType] ON 

INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (1, N'Walk-In', 4)
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (2, N'Telephonic', 4)
INSERT [dbo].[MobilizationType] ([MobilizationTypeId], [Name], [OrganisationId]) VALUES (3, N'Event', 4)
SET IDENTITY_INSERT [dbo].[MobilizationType] OFF
SET IDENTITY_INSERT [dbo].[Occupation] ON 

INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (1, N'Business', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (2, N'Govt-Employee', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (3, N'Farmer', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (4, N'Doctor', 4)
INSERT [dbo].[Occupation] ([OccupationId], [Name], [OrganisationId]) VALUES (5, N'Other', 4)
SET IDENTITY_INSERT [dbo].[Occupation] OFF
SET IDENTITY_INSERT [dbo].[Organisation] ON 

INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (1, N'Fynn Holdings')
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (2, N'Test Org 2')
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (3, N'Dev UK Organisation')
INSERT [dbo].[Organisation] ([OrganisationId], [Name]) VALUES (4, N'NEST')
SET IDENTITY_INSERT [dbo].[Organisation] OFF
SET IDENTITY_INSERT [dbo].[OtherFee] ON 

INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (4, 1, CAST(N'2017-06-16 05:52:24.467' AS DateTime), 1, 1, N'1234', 50, CAST(10.00 AS Decimal(18, 2)), N'Print out', CAST(500.00 AS Decimal(18, 2)), N' Five Hundred  Rupees Only', N'Sagar Stationary', N'Print out', 1, NULL, NULL, NULL, 5, 4, 30)
INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (5, 1, CAST(N'2017-06-16 06:28:22.600' AS DateTime), 2, 1, N'1234', 50, CAST(10.00 AS Decimal(18, 2)), N'Print out', CAST(500.00 AS Decimal(18, 2)), N' Five Hundred  Rupees Only', N'Sagar Stationary', N'Print out', 1, NULL, NULL, NULL, 5, 4, 30)
INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (6, 1, CAST(N'2017-06-16 06:46:10.337' AS DateTime), 1, 2, N'1234', 1, CAST(100.00 AS Decimal(18, 2)), N'dairy book', CAST(100.00 AS Decimal(18, 2)), N' One Hundred  Rupees Only', N'Sagar Stationary', N'dairy book', 1, NULL, NULL, NULL, 5, 4, 30)
INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (7, 1, CAST(N'2017-06-16 06:46:58.410' AS DateTime), 2, 2, N'1234', 4, CAST(100.00 AS Decimal(18, 2)), N'dairy book', CAST(400.00 AS Decimal(18, 2)), N' Four Hundred  Rupees Only', N'Sagar Stationary', N'dairy book', 1, NULL, NULL, NULL, 5, 4, 30)
INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (8, 1, CAST(N'2017-06-16 06:46:58.410' AS DateTime), 1, 1, N'1234', 1, CAST(10.00 AS Decimal(18, 2)), N'Pen', CAST(10.00 AS Decimal(18, 2)), N'Ten Rupees Only', N'Sagar Stationary', N'Pen', 1, NULL, NULL, NULL, 5, 4, 30)
INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (10, 3, CAST(N'2017-06-20 08:45:09.757' AS DateTime), 1, 2, N'E789', 1, CAST(150.00 AS Decimal(18, 2)), N'Selfie Stick', CAST(150.00 AS Decimal(18, 2)), N' One Hundred  Fifty Rupees Only', N'Croma', N'Selfie Stick', 1, NULL, NULL, NULL, 5, 4, 30)
INSERT [dbo].[OtherFee] ([OtherFeeId], [VoucherId], [CreatedDate], [ProjectId], [ExpenseHeaderId], [CashMemo], [Unit], [Rate], [Description], [DebitAmount], [RupeesInWord], [PaidTo], [Particulars], [PaymentModeId], [PrintDate], [Approved], [ApprovedBy], [CentreId], [OrganisationId], [PersonnelId]) VALUES (11, 3, CAST(N'2017-06-20 08:47:34.273' AS DateTime), 1, 2, N'E789', 1, CAST(20.00 AS Decimal(18, 2)), N'Return Railway Ticket From Sion To Vile Parle', CAST(20.00 AS Decimal(18, 2)), N' Twenty Rupees Only', N'Croma', N'Return Railway Ticket From Sion To Vile Parle', 1, NULL, NULL, NULL, 5, 4, 30)
SET IDENTITY_INSERT [dbo].[OtherFee] OFF
SET IDENTITY_INSERT [dbo].[PaymentMode] ON 

INSERT [dbo].[PaymentMode] ([PaymentModeId], [Name], [OrganisationId]) VALUES (1, N'Cash', 4)
INSERT [dbo].[PaymentMode] ([PaymentModeId], [Name], [OrganisationId]) VALUES (2, N'Cheque', 4)
SET IDENTITY_INSERT [dbo].[PaymentMode] OFF
SET IDENTITY_INSERT [dbo].[Personnel] ON 

INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (20, 4, N'Mr', N'TEst', N'Test', CAST(N'2017-01-04 00:00:00.0000000' AS DateTime2), 24, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'85e8ad13-c28d-480c-992f-78e1abdbc9d2@hr.com', 2, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (21, 4, N'Mr', N'Abc', N'B', CAST(N'2017-01-05 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'e2010454-1065-45db-954f-38b0e4d09e12@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (22, 4, N'Mr', N'x', N'z', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'96a36c2a-8c00-4da8-8477-b5a4ea8af4d3@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (23, 4, N'Mr', N'test1', N'B', CAST(N'2017-01-12 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0a283ac7-1216-4157-9ea0-7cc7c58a4287@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (25, 4, N'Mr', N'Nidan', N'B', CAST(N'2017-02-04 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1011ed35-5c53-487a-9cb9-e90ed2453c13@hr.com', NULL, NULL)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (26, 4, N'Mr', N'ThaneUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'bmthane@nidantech.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (28, 4, N'Mr', N'JabalpurUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ci_jbp@nidantech.com', NULL, 4)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (29, 4, N'Mr', N'NagpurUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ci_ngp@nidantech.com', NULL, 3)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (30, 4, N'Mr', N'DelhiUser', N'B', CAST(N'2017-03-01 00:00:00.0000000' AS DateTime2), 0, N'Address1', NULL, NULL, NULL, N'POST CODE', N'12345678', NULL, N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'bmvaishali@nidantech.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (65, 4, N'Ms.', N'Ragini', N'Singh', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'Shahapur', NULL, NULL, NULL, N'123456', N'12345678', N'9727810545', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ragini@gmail.com', NULL, 1)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (66, 4, N'Ms.', N'Shanaya', N'Subhedar', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'Ghatkopar', NULL, NULL, NULL, N'898985', N'12345678', N'8988888888', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'shanaya@gmail.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (67, 4, N'Mr.', N'Rahul', N'Parte', CAST(N'2017-05-25 00:00:00.0000000' AS DateTime2), 0, N'Dadar', NULL, NULL, NULL, N'400709', N'12345678', N'9999999999', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'rahul@gmail.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (68, 4, N'Mr.', N'Prabhat', N'Bansode', CAST(N'2017-05-05 00:00:00.0000000' AS DateTime2), 0, N'Nalasopara', NULL, NULL, NULL, N'565656', N'12345678', N'8545874558', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'prabhat@gmail.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (69, 4, N'Ms.', N'Pratiksha', N'Girase', CAST(N'2017-08-12 00:00:00.0000000' AS DateTime2), 0, N'Kalamboli', NULL, NULL, NULL, N'784545', N'12345678', N'9666666666', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'pratiksha@gmail.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (70, 4, N'Ms.', N'Jyoti', N'Kodte', CAST(N'1993-11-05 00:00:00.0000000' AS DateTime2), 0, N'Kurla', NULL, NULL, NULL, N'400754', N'12345678', N'8569856988', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'jyoti@gmail.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (71, 4, N'Ms.', N'Bhakti', N'Rane', CAST(N'2017-09-08 00:00:00.0000000' AS DateTime2), 0, N'Vidyavihar', NULL, NULL, NULL, N'400708', N'12345678', N'9870754355', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'developer@nidantech.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (72, 4, N'Ms.', N'Sonakshi', N'Sinha', CAST(N'2017-04-06 00:00:00.0000000' AS DateTime2), 0, N'Kamothe', NULL, NULL, NULL, N'400709', N'12345678', N'9870754355', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'developer@nidantech.com', NULL, 5)
INSERT [dbo].[Personnel] ([PersonnelId], [OrganisationId], [Title], [Forenames], [Surname], [DOB], [CountryId], [Address1], [Address2], [Address3], [Address4], [Postcode], [Telephone], [Mobile], [NINumber], [BankAccountNumber], [BankSortCode], [BankAccountName], [BankAddress1], [BankAddress2], [BankAddress3], [BankAddress4], [BankPostcode], [BankTelephone], [Email], [CurrentEmploymentId], [CentreId]) VALUES (73, 4, N'Mr.', N'Sachin', N'Khavade', CAST(N'2017-08-31 00:00:00.0000000' AS DateTime2), 0, N'Dombivali', NULL, NULL, NULL, N'400708', N'12345678', N'9870754355', N'NZ1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'developer@nidantech.com', NULL, 5)
SET IDENTITY_INSERT [dbo].[Personnel] OFF
SET IDENTITY_INSERT [dbo].[PersonnelAbsenceEntitlement] ON 

INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (1, 4, 20, 29, 3, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 15, 0, 1, 14, 7, 1, 2)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (43, 4, 21, 44, 3, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 5.5, 0, 3, 2.5, 8, 1, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (44, 4, 21, 44, 2, CAST(N'2016-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 2.5, 0, 0, 2.5, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (45, 4, 21, 44, 2, CAST(N'2017-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 3, 0, 1, 2, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (46, 4, 21, 44, NULL, CAST(N'2016-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-03-31 00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, 0, 1, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (47, 4, 21, 45, 3, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 12, 0, 1, 11, 8, 1, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (48, 4, 21, 45, 2, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-06-30 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (49, 4, 21, 45, 2, CAST(N'2017-07-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-09-30 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (50, 4, 21, 45, 2, CAST(N'2017-10-01 00:00:00.0000000' AS DateTime2), CAST(N'2017-12-31 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (51, 4, 21, 45, 2, CAST(N'2018-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 3, 0, 0, 3, 2, 2, 6)
INSERT [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId], [OrganisationId], [PersonnelId], [AbsencePolicyPeriodId], [AbsenceTypeId], [StartDate], [EndDate], [Entitlement], [CarriedOver], [Used], [Remaining], [MaximumCarryForward], [FrequencyId], [EmploymentId]) VALUES (52, 4, 21, 45, NULL, CAST(N'2017-04-01 00:00:00.0000000' AS DateTime2), CAST(N'2018-03-31 00:00:00.0000000' AS DateTime2), 0, 0, 0, 0, 0, 1, 6)
SET IDENTITY_INSERT [dbo].[PersonnelAbsenceEntitlement] OFF
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([ProjectId], [Name], [CentreId], [OrganisationId]) VALUES (1, N'Nest', NULL, 4)
INSERT [dbo].[Project] ([ProjectId], [Name], [CentreId], [OrganisationId]) VALUES (2, N'PMKVY2', NULL, 4)
INSERT [dbo].[Project] ([ProjectId], [Name], [CentreId], [OrganisationId]) VALUES (3, N'NULM', NULL, 4)
INSERT [dbo].[Project] ([ProjectId], [Name], [CentreId], [OrganisationId]) VALUES (4, N'SRLM', NULL, 4)
INSERT [dbo].[Project] ([ProjectId], [Name], [CentreId], [OrganisationId]) VALUES (5, N'CSR', NULL, 4)
SET IDENTITY_INSERT [dbo].[Project] OFF
SET IDENTITY_INSERT [dbo].[PublicHoliday] ON 

INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (18, N'Guru', CAST(N'2017-02-23 00:00:00.0000000' AS DateTime2), 4, 4)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (25, N'Test', CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4, 4)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (42, N'Test1', CAST(N'2016-12-30 00:00:00.0000000' AS DateTime2), 4, 4)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (51, N'Guru', CAST(N'2017-02-23 00:00:00.0000000' AS DateTime2), 4, 30)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (52, N'Test', CAST(N'2016-12-31 00:00:00.0000000' AS DateTime2), 4, 30)
INSERT [dbo].[PublicHoliday] ([PublicHolidayId], [Name], [Date], [OrganisationId], [PublicHolidayPolicyId]) VALUES (53, N'Test1', CAST(N'2016-12-30 00:00:00.0000000' AS DateTime2), 4, 30)
SET IDENTITY_INSERT [dbo].[PublicHoliday] OFF
SET IDENTITY_INSERT [dbo].[PublicHolidayPolicy] ON 

INSERT [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId], [OrganisationId], [Name]) VALUES (4, 4, N'Test Policy')
INSERT [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId], [OrganisationId], [Name]) VALUES (30, 4, N'Test Policy 10:51:30')
SET IDENTITY_INSERT [dbo].[PublicHolidayPolicy] OFF
SET IDENTITY_INSERT [dbo].[Qualification] ON 

INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (1, N'SSC', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (2, N'HSC', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (3, N'Under Graduate', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (4, N'Graduate', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (5, N'Post Graduate', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (6, N'Masters', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (7, N'Diploma', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (9, N'BE', 4)
INSERT [dbo].[Qualification] ([QualificationId], [Name], [OrganisationId]) VALUES (11, N'Others', 4)
SET IDENTITY_INSERT [dbo].[Qualification] OFF
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [Description], [EventFunctionTypeId], [OrganisationId]) VALUES (7, N'test edit', 1, 4)
INSERT [dbo].[Question] ([QuestionId], [Description], [EventFunctionTypeId], [OrganisationId]) VALUES (8, N'What is your name ?', 2, 4)
SET IDENTITY_INSERT [dbo].[Question] OFF
SET IDENTITY_INSERT [dbo].[Registration] ON 

INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (23, N'127', 127, 2, 7, 191, 30, NULL, CAST(N'2017-06-01 11:36:20.630' AS DateTime), 5, 4, 1, CAST(N'2017-05-30 11:36:20.630' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (24, N'136', 136, 2, 7, 197, 31, NULL, NULL, 5, 4, 1, CAST(N'2017-06-01 10:29:57.000' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (25, N'134', 134, 5, 8, 198, 32, NULL, CAST(N'2017-06-03 10:32:10.537' AS DateTime), 5, 4, 1, CAST(N'2017-06-01 10:32:10.537' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (26, N'133', 133, 5, 8, 199, 33, NULL, CAST(N'2017-06-03 10:37:40.497' AS DateTime), 5, 4, 1, CAST(N'2017-06-01 10:37:40.497' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (27, N'130', 130, 2, 11, 200, 34, NULL, CAST(N'2017-06-04 07:11:01.687' AS DateTime), 5, 4, 1, CAST(N'2017-06-02 07:11:01.687' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (28, N'138', 138, 22, 10, 208, 35, NULL, CAST(N'2017-06-07 06:58:47.463' AS DateTime), 5, 4, 1, CAST(N'2017-06-05 06:58:47.463' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (29, N'131', 131, 22, 10, 229, 36, NULL, CAST(N'2017-06-12 13:07:48.970' AS DateTime), 5, 4, 1, CAST(N'2017-06-10 13:07:48.970' AS DateTime))
INSERT [dbo].[Registration] ([RegistrationId], [StudentCode], [EnquiryId], [CourseId], [CourseInstallmentId], [CandidateFeeId], [CandidateInstallmentId], [Remarks], [FollowupDate], [CentreId], [OrganisationId], [IsAdmissionDone], [RegistrationDate]) VALUES (30, N'132', 132, 2, 11, 237, 37, NULL, CAST(N'2017-06-23 09:40:44.627' AS DateTime), 5, 4, 0, CAST(N'2017-06-21 09:40:44.627' AS DateTime))
SET IDENTITY_INSERT [dbo].[Registration] OFF
SET IDENTITY_INSERT [dbo].[Religion] ON 

INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (1, N'Hindu', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (2, N'Muslim', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (3, N'Christen', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (4, N'Sikh', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (5, N'Jain', 4)
INSERT [dbo].[Religion] ([ReligionId], [Name], [OrganisationId]) VALUES (6, N'Buddha', 4)
SET IDENTITY_INSERT [dbo].[Religion] OFF
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (6, N'Delhi Room - 1', 3, 1, NULL, NULL, NULL, NULL, 1, 20, 150, 4, 5)
INSERT [dbo].[Room] ([RoomId], [Description], [Number], [Floor], [OccupiedStartDate], [OccupiedEndDate], [OccupiedStartTime], [OccupiedEndTime], [RoomTypeId], [Capacity], [SquareFeet], [OrganisationId], [CentreId]) VALUES (7, N'NEST Thane Room - 1', 1, 0, NULL, NULL, NULL, NULL, 1, 10, 100, 4, 1)
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[RoomAvailable] ON 

INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (4, 6, 17, N'Monday', 1, 0, N'AM', 3, 0, N'PM', 5, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (5, 6, 17, N'Tuesday', 1, 0, N'AM', 3, 0, N'PM', 5, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (6, 6, 17, N'Wednesday', 1, 0, N'AM', 3, 0, N'PM', 5, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (7, 6, 18, N'Monday', 2, 0, N'PM', 4, 0, N'PM', 5, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (8, 6, 18, N'Tuesday', 2, 0, N'PM', 4, 0, N'PM', 5, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (9, 6, 19, N'Monday', 5, 0, N'PM', 7, 0, N'PM', 5, 4)
INSERT [dbo].[RoomAvailable] ([RoomAvailableId], [RoomId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (10, 6, 19, N'Tuesday', 5, 0, N'PM', 7, 0, N'PM', 5, 4)
SET IDENTITY_INSERT [dbo].[RoomAvailable] OFF
SET IDENTITY_INSERT [dbo].[RoomType] ON 

INSERT [dbo].[RoomType] ([RoomTypeId], [Name], [OrganisationId]) VALUES (1, N'Lab', 4)
INSERT [dbo].[RoomType] ([RoomTypeId], [Name], [OrganisationId]) VALUES (2, N'Theory', 4)
SET IDENTITY_INSERT [dbo].[RoomType] OFF
SET IDENTITY_INSERT [dbo].[Scheme] ON 

INSERT [dbo].[Scheme] ([SchemeId], [Name], [OrganisationId]) VALUES (1, N'Commercial', 4)
INSERT [dbo].[Scheme] ([SchemeId], [Name], [OrganisationId]) VALUES (2, N'Government', 4)
SET IDENTITY_INSERT [dbo].[Scheme] OFF
SET IDENTITY_INSERT [dbo].[Sector] ON 

INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (1, N'Logistics Sector Skill Council', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (2, N'IT', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (3, N'Electronics Sector Skills Council of India', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (4, N'Apparel Made-Ups Home Furnishing Sector Skill Council', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (5, N'Retailers Association''s Skill Council of India', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (6, N'Telecom Sector Skill Council', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (7, N'IT-ITeS Sector Skill Council | NASSCOM', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (8, N'Beauty & Wellness Sector Skill Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (9, N'Life Sciences Sector Skill Development Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (10, N'Others', 4, 1)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (11, N'Logistics Sector Skill Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (13, N'Apparel Made-Ups Home Furnishing Sector Skill Council', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (14, N'Electronics Sector Skills Council of India', 4, 2)
INSERT [dbo].[Sector] ([SectorId], [Name], [OrganisationId], [SchemeId]) VALUES (15, N'Others', 4, 2)
SET IDENTITY_INSERT [dbo].[Sector] OFF
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (102, N'Introduction to Java', N'2 hrs', 1, N'Understanding Java', 7, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (103, N'Features Of Java', N'3 hrs', 2, N'Features', 7, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (104, N'Basic Programs of Java', N'4 hrs', 2, N'Programs', 7, 4)
INSERT [dbo].[Session] ([SessionId], [Name], [Duration], [CourseTypeId], [Description], [SubjectId], [OrganisationId]) VALUES (105, N'Arithmatic Expressions', N'2 hrs', 1, N'Progrtams', 9, 4)
SET IDENTITY_INSERT [dbo].[Session] OFF
SET IDENTITY_INSERT [dbo].[Site] ON 

INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (12, N'PankajSite', 24, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (13, N'PankajSite2', 25, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (14, N'TestSite', 29, 4)
INSERT [dbo].[Site] ([SiteId], [Name], [CountryId], [OrganisationId]) VALUES (16, N'test', 29, 4)
SET IDENTITY_INSERT [dbo].[Site] OFF
SET IDENTITY_INSERT [dbo].[State] ON 

INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (1, N'ANDAMAN & NICOBAR ISLANDS', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (2, N'ANDHRA PRADESH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (3, N'ARUNACHAL PRADESH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (4, N'ASSAM', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (5, N'BIHAR', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (6, N'CHANDIGARH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (7, N'CHATTISGARH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (8, N'DADRA & NAGAR HAVELI', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (9, N'DAMAN & DIU', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (10, N'DELHI', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (11, N'GOA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (12, N'GUJARAT', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (13, N'HARYANA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (14, N'HIMACHAL PRADESH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (15, N'JAMMU & KASHMIR', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (16, N'JHARKHAND', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (17, N'KARNATAKA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (18, N'KERALA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (19, N'LAKSHADWEEP', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (20, N'MADHYA PRADESH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (21, N'MAHARASHTRA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (22, N'MANIPUR', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (23, N'MEGHALAYA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (24, N'MIZORAM', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (25, N'NAGALAND', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (26, N'NULL', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (27, N'ODISHA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (28, N'PONDICHERRY', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (29, N'PUNJAB', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (30, N'RAJASTHAN', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (31, N'SIKKIM', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (32, N'TAMIL NADU', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (33, N'TELANGANA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (34, N'TRIPURA', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (35, N'UTTAR PRADESH', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (36, N'UTTARAKHAND', 4)
INSERT [dbo].[State] ([StateId], [Name], [OrganisationId]) VALUES (37, N'WEST BENGAL', 4)
SET IDENTITY_INSERT [dbo].[State] OFF
SET IDENTITY_INSERT [dbo].[StudentType] ON 

INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (1, N'Student', 4)
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (2, N'Working Professional', 4)
INSERT [dbo].[StudentType] ([StudentTypeId], [Name], [OrganisationId]) VALUES (3, N'Searching For Job', 4)
SET IDENTITY_INSERT [dbo].[StudentType] OFF
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (7, N'J2EE', NULL, NULL, 2, 100, 40, 2, 4)
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (8, N'SQL', NULL, NULL, 2, 100, 40, 2, 4)
INSERT [dbo].[Subject] ([SubjectId], [Name], [CourseId], [TrainerId], [CourseTypeId], [TotalMarks], [PassingMarks], [NoOfAttemptsAllowed], [OrganisationId]) VALUES (9, N'C#', NULL, NULL, 1, 50, 30, 2, 4)
SET IDENTITY_INSERT [dbo].[Subject] OFF
SET IDENTITY_INSERT [dbo].[SubjectCourse] ON 

INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (35, 6, 2, 4)
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (36, 6, 5, 4)
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (37, 7, 5, 4)
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (38, 8, 2, 4)
INSERT [dbo].[SubjectCourse] ([SubjectCourseId], [SubjectId], [CourseId], [OrganisationId]) VALUES (39, 9, 2, 4)
SET IDENTITY_INSERT [dbo].[SubjectCourse] OFF
SET IDENTITY_INSERT [dbo].[SubjectTrainer] ON 

INSERT [dbo].[SubjectTrainer] ([SubjectTrainerId], [SubjectId], [TrainerId], [OrganisationId]) VALUES (3, 9, 4, 4)
SET IDENTITY_INSERT [dbo].[SubjectTrainer] OFF
SET IDENTITY_INSERT [dbo].[Taluka] ON 

INSERT [dbo].[Taluka] ([TalukaId], [Name], [DistrictId], [StateId], [OrganisationId]) VALUES (1, N'Test', 1, 1, 4)
SET IDENTITY_INSERT [dbo].[Taluka] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (1, N'IT Team', 4, 36)
INSERT [dbo].[Team] ([TeamId], [Name], [OrganisationId], [ColourId]) VALUES (3, N'Testing Team', 4, 20)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[Template] ON 

INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (1, N'Registration', N'Registration.html', N'html', 4)
INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (2, N'Installment', N'Installment.html', N'html', 4)
INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (3, N'Admission', N'Admission.html', N'html', 4)
INSERT [dbo].[Template] ([TemplateId], [Name], [FileName], [Type], [OrganisationId]) VALUES (4, N'OtherFee', N'OtherFee.html', N'html', 4)
SET IDENTITY_INSERT [dbo].[Template] OFF
SET IDENTITY_INSERT [dbo].[Trainer] ON 

INSERT [dbo].[Trainer] ([TrainerId], [Title], [FirstName], [MiddleName], [LastName], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [Gender], [AadharNo], [Mobile], [DateOfBirth], [EmailId], [Certified], [CertificationNo], [SectorId], [CourseId], [CentreId], [OrganisationId], [PersonnelId], [CreatedDate]) VALUES (3, N'Ms.', N'Ragini', N'Ramesh', N'Singh', N'Shahapur', NULL, NULL, NULL, 1, 1, 1, N'123456', N'Female', 1231233321313213, 9727810545, CAST(N'0001-01-01' AS Date), N'ragini@gmail.com', N'No', NULL, 2, NULL, 1, 4, 65, CAST(N'2017-05-31' AS Date))
INSERT [dbo].[Trainer] ([TrainerId], [Title], [FirstName], [MiddleName], [LastName], [Address1], [Address2], [Address3], [Address4], [TalukaId], [StateId], [DistrictId], [PinCode], [Gender], [AadharNo], [Mobile], [DateOfBirth], [EmailId], [Certified], [CertificationNo], [SectorId], [CourseId], [CentreId], [OrganisationId], [PersonnelId], [CreatedDate]) VALUES (4, N'Ms.', N'Shanaya', N'Gurunath', N'Subhedar', N'Ghatkopar', NULL, NULL, NULL, 1, 1, 1, N'898985', N'Female', 8888888888888888, 8988888888, CAST(N'0001-01-01' AS Date), N'shanaya@gmail.com', N'No', NULL, 2, NULL, 5, 4, 66, CAST(N'2017-05-31' AS Date))
SET IDENTITY_INSERT [dbo].[Trainer] OFF
SET IDENTITY_INSERT [dbo].[TrainerAvailable] ON 

INSERT [dbo].[TrainerAvailable] ([TrainerAvailableId], [TrainerId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (1, 4, 19, N'Monday', 5, 0, N'PM', 7, 0, N'PM', 5, 4)
INSERT [dbo].[TrainerAvailable] ([TrainerAvailableId], [TrainerId], [BatchId], [Day], [StartTimeHours], [StartTimeMinutes], [StartTimeSpan], [EndTimeHours], [EndTimeMinutes], [EndTimeSpan], [CentreId], [OrganisationId]) VALUES (2, 4, 19, N'Tuesday', 5, 0, N'PM', 7, 0, N'PM', 5, 4)
SET IDENTITY_INSERT [dbo].[TrainerAvailable] OFF
SET IDENTITY_INSERT [dbo].[Voucher] ON 

INSERT [dbo].[Voucher] ([VoucherId], [VoucherNumber], [CashMemo], [CentreId], [OrganisationId], [CreatedDate]) VALUES (1, N'NEST Delhi/June/1', N'1234', 5, 4, CAST(N'2017-06-16 08:45:09.757' AS DateTime))
INSERT [dbo].[Voucher] ([VoucherId], [VoucherNumber], [CashMemo], [CentreId], [OrganisationId], [CreatedDate]) VALUES (3, N'NEST Delhi/June/3', N'E789', 5, 4, CAST(N'2017-06-20 08:45:09.757' AS DateTime))
SET IDENTITY_INSERT [dbo].[Voucher] OFF
SET IDENTITY_INSERT [dbo].[WorkingPattern] ON 

INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (28, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (29, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (30, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (31, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (32, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (33, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (34, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (35, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (36, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (37, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (38, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (39, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (40, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (41, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (42, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (43, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (44, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (45, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (46, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (47, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (48, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (49, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (50, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (51, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (52, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (53, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (54, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (55, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (56, 4)
INSERT [dbo].[WorkingPattern] ([WorkingPatternId], [OrganisationId]) VALUES (57, 4)
SET IDENTITY_INSERT [dbo].[WorkingPattern] OFF
SET IDENTITY_INSERT [dbo].[WorkingPatternDay] ON 

INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (274, 33, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (275, 33, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (276, 33, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (277, 33, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (278, 33, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (279, 33, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (280, 33, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (281, 34, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (282, 34, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (283, 34, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (284, 34, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (285, 34, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (286, 34, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (287, 34, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (288, 35, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (289, 35, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (290, 35, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (291, 35, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (292, 35, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (293, 35, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (294, 35, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (295, 36, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (296, 36, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (297, 36, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (298, 36, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (299, 36, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (300, 36, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (301, 36, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (316, 37, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (317, 37, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (318, 37, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (319, 37, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (320, 37, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (321, 37, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (322, 37, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (323, 38, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (324, 38, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (325, 38, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (326, 38, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (327, 38, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (328, 38, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (329, 38, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (337, 39, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (338, 39, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (339, 39, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (340, 39, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (341, 39, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (342, 39, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (343, 39, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (344, 40, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (345, 40, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (346, 40, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (347, 40, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (348, 40, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (349, 40, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (350, 40, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (351, 41, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (352, 41, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (353, 41, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (354, 41, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (355, 41, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (356, 41, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (357, 41, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (358, 42, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (359, 42, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (360, 42, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (361, 42, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (362, 42, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (363, 42, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (364, 42, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (365, 43, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (366, 43, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (367, 43, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (368, 43, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (369, 43, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (370, 43, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (371, 43, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (372, 44, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (373, 44, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (374, 44, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (375, 44, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (376, 44, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (377, 44, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (378, 44, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (379, 45, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (380, 45, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (381, 45, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (382, 45, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (383, 45, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (384, 45, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (385, 45, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (386, 46, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (387, 46, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (388, 46, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (389, 46, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (390, 46, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (391, 46, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (392, 46, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (393, 47, 1, 1, 1)
GO
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (394, 47, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (395, 47, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (396, 47, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (397, 47, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (398, 47, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (399, 47, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (400, 49, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (401, 48, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (402, 49, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (403, 48, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (404, 48, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (405, 49, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (406, 49, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (407, 48, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (408, 48, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (409, 49, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (410, 48, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (411, 49, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (412, 48, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (413, 49, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (414, 50, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (415, 50, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (416, 50, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (417, 50, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (418, 50, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (419, 50, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (420, 50, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (421, 51, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (422, 51, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (423, 51, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (424, 51, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (425, 51, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (426, 51, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (427, 51, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (428, 52, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (429, 52, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (430, 52, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (431, 52, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (432, 52, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (433, 52, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (434, 52, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (442, 53, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (443, 53, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (444, 53, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (445, 53, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (446, 53, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (447, 53, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (448, 53, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (449, 54, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (450, 54, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (451, 54, 3, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (452, 54, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (453, 54, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (454, 54, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (455, 54, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (456, 55, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (457, 55, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (458, 55, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (459, 55, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (460, 55, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (461, 55, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (462, 55, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (463, 56, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (464, 56, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (465, 56, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (466, 56, 4, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (467, 56, 5, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (468, 56, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (469, 56, 0, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (470, 57, 1, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (471, 57, 2, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (472, 57, 3, 1, 1)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (473, 57, 4, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (474, 57, 5, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (475, 57, 6, 0, 0)
INSERT [dbo].[WorkingPatternDay] ([WorkingPatternDayId], [WorkingPatternId], [DayOfWeek], [AM], [PM]) VALUES (476, 57, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[WorkingPatternDay] OFF
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_AbsenceStatus] FOREIGN KEY([AbsenceStatusId])
REFERENCES [dbo].[AbsenceStatus] ([AbsenceStatusId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_AbsenceStatus]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_Organisation]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_PersonnelAbsenceEntitlement] FOREIGN KEY([PersonnelAbsenceEntitlementId])
REFERENCES [dbo].[PersonnelAbsenceEntitlement] ([PersonnelAbsenceEntitlementId])
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_PersonnelAbsenceEntitlement]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceDay_Absence] FOREIGN KEY([AbsenceId])
REFERENCES [dbo].[Absence] ([AbsenceId])
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [FK_AbsenceDay_Absence]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceDay_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [FK_AbsenceDay_Organisation]
GO
ALTER TABLE [dbo].[AbsencePeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePeriod_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePeriod] CHECK CONSTRAINT [FK_AbsencePeriod_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicy]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicy_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicy] CHECK CONSTRAINT [FK_AbsencePolicy_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicy]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicy_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[AbsencePolicy] CHECK CONSTRAINT [FK_AbsencePolicy_WorkingPattern]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_AbsencePolicy]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_AbsenceType] FOREIGN KEY([AbsenceTypeId])
REFERENCES [dbo].[AbsenceType] ([AbsenceTypeId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_AbsenceType]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_Frequency] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[Frequency] ([FrequencyId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_Frequency]
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyEntitlement_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicyEntitlement] CHECK CONSTRAINT [FK_AbsencePolicyEntitlement_Organisation]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePeriod] FOREIGN KEY([AbsencePeriodId])
REFERENCES [dbo].[AbsencePeriod] ([AbsencePeriodId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePeriod]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_AbsencePolicy]
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod]  WITH CHECK ADD  CONSTRAINT [FK_AbsencePolicyPeriod_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsencePolicyPeriod] CHECK CONSTRAINT [FK_AbsencePolicyPeriod_Organisation]
GO
ALTER TABLE [dbo].[AbsenceType]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceType_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[AbsenceType] CHECK CONSTRAINT [FK_AbsenceType_Colour]
GO
ALTER TABLE [dbo].[AbsenceType]  WITH CHECK ADD  CONSTRAINT [FK_AbsenceType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AbsenceType] CHECK CONSTRAINT [FK_AbsenceType_Organisation]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Batch]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Centre]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Organisation]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Personnel]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Registration] FOREIGN KEY([RegistrationId])
REFERENCES [dbo].[Registration] ([RegistrationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Registration]
GO
ALTER TABLE [dbo].[AreaOfInterest]  WITH CHECK ADD  CONSTRAINT [FK_AreaOfInterest_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[AreaOfInterest] CHECK CONSTRAINT [FK_AreaOfInterest_Organisation]
GO
ALTER TABLE [dbo].[AspNetUsersAlertSchedule]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsersAlertSchedule_Alert1] FOREIGN KEY([AlertId])
REFERENCES [dbo].[Alert] ([AlertId])
GO
ALTER TABLE [dbo].[AspNetUsersAlertSchedule] CHECK CONSTRAINT [FK_AspNetUsersAlertSchedule_Alert1]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Centre]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Organisation]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Personnel]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Centre]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Course]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_CourseInstallment]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Organisation]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Room]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Attendance] FOREIGN KEY([AttendanceId])
REFERENCES [dbo].[Attendance] ([AttendanceId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Attendance]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Batch]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_BatchTrainer] FOREIGN KEY([BatchTrainerId])
REFERENCES [dbo].[BatchTrainer] ([BatchTrainerId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_BatchTrainer]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Centre]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Organisation]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Personnel]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Session] FOREIGN KEY([SessionId])
REFERENCES [dbo].[Session] ([SessionId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Session]
GO
ALTER TABLE [dbo].[BatchAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BatchAttendance_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[BatchAttendance] CHECK CONSTRAINT [FK_BatchAttendance_Subject]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Batch]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Centre]
GO
ALTER TABLE [dbo].[BatchDay]  WITH CHECK ADD  CONSTRAINT [FK_BatchDay_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchDay] CHECK CONSTRAINT [FK_BatchDay_Organisation]
GO
ALTER TABLE [dbo].[BatchTimePrefer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTimePrefer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTimePrefer] CHECK CONSTRAINT [FK_BatchTimePrefer_Organisation]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Batch]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Centre]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Organisation]
GO
ALTER TABLE [dbo].[BatchTrainer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTrainer_Trainer] FOREIGN KEY([TrainerId])
REFERENCES [dbo].[Trainer] ([TrainerId])
GO
ALTER TABLE [dbo].[BatchTrainer] CHECK CONSTRAINT [FK_BatchTrainer_Trainer]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Centre]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Event]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Organisation]
GO
ALTER TABLE [dbo].[Brainstorming]  WITH CHECK ADD  CONSTRAINT [FK_Brainstorming_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Brainstorming] CHECK CONSTRAINT [FK_Brainstorming_Question]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Centre]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Event]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Organisation]
GO
ALTER TABLE [dbo].[Budget]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Budget] CHECK CONSTRAINT [FK_Budget_Question]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Organisation]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Site] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Site] ([SiteId])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Site]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_CandidateInstallment] FOREIGN KEY([CandidateInstallmentId])
REFERENCES [dbo].[CandidateInstallment] ([CandidateInstallmentId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_CandidateInstallment]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Centre]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_FeeType] FOREIGN KEY([FeeTypeId])
REFERENCES [dbo].[FeeType] ([FeeTypeId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_FeeType]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Organisation]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_PaymentMode] FOREIGN KEY([PaymentModeId])
REFERENCES [dbo].[PaymentMode] ([PaymentModeId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_PaymentMode]
GO
ALTER TABLE [dbo].[CandidateFee]  WITH CHECK ADD  CONSTRAINT [FK_CandidateFee_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[CandidateFee] CHECK CONSTRAINT [FK_CandidateFee_Personnel]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Centre]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CandidateInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CandidateInstallment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CandidateInstallment] CHECK CONSTRAINT [FK_CandidateInstallment_Organisation]
GO
ALTER TABLE [dbo].[CasteCategory]  WITH CHECK ADD  CONSTRAINT [FK_CasteCategory_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CasteCategory] CHECK CONSTRAINT [FK_CasteCategory_Organisation]
GO
ALTER TABLE [dbo].[Centre]  WITH CHECK ADD  CONSTRAINT [FK_Centre_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Centre] CHECK CONSTRAINT [FK_Centre_Organisation]
GO
ALTER TABLE [dbo].[CentreCourse]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourse_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreCourse] CHECK CONSTRAINT [FK_CentreCourse_Centre]
GO
ALTER TABLE [dbo].[CentreCourse]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourse_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreCourse] CHECK CONSTRAINT [FK_CentreCourse_Organisation]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_Centre]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_CourseInstallment] FOREIGN KEY([CourseInstallmentId])
REFERENCES [dbo].[CourseInstallment] ([CourseInstallmentId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CentreCourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CentreCourseInstallment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreCourseInstallment] CHECK CONSTRAINT [FK_CentreCourseInstallment_Organisation]
GO
ALTER TABLE [dbo].[CentrePettyCash]  WITH CHECK ADD  CONSTRAINT [FK_CentrePettyCash_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentrePettyCash] CHECK CONSTRAINT [FK_CentrePettyCash_Centre]
GO
ALTER TABLE [dbo].[CentrePettyCash]  WITH CHECK ADD  CONSTRAINT [FK_CentrePettyCash_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentrePettyCash] CHECK CONSTRAINT [FK_CentrePettyCash_Organisation]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Centre]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Organisation]
GO
ALTER TABLE [dbo].[CentreScheme]  WITH CHECK ADD  CONSTRAINT [FK_CentreScheme_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[CentreScheme] CHECK CONSTRAINT [FK_CentreScheme_Scheme]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Centre]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Organisation]
GO
ALTER TABLE [dbo].[CentreSector]  WITH CHECK ADD  CONSTRAINT [FK_CentreSector_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[CentreSector] CHECK CONSTRAINT [FK_CentreSector_Sector]
GO
ALTER TABLE [dbo].[CentreVoucherNumber]  WITH CHECK ADD  CONSTRAINT [FK_CentreVoucherNumber_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[CentreVoucherNumber] CHECK CONSTRAINT [FK_CentreVoucherNumber_Centre]
GO
ALTER TABLE [dbo].[CentreVoucherNumber]  WITH CHECK ADD  CONSTRAINT [FK_CentreVoucherNumber_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CentreVoucherNumber] CHECK CONSTRAINT [FK_CentreVoucherNumber_Organisation]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Colour]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Organisation]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Building] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Building]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Company]
GO
ALTER TABLE [dbo].[CompanyBuilding]  WITH CHECK ADD  CONSTRAINT [FK_CompanyBuilding_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CompanyBuilding] CHECK CONSTRAINT [FK_CompanyBuilding_Organisation]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Centre]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Course] FOREIGN KEY([CourseOfferedId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Course]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Enquiry]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Organisation]
GO
ALTER TABLE [dbo].[Counselling]  WITH CHECK ADD  CONSTRAINT [FK_Counselling_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Counselling] CHECK CONSTRAINT [FK_Counselling_Personnel]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_CourseType] FOREIGN KEY([CourseTypeId])
REFERENCES [dbo].[CourseType] ([CourseTypeId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_CourseType]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Scheme]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Sector]
GO
ALTER TABLE [dbo].[CourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstallment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseInstallment] CHECK CONSTRAINT [FK_CourseInstallment_Course]
GO
ALTER TABLE [dbo].[CourseInstallment]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstallment_CourseInstallment] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseInstallment] CHECK CONSTRAINT [FK_CourseInstallment_CourseInstallment]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Course]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Organisation]
GO
ALTER TABLE [dbo].[CourseSubject]  WITH CHECK ADD  CONSTRAINT [FK_CourseSubject_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[CourseSubject] CHECK CONSTRAINT [FK_CourseSubject_Subject]
GO
ALTER TABLE [dbo].[CourseType]  WITH CHECK ADD  CONSTRAINT [FK_CourseType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[CourseType] CHECK CONSTRAINT [FK_CourseType_Organisation]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK__Departmen__Colou__4F9CCB9E] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK__Departmen__Colou__4F9CCB9E]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Organisation]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_Organisation]
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD  CONSTRAINT [FK_District_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[District] CHECK CONSTRAINT [FK_District_State]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [dbo].[DocumentType] ([DocumentTypeId])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_DocumentType]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Organisation]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Country]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Organisation]
GO
ALTER TABLE [dbo].[EmergencyContact]  WITH CHECK ADD  CONSTRAINT [FK_EmergencyContact_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[EmergencyContact] CHECK CONSTRAINT [FK_EmergencyContact_Personnel]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_AbsencePolicy] FOREIGN KEY([AbsencePolicyId])
REFERENCES [dbo].[AbsencePolicy] ([AbsencePolicyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_AbsencePolicy]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Building1] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Building1]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Company]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Organisation]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_Personnel]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_PublicHolidayPolicy] FOREIGN KEY([PublicHolidayPolicyId])
REFERENCES [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_PublicHolidayPolicy]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_Employment_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_Employment_WorkingPattern]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Department]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Employment]
GO
ALTER TABLE [dbo].[EmploymentDepartment]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentDepartment_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmploymentDepartment] CHECK CONSTRAINT [FK_EmploymentDepartment_Organisation]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Employment]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_Centre]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_ExpenseHeader] FOREIGN KEY([ExpenseHeaderId])
REFERENCES [dbo].[ExpenseHeader] ([ExpenseHeaderId])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_ExpenseHeader]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_Organisation]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_Personnel]
GO
ALTER TABLE [dbo].[ExpenseHeader]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseHeader_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[ExpenseHeader] CHECK CONSTRAINT [FK_ExpenseHeader_Organisation]
GO
ALTER TABLE [dbo].[ExpenseProject]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseProject_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[ExpenseProject] CHECK CONSTRAINT [FK_ExpenseProject_Centre]
GO
ALTER TABLE [dbo].[ExpenseProject]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseProject_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[ExpenseProject] CHECK CONSTRAINT [FK_ExpenseProject_Organisation]
GO
ALTER TABLE [dbo].[FollowUpHistory]  WITH CHECK ADD  CONSTRAINT [FK_FollowUpHistory_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[FollowUpHistory] CHECK CONSTRAINT [FK_FollowUpHistory_Centre]
GO
ALTER TABLE [dbo].[FollowUpHistory]  WITH CHECK ADD  CONSTRAINT [FK_FollowUpHistory_FollowUp] FOREIGN KEY([FollowUpId])
REFERENCES [dbo].[FollowUp] ([FollowUpId])
GO
ALTER TABLE [dbo].[FollowUpHistory] CHECK CONSTRAINT [FK_FollowUpHistory_FollowUp]
GO
ALTER TABLE [dbo].[FollowUpHistory]  WITH CHECK ADD  CONSTRAINT [FK_FollowUpHistory_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[FollowUpHistory] CHECK CONSTRAINT [FK_FollowUpHistory_Organisation]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_Centre]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_ExpenseHeader] FOREIGN KEY([ExpenseHeaderId])
REFERENCES [dbo].[ExpenseHeader] ([ExpenseHeaderId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_ExpenseHeader]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_Organisation]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_PaymentMode] FOREIGN KEY([PaymentModeId])
REFERENCES [dbo].[PaymentMode] ([PaymentModeId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_PaymentMode]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_Personnel]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_Project]
GO
ALTER TABLE [dbo].[OtherFee]  WITH CHECK ADD  CONSTRAINT [FK_OtherFee_Voucher] FOREIGN KEY([VoucherId])
REFERENCES [dbo].[Voucher] ([VoucherId])
GO
ALTER TABLE [dbo].[OtherFee] CHECK CONSTRAINT [FK_OtherFee_Voucher]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Centre]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Organisation]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Batch]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Centre]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Organisation]
GO
ALTER TABLE [dbo].[RoomAvailable]  WITH CHECK ADD  CONSTRAINT [FK_RoomAvailable_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[RoomAvailable] CHECK CONSTRAINT [FK_RoomAvailable_Room]
GO
ALTER TABLE [dbo].[Taluka]  WITH CHECK ADD  CONSTRAINT [FK_Taluka_District] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[District] ([DistrictId])
GO
ALTER TABLE [dbo].[Taluka] CHECK CONSTRAINT [FK_Taluka_District]
GO
ALTER TABLE [dbo].[Taluka]  WITH CHECK ADD  CONSTRAINT [FK_Taluka_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Taluka] CHECK CONSTRAINT [FK_Taluka_Organisation]
GO
ALTER TABLE [dbo].[Taluka]  WITH CHECK ADD  CONSTRAINT [FK_Taluka_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[Taluka] CHECK CONSTRAINT [FK_Taluka_State]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([BatchId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Batch]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Centre]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Organisation]
GO
ALTER TABLE [dbo].[TrainerAvailable]  WITH CHECK ADD  CONSTRAINT [FK_TrainerAvailable_Trainer] FOREIGN KEY([TrainerId])
REFERENCES [dbo].[Trainer] ([TrainerId])
GO
ALTER TABLE [dbo].[TrainerAvailable] CHECK CONSTRAINT [FK_TrainerAvailable_Trainer]
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Voucher] CHECK CONSTRAINT [FK_Voucher_Centre]
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Voucher] CHECK CONSTRAINT [FK_Voucher_Organisation]
GO
/****** Object:  StoredProcedure [dbo].[SearchAdmission]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SearchAdmission]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CandidateName,
BatchName,
TotalFee,
PaidAmount,
PendingAmount,
AdmissionDate,
AdmissionId,
CentreName,
CentreId,
SearchField

	  FROM 
		[AdmissionSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END






GO
/****** Object:  StoredProcedure [dbo].[SearchCandidateFee]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SearchCandidateFee]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CandidateInstallmentId,
CandidateName,
BatchName,
TotalFee,
PaidAmount,
PendingAmount,
AdmissionDate,
AdmissionId,
CentreName,
CentreId,
	  SearchField

	  FROM 
		[CandidateFeeSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END







GO
/****** Object:  StoredProcedure [dbo].[SearchCandidateInstallment]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[SearchCandidateInstallment]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CandidateInstallmentId,
CandidateName,
BatchName,
TotalFee,
PaidAmount,
PendingAmount,
AdmissionDate,
AdmissionId,
CentreName,
CentreId,
	  SearchField

	  FROM 
		[CandidateInstallmentSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END






GO
/****** Object:  StoredProcedure [dbo].[SearchCounselling]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SearchCounselling]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	CounsellingId,
      EnquiryId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      CentreId,
      OrganisationId,
      PersonnelId,
      CourseOfferedId,
      PreferTiming,
      Remarks,
      FollowUpDate,
      RemarkByBranchManager,
      SectorId,
      PsychomatricTest,
      ConversionProspect,
      [Close],
      ClosingRemark,
      RemarkByBm,
      IsRegistrationDone,
	  SearchField

	  FROM 
		[CounsellingSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END




GO
/****** Object:  StoredProcedure [dbo].[SearchCourse]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchCourse]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT
	   CourseId,
      Name,
      OrganisationId,
      SectorId,
      SchemeId,
      CourseTypeId,
      Description,
      Duration,
	SearchField

	  FROM 
		[CourseSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END
GO
/****** Object:  StoredProcedure [dbo].[SearchCourseInstallment]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchCourseInstallment]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	  CourseInstallmentId,
      Name,
      CourseId,
      Fee,
      DownPayment,
      LumpsumAmount,
      OrganisationId,
      NumberOfInstallment,
      CentreId,
      CreatedDate,
	  SearchField

	  FROM 
		[CourseInstallmentSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchEnquiry]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SearchEnquiry]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	EnquiryId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      Mobile,
      AlternateMobile,
      EmailId,
	  DateOfBirth,
      Age,
      Address1,
      Address2,
      Address3,
      Address4,
      TalukaId,
      StateId,
      DistrictId,
      PinCode,
      GuardianName,
      GuardianContactNo,
      OccupationId,
      ReligionId,
      CasteCategoryId,
      Gender,
      EducationalQualificationId,
      YearOfPassOut,
      Marks,
      IntrestedCourseId,
      HowDidYouKnowAboutId,
      PreTrainingStatus,
      EmploymentStatus,
      Promotional,
      EnquiryDate,
      StudentCode,
      EnquiryStatus,
      EmployerName,
      EmployerContactNo,
      EmployerAddress,
      AnnualIncome,
      SchemeId,
      EnquiryTypeId,
      StudentTypeId,
      SectorId,
      BatchTimePreferId,
      AppearingQualification,
      YearOfExperience,
      PlacementNeeded,
      Remarks,
      FollowUpDate,
      PreferredMonthForJoining,
      [Close],
      ClosingRemark,
      ConversionProspect,
      OtherInterestedCourse,
      RemarkByBranchManager,
      IsCounsellingDone,
      IsRegistrationDone,
      IsAdmissionDone,
      CentreId,
      OrganisationId,
	  SearchField

	  FROM 
		[EnquirySearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END



GO
/****** Object:  StoredProcedure [dbo].[SearchFollowUp]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SearchFollowUp]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	FollowUpId,
      FollowUpDateTime,
      MobilizationId,
      EnquiryId,
      CounsellingId,
      RegistrationId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      Remark,
      Closed,
      ReadDateTime,
      CreatedDateTime,
      OrganisationId,
      CentreId,
      Mobile,
      IntrestedCourseId,
      FollowUpType,
      AlternateMobile,
      FollowUpURL,
      [Close],
      ClosingRemark,
	  SearchField

	  FROM 
		[FollowUpSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END


GO
/****** Object:  StoredProcedure [dbo].[SearchMobilization]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SearchMobilization]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

		MobilizationId,
      EventId,
      OrganisationId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      CentreId,
      Mobile,
      AlternateMobile,
      InterestedCourseId,
      QualificationId,
      CreatedDate,
      FollowUpDate,
      Remark,
      MobilizerStatus,
      StudentLocation,
      OtherInterestedCourse,
      GeneratedDate,
      MobilizationTypeId,
      PersonnelId,
      [Close],
      ClosingRemark,
	  SearchField

	  FROM 
		[MobilizationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END



GO
/****** Object:  StoredProcedure [dbo].[SearchPersonnel]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchPersonnel]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	   PersonnelId,
      OrganisationId,
      Title,
      Forenames,
      Surname,
      DOB,
      CountryId,
      Address1,
      Address2,
      Address3,
      Address4,
      Postcode,
      Telephone,
      Mobile,
      NINumber,
      BankAccountNumber,
      BankSortCode,
      BankAccountName,
      BankAddress1,
      BankAddress2,
      BankAddress3,
      BankAddress4,
      BankPostcode,
      BankTelephone,
      Email,
      CurrentEmploymentId,
      CentreId,
	  SearchField

	  FROM 
		[PersonnelSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchRegistration]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SearchRegistration]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	RegistrationId,
      StudentCode,
      EnquiryId,
      CourseId,
      CourseInstallmentId,
      CandidateFeeId,
      CandidateInstallmentId,
      Remarks,
      FollowupDate,
      CentreId,
      OrganisationId,
      IsAdmissionDone,
      RegistrationDate,
	  SearchField

	  FROM 
		[RegistrationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END





GO
/****** Object:  StoredProcedure [dbo].[SearchTrainer]    Script Date: 28/06/2017 05:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SearchTrainer]
	@SearchKeyword nvarchar(100)
AS
BEGIN
	SET @SearchKeyword = REPLACE(@SearchKeyword, ' ', '%')

	SELECT

	TrainerId,
      Title,
      FirstName,
      MiddleName,
      LastName,
      Address1,
      Address2,
      Address3,
      Address4,
      TalukaId,
      StateId,
      DistrictId,
      PinCode,
      Gender,
      AadharNo,
      Mobile,
      DateOfBirth,
      EmailId,
      Certified,
      CertificationNo,
      SectorId,
      CourseId,
      CentreId,
      OrganisationId,
      PersonnelId,
      CreatedDate,
	   SearchField

	  FROM 
		[TrainerSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END




GO
USE [master]
GO
ALTER DATABASE [NidanERP] SET  READ_WRITE 
GO

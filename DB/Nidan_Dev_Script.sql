USE [master]
GO
/****** Object:  Database [NidanProd]    Script Date: 25-02-2017 10:53:37 ******/
CREATE DATABASE [NidanProd]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NidanProd', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SANJAY\MSSQL\DATA\NidanProd.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NidanProd_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SANJAY\MSSQL\DATA\NidanProd_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NidanProd] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NidanProd].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NidanProd] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NidanProd] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NidanProd] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NidanProd] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NidanProd] SET ARITHABORT OFF 
GO
ALTER DATABASE [NidanProd] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NidanProd] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NidanProd] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NidanProd] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NidanProd] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NidanProd] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NidanProd] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NidanProd] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NidanProd] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NidanProd] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NidanProd] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NidanProd] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NidanProd] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NidanProd] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NidanProd] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NidanProd] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NidanProd] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NidanProd] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NidanProd] SET  MULTI_USER 
GO
ALTER DATABASE [NidanProd] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NidanProd] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NidanProd] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NidanProd] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NidanProd] SET DELAYED_DURABILITY = DISABLED 
GO
USE [NidanProd]
GO
/****** Object:  Table [dbo].[Absence]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsenceDay]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsencePeriod]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsencePolicy]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsencePolicyEntitlement]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsencePolicyPeriod]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsenceStatus]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AbsenceType]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Admission]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admission](
	[AdmissionId] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[Salutation] [varchar](50) NOT NULL,
	[FirstName] [varchar](500) NOT NULL,
	[MiddleName] [varchar](500) NOT NULL,
	[LastName] [varchar](500) NOT NULL,
	[Mobile] [bigint] NOT NULL,
	[EmailId] [varchar](500) NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [varchar](50) NOT NULL,
	[CasteCategoryId] [int] NOT NULL,
	[ReligionId] [int] NOT NULL,
	[FatherName] [varchar](500) NULL,
	[FatherMobile] [bigint] NULL,
	[ResidentialNo] [bigint] NULL,
	[PermanentAddress] [varchar](max) NULL,
	[PTaluka] [varchar](500) NULL,
	[PDistrict] [varchar](500) NULL,
	[PState] [varchar](500) NULL,
	[PPinCode] [int] NULL,
	[CommunicationAddress] [varchar](max) NULL,
	[CTaluka] [varchar](500) NULL,
	[CDistrict] [varchar](500) NULL,
	[CState] [varchar](500) NULL,
	[CPinCode] [int] NULL,
	[EducaticationalQualificationId] [int] NOT NULL,
	[ProfessionalQualification] [varchar](500) NULL,
	[TechnicalQualification] [varchar](500) NULL,
	[PreTrainingStatus] [varchar](500) NULL,
	[EmploymentStatus] [varchar](500) NULL,
	[EmployerName] [varchar](500) NULL,
	[EmployerContactNo] [bigint] NULL,
	[EmployerAddress] [varchar](max) NULL,
	[AnnualIncome] [int] NULL,
	[AdmissionDate] [date] NULL,
 CONSTRAINT [PK_Admission] PRIMARY KEY CLUSTERED 
(
	[AdmissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Alert]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AreaOfInterest]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[AspNetUsersAlertSchedule]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Batch]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Batch](
	[BatchId] [int] IDENTITY(1,1) NOT NULL,
	[SchemeId] [int] NOT NULL,
	[CentreId] [int] NULL,
	[OrganisationId] [int] NULL,
	[TrainingType] [varchar](500) NULL,
	[SectorId] [int] NOT NULL,
	[SubSector] [varchar](500) NULL,
	[CourseId] [int] NOT NULL,
	[TrainingHrsPerDay] [int] NOT NULL,
	[BatchStartDate] [date] NOT NULL,
	[BatchEndDate] [date] NOT NULL,
	[PrefferdAssesmentDate] [date] NOT NULL,
	[PersonnelId] [int] NULL,
	[Remarks] [varchar](1000) NULL,
	[CreatedDate] [date] NULL,
 CONSTRAINT [PK_Batch_1] PRIMARY KEY CLUSTERED 
(
	[BatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BatchTimePrefer]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Building]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[CasteCategory]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Centre]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centre](
	[CentreId] [int] IDENTITY(1,1) NOT NULL,
	[CentreCode] [varchar](100) NULL,
	[Name] [varchar](500) NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_Centre] PRIMARY KEY CLUSTERED 
(
	[CentreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Colour]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Company]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[CompanyBuilding]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Counselling]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Counselling](
	[CounsellingId] [int] IDENTITY(1,1) NOT NULL,
	[EnquiryId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CounselledBy] [varchar](500) NULL,
	[CourseOfferedId] [int] NOT NULL,
	[PreferTiming] [varchar](500) NULL,
	[Remarks] [varchar](max) NULL,
	[FollowUpDate] [date] NULL,
	[RemarkByBm] [varchar](max) NULL,
	[Name] [varchar](500) NULL,
 CONSTRAINT [PK_Counselling] PRIMARY KEY CLUSTERED 
(
	[CounsellingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 25-02-2017 10:53:37 ******/
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
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[District]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[District](
	[DistrictId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmergencyContact]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Employment]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[EmploymentDepartment]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[EmploymentTeam]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Enquiry]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EnquiryId] [int] IDENTITY(1,1) NOT NULL,
	[CandidateName] [varchar](500) NOT NULL,
	[ContactNo] [bigint] NOT NULL,
	[EmailId] [varchar](500) NULL,
	[Age] [int] NOT NULL,
	[Address] [varchar](max) NOT NULL,
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
	[Place] [varchar](100) NOT NULL,
	[CounselledBy] [varchar](500) NOT NULL,
	[CourseOfferedId] [int] NOT NULL,
	[PreferTiming] [datetime] NULL,
	[Remarks] [varchar](max) NULL,
	[CentreId] [int] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[FollowUpDate] [date] NULL,
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
	[EnquiryFollowUpDate] [date] NULL,
	[PlacementNeeded] [varchar](100) NULL,
	[WhyEnquiryClosed] [varchar](max) NULL,
	[RemarkByBm] [varchar](max) NULL,
 CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED 
(
	[EnquiryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnquiryType]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Event]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[FollowUp]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FollowUp](
	[FollowUpId] [int] IDENTITY(1,1) NOT NULL,
	[FollowUpDateTime] [datetime] NOT NULL CONSTRAINT [DF_FollowUp_FollowUpDateTime]  DEFAULT (((1900)-(1))-(1)),
	[MobilizationId] [int] NULL,
	[EnquiryId] [int] NULL,
	[Remark] [nvarchar](max) NULL,
	[Closed] [bit] NULL,
	[ReadDateTime] [datetime] NOT NULL CONSTRAINT [DF_FollowUp_ReadDateTime]  DEFAULT (((1900)-(1))-(1)),
	[CreatedDateTime] [datetime] NOT NULL,
	[OrganisationId] [int] NOT NULL,
	[CentreId] [int] NOT NULL,
	[Name] [varchar](500) NULL,
	[Mobile] [bigint] NULL,
	[IntrestedCourseId] [int] NOT NULL,
 CONSTRAINT [PK_FollowUp] PRIMARY KEY CLUSTERED 
(
	[FollowUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Frequency]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Host]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[HowDidYouKnowAbout]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Mobilization]    Script Date: 25-02-2017 10:53:37 ******/
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
	[CentreId] [int] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Mobile] [bigint] NOT NULL,
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
 CONSTRAINT [PK_Mobilization] PRIMARY KEY CLUSTERED 
(
	[MobilizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MobilizationType]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Occupation]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Organisation]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Personnel]    Script Date: 25-02-2017 10:53:37 ******/
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
	[Telephone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NULL,
	[NINumber] [varchar](10) NOT NULL,
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
/****** Object:  Table [dbo].[PersonnelAbsenceEntitlement]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[PublicHoliday]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[PublicHolidayPolicy]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Qualification]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Religion]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Scheme]    Script Date: 25-02-2017 10:53:37 ******/
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
	[SchemeTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Scheme] PRIMARY KEY CLUSTERED 
(
	[SchemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SchemeType]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SchemeType](
	[SchemeTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_SchemeType] PRIMARY KEY CLUSTERED 
(
	[SchemeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sector]    Script Date: 25-02-2017 10:53:37 ******/
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
 CONSTRAINT [PK_Sector] PRIMARY KEY CLUSTERED 
(
	[SectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[State]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[OrganisationId] [int] NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentType]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[Taluka]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Taluka](
	[TalukaId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
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
/****** Object:  Table [dbo].[Team]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[WorkingPattern]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  Table [dbo].[WorkingPatternDay]    Script Date: 25-02-2017 10:53:37 ******/
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
/****** Object:  View [dbo].[EnquirySearchField]    Script Date: 25-02-2017 10:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[EnquirySearchField]
AS 
SELECT 
E.EnquiryId,
E.CandidateName,
E.ContactNo,
E.EmailId,
E.Age,
E.Address,
E.GuardianName,
E.GuardianContactNo,
E.OccupationId,
E.ReligionId,
E.CasteCategoryId,
E.Gender,
E.EducationalQualificationId,
E.YearOFPassOut,
E.Marks,
E.IntrestedCourseId,
E.HowDidYouKnowAboutId,
E.PreTrainingStatus,
E.EmploymentStatus,
E.Promotional,
E.EnquiryDate,
E.Place,
E.CounselledBy,
E.CourseOfferedId,
E.PreferTiming,
E.Remarks,
E.CentreId,
E.OrganisationId,
E.FollowUpDate,
E.EnquiryStatus,
		ISNULL(E.CandidateName, '')+ISNULL(E.CounselledBy, '')+ISNULL(E.EmailId, '')+ISNULL(E.Address, '')+ISNULL(R.Name, '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 101), '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 103), '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 105), '') + ISNULL(CONVERT(varchar,E.EnquiryDate, 126), '') + ISNULL(Q.Name, '') + ISNULL(E.Place, '') + CONVERT(varchar, E.ContactNo ) AS SearchField
FROM 
	Enquiry E  WITH (NOLOCK) left join Religion  R WITH (NOLOCK)
	on E.ReligionId = R.ReligionId join Course C WITH (NOLOCK)
	ON C.CourseId = E.IntrestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = E.EducationalQualificationId



GO
/****** Object:  View [dbo].[MobilizationSearchField]    Script Date: 25-02-2017 10:53:37 ******/
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
		M.Name,
		M.Mobile,
		M.InterestedCourseId,
		M.QualificationId,
		M.CreatedDate,
		M.FollowUpDate,
		M.Remark,
		M.MobilizerStatus,
		p.Forenames[Mobilized By],
		M.StudentLocation,
		M.OtherInterestedCourse,
		M.GeneratedDate,
		ISNULL(M.Name, '')+ISNULL(E.Name, '')+ISNULL(C.Name, '')+ISNULL(p.Forenames, '')+ISNULL(M.StudentLocation, '') + ISNULL(CONVERT(varchar,M.GeneratedDate, 101), '') + ISNULL(CONVERT(varchar,GeneratedDate, 103), '') + ISNULL(CONVERT(varchar,GeneratedDate, 105), '') + ISNULL(CONVERT(varchar,GeneratedDate, 126), '') + ISNULL(StudentLocation, '') + ISNULL(Q.Name, '') + CONVERT(varchar, m.Mobile ) AS SearchField
FROM 
	Mobilization M  WITH (NOLOCK) left join Event E WITH (NOLOCK)
	on M.Eventid = E.EventId join Course C WITH (NOLOCK)
	ON C.CourseId = m.InterestedCourseId join Qualification Q WITH (NOLOCK)
	ON Q.QualificationId = M.QualificationId join Personnel P WITH (NOLOCK)
	on m.PersonnelId=p.PersonnelId





GO
/****** Object:  View [dbo].[PersonnelSearchField]    Script Date: 25-02-2017 10:53:37 ******/
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
	
		ISNULL(Surname, '') + ISNULL(Forenames, '') + ISNULL(Surname, '') + ISNULL(CONVERT(varchar,DOB, 101), '') + ISNULL(CONVERT(varchar,DOB, 103), '') + ISNULL(CONVERT(varchar,DOB, 105), '') + ISNULL(CONVERT(varchar,DOB, 126), '') + ISNULL(EMail, '') + ISNULL(Postcode, '') + ISNULL(Mobile, '') AS SearchField
FROM 
	Personnel  WITH (NOLOCK)




GO
/****** Object:  View [dbo].[UserAuthorisationFilter]    Script Date: 25-02-2017 10:53:37 ******/
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
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_CasteCategory] FOREIGN KEY([CasteCategoryId])
REFERENCES [dbo].[CasteCategory] ([CasteCategoryId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_CasteCategory]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Centre]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Enquiry]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Organisation]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Qualification] FOREIGN KEY([EducaticationalQualificationId])
REFERENCES [dbo].[Qualification] ([QualificationId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Qualification]
GO
ALTER TABLE [dbo].[Admission]  WITH CHECK ADD  CONSTRAINT [FK_Admission_Religion] FOREIGN KEY([ReligionId])
REFERENCES [dbo].[Religion] ([ReligionId])
GO
ALTER TABLE [dbo].[Admission] CHECK CONSTRAINT [FK_Admission_Religion]
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
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Organisation]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Personnel]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Scheme]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_Sector]
GO
ALTER TABLE [dbo].[BatchTimePrefer]  WITH CHECK ADD  CONSTRAINT [FK_BatchTimePrefer_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[BatchTimePrefer] CHECK CONSTRAINT [FK_BatchTimePrefer_Organisation]
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
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Organisation]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Organisation]
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
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Organisation]
GO
ALTER TABLE [dbo].[EmploymentTeam]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentTeam_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([TeamId])
GO
ALTER TABLE [dbo].[EmploymentTeam] CHECK CONSTRAINT [FK_EmploymentTeam_Team]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_BatchTimePrefer] FOREIGN KEY([BatchTimePreferId])
REFERENCES [dbo].[BatchTimePrefer] ([BatchTimePreferId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_BatchTimePrefer]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_CasteCategory] FOREIGN KEY([CasteCategoryId])
REFERENCES [dbo].[CasteCategory] ([CasteCategoryId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_CasteCategory]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Centre]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Course] FOREIGN KEY([IntrestedCourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Course]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Course2] FOREIGN KEY([CourseOfferedId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Course2]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Enquiry] FOREIGN KEY([EnquiryId])
REFERENCES [dbo].[Enquiry] ([EnquiryId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Enquiry]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_EnquiryType] FOREIGN KEY([EnquiryTypeId])
REFERENCES [dbo].[EnquiryType] ([EnquiryTypeId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_EnquiryType]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_HowDidYouKnowAbout] FOREIGN KEY([HowDidYouKnowAboutId])
REFERENCES [dbo].[HowDidYouKnowAbout] ([HowDidYouKnowAboutId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_HowDidYouKnowAbout]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Occupation] FOREIGN KEY([OccupationId])
REFERENCES [dbo].[Occupation] ([OccupationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Occupation]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Organisation]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Qualification] FOREIGN KEY([EducationalQualificationId])
REFERENCES [dbo].[Qualification] ([QualificationId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Qualification]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Religion] FOREIGN KEY([ReligionId])
REFERENCES [dbo].[Religion] ([ReligionId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Religion]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Scheme] FOREIGN KEY([SchemeId])
REFERENCES [dbo].[Scheme] ([SchemeId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Scheme]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_Sector] FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sector] ([SectorId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_Sector]
GO
ALTER TABLE [dbo].[Enquiry]  WITH CHECK ADD  CONSTRAINT [FK_Enquiry_StudentType] FOREIGN KEY([StudentTypeId])
REFERENCES [dbo].[StudentType] ([StudentTypeId])
GO
ALTER TABLE [dbo].[Enquiry] CHECK CONSTRAINT [FK_Enquiry_StudentType]
GO
ALTER TABLE [dbo].[EnquiryType]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[EnquiryType] CHECK CONSTRAINT [FK_EnquiryType_Organisation]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Centre] FOREIGN KEY([CentreId])
REFERENCES [dbo].[Centre] ([CentreId])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Centre]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Organisation]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_Course] FOREIGN KEY([IntrestedCourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_Course]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_FollowUp] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_FollowUp]
GO
ALTER TABLE [dbo].[FollowUp]  WITH CHECK ADD  CONSTRAINT [FK_FollowUp_FollowUp1] FOREIGN KEY([FollowUpId])
REFERENCES [dbo].[FollowUp] ([FollowUpId])
GO
ALTER TABLE [dbo].[FollowUp] CHECK CONSTRAINT [FK_FollowUp_FollowUp1]
GO
ALTER TABLE [dbo].[Host]  WITH CHECK ADD  CONSTRAINT [FK_Host_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Host] CHECK CONSTRAINT [FK_Host_Organisation]
GO
ALTER TABLE [dbo].[HowDidYouKnowAbout]  WITH CHECK ADD  CONSTRAINT [FK_HowDidYouKnowAboutUs_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[HowDidYouKnowAbout] CHECK CONSTRAINT [FK_HowDidYouKnowAboutUs_Organisation]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Centre] FOREIGN KEY([InterestedCourseId])
REFERENCES [dbo].[Course] ([CourseId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Centre]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Event]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Mobilization] FOREIGN KEY([MobilizationId])
REFERENCES [dbo].[Mobilization] ([MobilizationId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Mobilization]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_MobilizationType] FOREIGN KEY([MobilizationTypeId])
REFERENCES [dbo].[MobilizationType] ([MobilizationTypeId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_MobilizationType]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Organisation]
GO
ALTER TABLE [dbo].[Mobilization]  WITH CHECK ADD  CONSTRAINT [FK_Mobilization_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[Mobilization] CHECK CONSTRAINT [FK_Mobilization_Personnel]
GO
ALTER TABLE [dbo].[MobilizationType]  WITH CHECK ADD  CONSTRAINT [FK_MobilizationType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[MobilizationType] CHECK CONSTRAINT [FK_MobilizationType_Organisation]
GO
ALTER TABLE [dbo].[Occupation]  WITH CHECK ADD  CONSTRAINT [FK_Occupation_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Occupation] CHECK CONSTRAINT [FK_Occupation_Organisation]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Employment] FOREIGN KEY([CurrentEmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Employment]
GO
ALTER TABLE [dbo].[Personnel]  WITH CHECK ADD  CONSTRAINT [FK_Personnel_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Personnel] CHECK CONSTRAINT [FK_Personnel_Organisation]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsencePolicyPeriod] FOREIGN KEY([AbsencePolicyPeriodId])
REFERENCES [dbo].[AbsencePolicyPeriod] ([AbsencePolicyPeriodId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsencePolicyPeriod]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsenceType] FOREIGN KEY([AbsenceTypeId])
REFERENCES [dbo].[AbsenceType] ([AbsenceTypeId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_AbsenceType]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Employment] FOREIGN KEY([EmploymentId])
REFERENCES [dbo].[Employment] ([EmploymentId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Employment]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Frequency] FOREIGN KEY([FrequencyId])
REFERENCES [dbo].[Frequency] ([FrequencyId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Frequency]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Organisation]
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement]  WITH CHECK ADD  CONSTRAINT [FK_PersonnelAbsenceEntitlement_Personnel] FOREIGN KEY([PersonnelId])
REFERENCES [dbo].[Personnel] ([PersonnelId])
GO
ALTER TABLE [dbo].[PersonnelAbsenceEntitlement] CHECK CONSTRAINT [FK_PersonnelAbsenceEntitlement_Personnel]
GO
ALTER TABLE [dbo].[PublicHoliday]  WITH CHECK ADD  CONSTRAINT [FK_PublicHoliday_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PublicHoliday] CHECK CONSTRAINT [FK_PublicHoliday_Organisation]
GO
ALTER TABLE [dbo].[PublicHoliday]  WITH CHECK ADD  CONSTRAINT [FK_PublicHoliday_PublicHolidayPolicy] FOREIGN KEY([PublicHolidayPolicyId])
REFERENCES [dbo].[PublicHolidayPolicy] ([PublicHolidayPolicyId])
GO
ALTER TABLE [dbo].[PublicHoliday] CHECK CONSTRAINT [FK_PublicHoliday_PublicHolidayPolicy]
GO
ALTER TABLE [dbo].[PublicHolidayPolicy]  WITH CHECK ADD  CONSTRAINT [FK_PublicHolidayPolicy_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[PublicHolidayPolicy] CHECK CONSTRAINT [FK_PublicHolidayPolicy_Organisation]
GO
ALTER TABLE [dbo].[Qualification]  WITH CHECK ADD  CONSTRAINT [FK_Qualification_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Qualification] CHECK CONSTRAINT [FK_Qualification_Organisation]
GO
ALTER TABLE [dbo].[Religion]  WITH CHECK ADD  CONSTRAINT [FK_Religion_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Religion] CHECK CONSTRAINT [FK_Religion_Organisation]
GO
ALTER TABLE [dbo].[Scheme]  WITH CHECK ADD  CONSTRAINT [FK_Scheme_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Scheme] CHECK CONSTRAINT [FK_Scheme_Organisation]
GO
ALTER TABLE [dbo].[Scheme]  WITH CHECK ADD  CONSTRAINT [FK_Scheme_SchemeType] FOREIGN KEY([SchemeTypeId])
REFERENCES [dbo].[SchemeType] ([SchemeTypeId])
GO
ALTER TABLE [dbo].[Scheme] CHECK CONSTRAINT [FK_Scheme_SchemeType]
GO
ALTER TABLE [dbo].[SchemeType]  WITH CHECK ADD  CONSTRAINT [FK_SchemeType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[SchemeType] CHECK CONSTRAINT [FK_SchemeType_Organisation]
GO
ALTER TABLE [dbo].[Sector]  WITH CHECK ADD  CONSTRAINT [FK_Sector_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Sector] CHECK CONSTRAINT [FK_Sector_Organisation]
GO
ALTER TABLE [dbo].[Site]  WITH CHECK ADD  CONSTRAINT [FK_Site_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Country]
GO
ALTER TABLE [dbo].[Site]  WITH CHECK ADD  CONSTRAINT [FK_Site_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Site] CHECK CONSTRAINT [FK_Site_Organisation]
GO
ALTER TABLE [dbo].[State]  WITH CHECK ADD  CONSTRAINT [FK_State_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_State_Organisation]
GO
ALTER TABLE [dbo].[StudentType]  WITH CHECK ADD  CONSTRAINT [FK_StudentType_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[StudentType] CHECK CONSTRAINT [FK_StudentType_Organisation]
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
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Colour] FOREIGN KEY([ColourId])
REFERENCES [dbo].[Colour] ([ColourId])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Colour]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_Organisation]
GO
ALTER TABLE [dbo].[WorkingPattern]  WITH CHECK ADD  CONSTRAINT [FK_WorkingPattern_Organisation] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[Organisation] ([OrganisationId])
GO
ALTER TABLE [dbo].[WorkingPattern] CHECK CONSTRAINT [FK_WorkingPattern_Organisation]
GO
ALTER TABLE [dbo].[WorkingPatternDay]  WITH CHECK ADD  CONSTRAINT [FK_WorkingPatternDay_WorkingPattern] FOREIGN KEY([WorkingPatternId])
REFERENCES [dbo].[WorkingPattern] ([WorkingPatternId])
GO
ALTER TABLE [dbo].[WorkingPatternDay] CHECK CONSTRAINT [FK_WorkingPatternDay_WorkingPattern]
GO
ALTER TABLE [dbo].[AbsenceDay]  WITH CHECK ADD  CONSTRAINT [CK_AbsenceDay_AMPMDuration] CHECK  ((([AM]=(1) OR [PM]=(1)) AND ([Duration]=(0.5) OR [Duration]=(1))))
GO
ALTER TABLE [dbo].[AbsenceDay] CHECK CONSTRAINT [CK_AbsenceDay_AMPMDuration]
GO
/****** Object:  StoredProcedure [dbo].[SearchEnquiry]    Script Date: 25-02-2017 10:53:37 ******/
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
	CandidateName,
	ContactNo,
	EmailId,
	Age,
	Address,
	GuardianName,
	GuardianContactNo,
	OccupationId,
	ReligionId,
	CasteCategoryId,
	Gender,
	EducationalQualificationId,
	YearOFPassOut,
	Marks,
	IntrestedCourseId,
	HowDidYouKnowAboutId,
	PreTrainingStatus,
	EmploymentStatus,
	Promotional,
	EnquiryDate,
	Place,
	CounselledBy,
	CourseOfferedId,
	PreferTiming,
	Remarks,
	CentreId,
	OrganisationId,
	FollowUpDate,
	EnquiryStatus,
	SearchField
	FROM 
		[EnquirySearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END




GO
/****** Object:  StoredProcedure [dbo].[SearchMobilization]    Script Date: 25-02-2017 10:53:37 ******/
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
		CentreId,
		Name,
		Mobile,
		InterestedCourseId,
		QualificationId,
		CreatedDate,
		FollowUpDate,
		Remark,
		MobilizerStatus,
		[Mobilized By],
		StudentLocation,
		OtherInterestedCourse,
		GeneratedDate,
		SearchField
	FROM 
		[MobilizationSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END




GO
/****** Object:  StoredProcedure [dbo].[SearchPersonnel]    Script Date: 25-02-2017 10:53:37 ******/
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
		SearchField
	FROM 
		[PersonnelSearchField]
	WHERE  
		ISNULL(@SearchKeyword, '') = '' 
	OR  
		SearchField Like '%' + @SearchKeyword + '%' 
  END







GO
USE [master]
GO
ALTER DATABASE [NidanProd] SET  READ_WRITE 
GO

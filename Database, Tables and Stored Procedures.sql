USE [master]
GO
/****** Object:  Database [Attendance]    Script Date: 04/12/2022 1:17:26 pm ******/
CREATE DATABASE [Attendance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Attendance', FILENAME = N'D:\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\Attendance.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Attendance_log', FILENAME = N'D:\SQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\Attendance_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Attendance] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Attendance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Attendance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Attendance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Attendance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Attendance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Attendance] SET ARITHABORT OFF 
GO
ALTER DATABASE [Attendance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Attendance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Attendance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Attendance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Attendance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Attendance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Attendance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Attendance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Attendance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Attendance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Attendance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Attendance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Attendance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Attendance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Attendance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Attendance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Attendance] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Attendance] SET RECOVERY FULL 
GO
ALTER DATABASE [Attendance] SET  MULTI_USER 
GO
ALTER DATABASE [Attendance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Attendance] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Attendance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Attendance] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Attendance] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Attendance] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Attendance', N'ON'
GO
ALTER DATABASE [Attendance] SET QUERY_STORE = OFF
GO
USE [Attendance]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Date] [date] NULL,
	[Checkin] [datetime] NULL,
	[Checkout] [datetime] NULL,
	[ShortLeave] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [int] NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Login]

@Email varchar(50),
@Password varchar(50)

as
begin

if exists ( select * from Employee where Email = @Email and Password=@Password )
begin
	Select 'User Exists' as msg, ID ,Name ,Email, UserType from Employee where Email =@Email and Password=@Password
end
else
begin
	Select 'User Not Exists' as msg, 0 as ID ,'' as Name ,'' as Email, 0 as UserType
end


End
GO
/****** Object:  StoredProcedure [dbo].[MarkAttendance]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[MarkAttendance]    
  @UserID int  
as    
begin    
  
 declare @date date  
 set @date=getdate()  
  
 if exists ( select * from attendance where date = @date and UserID=@UserID and checkout='' )  
 begin  
  update attendance   
  set checkout = getdate() where date = @date and UserID = @UserID and checkout=''  
 end  
  
 if not exists ( select * from attendance where date = @date and UserID=@UserID  )  
 begin  
  insert into attendance ( UserID,date, checkin, Checkout, ShortLeave )  
  values ( @UserID,getdate(), getdate(), '',0 )  
 end  
  
   
    
    
End 
GO
/****** Object:  StoredProcedure [dbo].[MarkShortLeave]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[MarkShortLeave]    
    
@ShortLeave int,
@UserID int
    
as    
begin

    declare @date date
	set @date=getdate()

	update attendance
	set ShortLeave = @ShortLeave where UserID = @UserID and Date=@date

      
End 
GO
/****** Object:  StoredProcedure [dbo].[SelectAllAttendance]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SelectAllAttendance]      
      
as      
begin

		Select employee.Name, * from Attendance left join employee on UserID = Employee.id order by Attendance.ID desc

End 
GO
/****** Object:  StoredProcedure [dbo].[SelectAttendance]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SelectAttendance]  
  
@UserID int
  
as  
begin  
  
if exists ( select * from Attendance where UserID=@UserID )  
begin  
  select * from Attendance where UserID=@UserID order by Checkin desc
end  
--else  
--begin  
 
--end  
  
  
End  
GO
/****** Object:  StoredProcedure [dbo].[Signup]    Script Date: 04/12/2022 1:17:27 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Signup]

@Name varchar(50),
@Email varchar(50),
@Password varchar(50)

as
begin

if exists ( select * from Employee where Email = @Email  )
begin
	Select 'User Already Exists' as msg, 0 as ID ,'' as Name ,'' as Email
end
if not exists ( select * from Employee where Email = @Email )
begin
	insert into employee ( UserType, Name, Email, Password )
	values ( 1,@Name, @Email, @Password )
end
if exists ( select * from Employee where Email = @Email )
begin
	Select 'Account Created Successfully' as msg, 0 as ID ,'' as Name ,'' as Email
end

End
GO
USE [master]
GO
ALTER DATABASE [Attendance] SET  READ_WRITE 
GO

USE [school]
GO
/****** Object:  StoredProcedure [dbo].[HTTP_POST]    Script Date: 2/26/2023 10:47:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[HTTP_POST]( @sUrl varchar(200), @response varchar(8000)
out)
As


Declare
@obj int
,@hr int
,@status int
,@msg varchar(255)


exec @hr = sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT
-- exec @hr = sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT
if @hr <> 0 begin Raiserror('sp_OACreate MSXML2.ServerXMLHttp.3.0
failed', 16,1) return end


exec @hr = sp_OAMethod @obj, 'open', NULL, 'POST', @sUrl, false
if @hr <>0 begin set @msg = 'sp_OAMethod Open failed' goto eh end


exec @hr = sp_OAMethod @obj, 'setRequestHeader', NULL, 'Content-Type',
'application/x-www-form-urlencoded'
if @hr <>0 begin set @msg = 'sp_OAMethod setRequestHeader failed' goto
eh end


exec @hr = sp_OAMethod @obj, send, NULL, ''
if @hr <>0 begin set @msg = 'sp_OAMethod Send failed' goto eh end


exec @hr = sp_OAGetProperty @obj, 'status', @status OUT
if @hr <>0 begin set @msg = 'sp_OAMethod read status failed' goto
eh
end


if @status <> 200 begin set @msg = 'sp_OAMethod http status ' +
str(@status) goto eh end


exec @hr = sp_OAGetProperty @obj, 'responseText', @response OUT
if @hr <>0 begin set @msg = 'sp_OAMethod read response failed' goto
eh end


exec @hr = sp_OADestroy @obj
return
eh:
exec @hr = sp_OADestroy @obj
Raiserror(@msg, 16, 1)
return
GO
/****** Object:  StoredProcedure [dbo].[spSelect_CallWebPage]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSelect_CallWebPage] 
(@URL varchar(1000))

AS

DECLARE @vPointer INT, 
@vResponseText VARCHAR(8000), 
@vStatus INT, 
@vStatusText VARCHAR(200)
EXEC sp_OACreate 'WinHttp.WinHttpRequest.5.1', @vPointer OUTPUT
EXEC sp_OAMethod @vPointer, 'open',NULL, 'GET', @URL,0
EXEC sp_OAMethod @vPointer, 'send'

EXEC sp_OAMethod @vPointer, 'Status', @vStatus OUTPUT
EXEC sp_OAMethod @vPointer, 'StatusText', @vStatusText OUTPUT
EXEC sp_OAMethod @vPointer, 'responseText', @vResponseText OUTPUT
EXEC sp_OADestroy @vPointer
Select @vStatus as Status, @vStatusText as StatusText, @vResponseText as ResponseText --|200 ||OK ||<HTML> Result Trimmed||
GO
/****** Object:  StoredProcedure [dbo].[USP_Addmision_GetApplicantQuota]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 18-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_Addmision_GetApplicantQuota] (
@Id bigint
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select q.* from ad_ApplicantsQuota a
	inner join bs_Quota q on q.Id=a.QuotaId
	where a.ApplicationId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionAdmitCard]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionAdmitCard] (
@Id bigint,
@TransactionId nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	select a.*,cn.ClassName,es.ExamDate,es.ExamStartTime,es.ExamEndTime,y.Year as cYear,c.*,g.GroupName,t.Thana,dst.District, dv.Division,r.Religion from ad_Application a
	inner join ad_Circular c on c.Id=a.CircularId
	inner join bs_Year y on y.Id=c.Year
	inner join bs_ClassName cn on cn.Id=c.ClassId
	inner join bs_Group g on g.Id=a.GroupId
	inner join bs_Thana t on t.Id=a.ThanaId
	inner join bs_District dst on dst.Id=t.DistrictId
	inner join bs_Division dv on dv.Id=dst.DivisionId
	inner join bs_Religion r on r.Id=a.ReligionId
	left outer join ad_ExamSchedule es on es.CircularId=c.Id
	where a.Id=@Id and a.PaymentCode=@TransactionId and a.PaymentStatus=1
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionApplication_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionApplication_GetById] (
@Id bigint
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	select a.*,cn.ClassName,y.Year as cYear,c.*,g.GroupName,t.Thana,dst.District,dst.Id dstId, dv.Division,dv.Id divId,r.Religion from ad_Application a
	inner join ad_Circular c on c.Id=a.CircularId
	inner join bs_Year y on y.Id=c.Year
	inner join bs_ClassName cn on cn.Id=c.ClassId
	inner join bs_Group g on g.Id=a.GroupId
	inner join bs_Thana t on t.Id=a.ThanaId
	inner join bs_District dst on dst.Id=t.DistrictId
	inner join bs_Division dv on dv.Id=dst.DivisionId
	inner join bs_Religion r on r.Id=a.ReligionId
	where a.Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionApplication_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionApplication_Insert] (
@Name nvarchar(100),
@FathersName nvarchar(100),
@MothersName nvarchar(100),
@Mobile nvarchar(20),
@Address nvarchar(150),
@PostOffice nvarchar(50),
@PostCode nvarchar(10),
@ThanaId int,
@MobileHome nvarchar(20),
@GenderId int,
@ReligionId int,
@CircularId bigint,
@DateofBirth date,
@Image  nvarchar(150),
@Email nvarchar(100),
@Nationality nvarchar(50),
@GroupId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from ad_Application where Name=@Name and Mobile=@Mobile
	and FathersName=@FathersName and MothersName=@MothersName and DateofBirth=@DateofBirth)
		begin
			select -1
		end
	else
		begin
			insert into ad_Application( Name, FathersName, MothersName, Mobile, Address, PostOffice, PostCode, ThanaId, MobileHome, GenderId, ReligionId, CircularId, 
                      DateofBirth, Image, Email, Nationality,GroupId)
                      values (@Name, @FathersName, @MothersName, @Mobile, @Address, @PostOffice, @PostCode, @ThanaId, @MobileHome, @GenderId, @ReligionId, @CircularId, 
                      @DateofBirth, @Image, @Email, @Nationality,@GroupId)
                      
			select SCOPE_IDENTITY()
		end
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionApplication_Search]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 08-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionApplication_Search]
(
@Conditions nvarchar(450)
) 
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	set @sql='Select a.*,cl.ClassName,y.Year as cYear,c.ClassId,c.Year,g.GroupName from ad_Application a
	inner join ad_Circular c on c.Id=a.CircularId
	inner join bs_ClassName cl on cl.Id=c.ClassId
	inner join bs_Year y on y.Id=c.Year 
	inner join bs_Group g on g.Id=a.GroupId
	where a.Id>0 '+@Conditions+' order by c.Id desc'
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionApplicationPayment_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 08-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionApplicationPayment_Update] (
@Id bigint,
@PaymentMethodId int,
@TransactionId nvarchar(50),
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Update ad_Application Set PaymentStatus=1, PaymentMethodId=@PaymentMethodId, PayDate=getdate(), PaymentCode=@TransactionId, UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionApplicationReference_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 08-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionApplicationReference_Update] (
@Id bigint,
@Reference nvarchar(150),
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Update ad_Application Set Reference=@Reference,IsSelected=1, UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionCircular_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionCircular_GetAll] 
AS
BEGIN
	SET NOCOUNT ON;
	
	Select 
	c.*,cl.ClassName,y.Year as cYear from ad_Circular c
	inner join bs_ClassName cl on cl.Id=c.ClassId
	inner join bs_Year y on y.Id=c.Year
	where CONVERT(nvarchar,c.EndDate,111) >=CONVERT(nvarchar,GETDATE(),111)
	order by c.Id desc
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionCircular_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionCircular_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Select c.*,cc.ClassName,y.Year as cYear from ad_Circular c
		inner join bs_ClassName cc on cc.Id=c.ClassId
		inner join bs_Year y on y.Id=c.Year
	where c.Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionCircular_GetByYear]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_AddmisionCircular_GetByYear] (
@Year int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Select c.*,cc.ClassName,y.Year as cYear from ad_Circular c
		inner join bs_ClassName cc on cc.Id=c.ClassId
		inner join bs_Year y on y.Id=c.Year
	where c.Year=@Year
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionCircular_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionCircular_Insert] (
@Year int,
@ClassId int,
@StartDate date,
@EndDate date,
@ApplicationFee decimal(18,2),
@Title nvarchar(100),
@Details nvarchar(max),
@Attachment nvarchar(100),
@CreatedBy nvarchar(50),
@Vacancy int,
@AdmissionFee decimal(18,2),
@PassMarks decimal(18,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	insert into ad_Circular(Year, ClassId, StartDate, EndDate, ApplicationFee, Title, Details, Attachment, CreatedBy,Vacancy,AdmissionFee,PassMarks) 
	values (@Year, @ClassId, @StartDate, @EndDate, @ApplicationFee, @Title, @Details, @Attachment, @CreatedBy,@Vacancy,@AdmissionFee,@PassMarks)
	select SCOPE_IDENTITY()
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionCircular_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionCircular_Update] (
@Id int,
@Year int,
@ClassId int,
@StartDate date,
@EndDate date,
@ApplicationFee decimal(18,2),
@Title nvarchar(100),
@Details nvarchar(max),
@UpdatedBy nvarchar(50),
@Vacancy int,
@AdmissionFee decimal(18,2),
@PassMarks decimal(18,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Update ad_Circular Set Year=@Year,PassMarks=@PassMarks,AdmissionFee=@AdmissionFee, ClassId=@ClassId, StartDate=@StartDate, EndDate=@EndDate, ApplicationFee=@ApplicationFee, Title=@Title, Details=@Details, UpdatedBy=@UpdatedBy,UpdateDate=GETDATE(),Vacancy=@Vacancy 
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionMarks_GetApplicant]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 17-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionMarks_GetApplicant] (
@CircularId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Select * from ad_Application a
where a.CircularId=@CircularId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionPayment_ByApplicant]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 08-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_AddmisionPayment_ByApplicant] (
@Id bigint,
@PaymentMethodId int,
@TransactionId nvarchar(50),
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Update ad_Application Set PaymentMethodId=@PaymentMethodId, PayDate=getdate(), PaymentCode=@TransactionId, UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionQuota_Delete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_AddmisionQuota_Delete] (
@ApplicationId bigint
)
	
AS
BEGIN
	SET NOCOUNT ON;
	delete from ad_ApplicantsQuota where ApplicationId=@ApplicationId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionQuota_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionQuota_GetById] (
@ApplicationId bigint
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Select q.* from ad_ApplicantsQuota a
	inner join bs_Quota q on q.Id=a.QuotaId
	where a.ApplicationId=@ApplicationId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionQuota_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionQuota_Insert] (
@QuotaId int,
@ApplicationId bigint
)
	
AS
BEGIN
	SET NOCOUNT ON;
	insert into ad_ApplicantsQuota(ApplicationId,QuotaId) values(@ApplicationId,@QuotaId)

  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionResult]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionResult](
@Conditions nvarchar(450),
@Limit nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	set @sql='Select '+@Limit+' * from ad_Application a inner join ad_Circular c on c.Id=a.CircularId '+@Conditions +' order by a.Marks desc,a.DateofBirth asc'
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionRoutine_GetByYear]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_AddmisionRoutine_GetByYear] (
@Year int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Select * from ad_Circular c
	left outer join ad_ExamSchedule e on e.CircularId=c.Id
where c.Year=@Year and c.ResultPublished=0
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionSelection]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 18-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_AddmisionSelection] (
@Id bigint,
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update ad_Application set IsSelected=1,UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AddmisionStatus_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 18-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_AddmisionStatus_Update] (
@Id bigint,
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update ad_Application set IsAdmitted=1,UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_AdmissionResultPublish]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 08-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_AdmissionResultPublish] (
@Id int,
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Update ad_Circular Set ResultPublished=1, UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APIAccess_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_APIAccess_GetById] (
@UserName nvarchar(100),
@AccessKey nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_APIAccess where UserName=@UserName and AccessKey=@AccessKey
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ApplicationMarks_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 08-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_ApplicationMarks_Update] (
@Id bigint,
@Marks decimal(18,2),
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Update ad_Application Set Marks=@Marks, UpdatedBy=@UpdatedBy,UpdateDate=GETDATE()
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BackupDB]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 20-12-2016
-- =============================================
Create PROCEDURE [dbo].[USP_BackupDB] (
@filepath nvarchar(500)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	backup database school to disk=@filepath
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BloodGroup_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_BloodGroup_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_BloodGroup where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BloodGroup_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_BloodGroup_Insert] (
@BloodGroup nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_BloodGroup where BloodGroup=@BloodGroup)
		begin
			select -1
		end
	else
		begin
			insert into bs_BloodGroup(BloodGroup) values (@BloodGroup)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BloodGroup_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_BloodGroup_Update] (
@Id int,
@BloodGroup nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_BloodGroup set
	BloodGroup=@BloodGroup
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Book_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[USP_Book_GetByCriteria] (
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select lb_Book.*, lb_Category.Category,lb_Country.Country,lb_Language.Language,lb_SubCategory.SubCategory, lb_Edition.Edition,lb_Publisher.Publisher from lb_Book inner join lb_Category 
				on lb_Book.CategoryId=lb_Category.Id inner join lb_SubCategory
				on lb_Book.SubCategoryId=lb_SubCategory.Id inner join lb_Country 
				on lb_Book.CountryId=lb_Country.Id inner join lb_Language
				on lb_Book.LanguageId=lb_Language.Id inner join lb_Publisher
				on lb_Book.PublisherId=lb_Publisher.Id inner join lb_Edition
				on lb_Book.EditionId=lb_Edition.Id where '+@Criteria;
	EXECUTE sp_executesql @sql;

	

	--if(@Criteria<>'')
	--begin
	--   set @sql='select lb_Book.*, lb_Category.Category,lb_Country.Country,lb_Language.Language,lb_SubCategory.SubCategory, lb_Edition.Edition,lb_Publisher.Publisher from lb_Book inner join lb_Category 
	--			on lb_Book.CategoryId=lb_Category.Id inner join lb_SubCategory
	--			on lb_Book.SubCategoryId=lb_SubCategory.Id inner join lb_Country 
	--			on lb_Book.CountryId=lb_Country.Id inner join lb_Language
	--			on lb_Book.LanguageId=lb_Language.Id inner join lb_Publisher
	--			on lb_Book.PublisherId=lb_Publisher.Id inner join lb_Edition
	--			on lb_Book.EditionId=lb_Edition.Id where '+@Criteria 
	--	EXECUTE sp_executesql @sql
	--end
	--else
	--begin
	--set @sql='select lb_Book.*, lb_Category.Category,lb_Country.Country,lb_Language.Language,lb_SubCategory.SubCategory, lb_Edition.Edition,lb_Publisher.Publisher from lb_Book inner join lb_Category 
	--			on lb_Book.CategoryId=lb_Category.Id inner join lb_SubCategory
	--			on lb_Book.SubCategoryId=lb_SubCategory.Id inner join lb_Country 
	--			on lb_Book.CountryId=lb_Country.Id inner join lb_Language
	--			on lb_Book.LanguageId=lb_Language.Id inner join lb_Publisher
	--			on lb_Book.PublisherId=lb_Publisher.Id inner join lb_Edition
	--			on lb_Book.EditionId=lb_Edition.Id'
	--	EXECUTE sp_executesql @sql
	--end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Book_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE    PROCEDURE [dbo].[USP_Book_GetById] (
@Id int
)
	
AS
BEGIN
SET NOCOUNT ON;
	
select lb_Book.*, lb_Category.Category,lb_Country.Country,lb_Language.Language,lb_SubCategory.SubCategory, lb_Edition.Edition,lb_Publisher.Publisher from lb_Book inner join lb_Category 
				on lb_Book.CategoryId=lb_Category.Id inner join lb_SubCategory
				on lb_Book.SubCategoryId=lb_SubCategory.Id inner join lb_Country 
				on lb_Book.CountryId=lb_Country.Id inner join lb_Language
				on lb_Book.LanguageId=lb_Language.Id inner join lb_Publisher
				on lb_Book.PublisherId=lb_Publisher.Id inner join lb_Edition
				on lb_Book.EditionId=lb_Edition.Id 
				where lb_Book.Id=@Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Book_GetByTrackingId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE    PROCEDURE [dbo].[USP_Book_GetByTrackingId] (
@TrackingId varchar(50)
)
	
AS
BEGIN
SET NOCOUNT ON;
	
select lb_Book.*, lb_Category.Category,lb_Country.Country,lb_Language.Language,lb_SubCategory.SubCategory, lb_Edition.Edition,lb_Publisher.Publisher from lb_Book inner join lb_Category 
				on lb_Book.CategoryId=lb_Category.Id inner join lb_SubCategory
				on lb_Book.SubCategoryId=lb_SubCategory.Id inner join lb_Country 
				on lb_Book.CountryId=lb_Country.Id inner join lb_Language
				on lb_Book.LanguageId=lb_Language.Id inner join lb_Publisher
				on lb_Book.PublisherId=lb_Publisher.Id inner join lb_Edition
				on lb_Book.EditionId=lb_Edition.Id 
				where lb_Book.TrackingId=@TrackingId

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Book_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE    PROCEDURE [dbo].[USP_Book_Insert] (

@CategoryId int,
@SubCategoryId int,
@CountryId int,
@PublisherId int,
@LanguageId int,
@EditionId int,
@TrackingId varchar(50),
@Status varchar(50),
@TitleEng varchar(150),
@TitleBan nvarchar(150),
@Author varchar(150),
@ISBN varchar(150),
@VolumeNo int,
@SelfNo int,
@CellNo int,
@KeyWords nvarchar(150),
@Description nvarchar(1000),
@CoverPhoto varchar(150),
@CreatedBy  nvarchar(50)

)	
AS
BEGIN
	SET NOCOUNT ON;
	
insert into lb_Book(CategoryId,SubCategoryId,CountryId,PublisherId,LanguageId,EditionId,
TrackingId,[Status],TitleEng,TitleBan,Author,ISBN,VolumeNo,SelfNo,CellNo,KeyWords,
[Description],CoverPhoto,CreatedBy,CreatedDate) 
values (@CategoryId,@SubCategoryId,@CountryId,@PublisherId,@LanguageId,@EditionId,
@TrackingId,@Status,@TitleEng,@TitleBan,@Author,@ISBN,@VolumeNo,@SelfNo,@CellNo,@KeyWords,
@Description,@CoverPhoto,@CreatedBy,GETDATE())
select SCOPE_IDENTITY()

END

GO
/****** Object:  StoredProcedure [dbo].[USP_Book_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE    PROCEDURE [dbo].[USP_Book_Update] (
@Id int,
@CategoryId int,
@SubCategoryId int,
@CountryId int,
@PublisherId int,
@LanguageId int,
@EditionId int,
@TrackingId varchar(50),
@Status varchar(50),
@TitleEng varchar(150),
@TitleBan nvarchar(150),
@Author varchar(150),
@ISBN varchar(150),
@VolumeNo int,
@SelfNo int,
@CellNo int,
@KeyWords nvarchar(150),
@Description nvarchar(1000),
@CoverPhoto varchar(150),
@UpdatedBy  nvarchar(50)
)
	
AS
BEGIN
--SET NOCOUNT ON;
	
Update lb_Book set CategoryId=@CategoryId,SubCategoryId=@SubCategoryId,CountryId=@CountryId,PublisherId=@PublisherId,LanguageId=@LanguageId,
EditionId=@EditionId,TrackingId=@TrackingId,[Status]=@Status,TitleEng=@TitleEng,TitleBan=@TitleBan,Author=@Author,ISBN=@ISBN,VolumeNo=@VolumeNo,
SelfNo=@SelfNo,CellNo=@CellNo,KeyWords=@KeyWords,Description=@Description,CoverPhoto=@CoverPhoto,UpdatedBy=@UpdatedBy,UpdatedDate=GETDATE() 
where Id=@Id
--select @@ROWCOUNT
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BookLending_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_BookLending_GetByCriteria] (
					
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select lb_Book.TrackingId, lb_Book.TitleEng, Users.UserName, st_Person.NameEng,
	lb_BookLending.* from lb_Book 
	inner join lb_BookLending on lb_Book.BookLendingId = lb_BookLending.Id
	inner join Users on lb_BookLending.UserId = Users.Id
	inner join st_Person on Users.Id = st_Person.UserId where '+@Criteria;
	--print @sql;
	EXECUTE sp_executesql @sql;

END
GO
/****** Object:  StoredProcedure [dbo].[USP_BookLending_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE    PROCEDURE [dbo].[USP_BookLending_GetById] (
@Id int
)
	
AS
BEGIN
SET NOCOUNT ON;
	
select lb_Book.TrackingId, lb_Book.TitleEng, Users.UserName, st_Person.NameEng,
	lb_BookLending.* from lb_Book 
	inner join lb_BookLending on lb_Book.BookLendingId = lb_BookLending.Id
	inner join Users on lb_BookLending.UserId = Users.Id
	inner join st_Person on Users.Id = st_Person.UserId 
	where lb_BookLending.Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_BookLending_GetHistoryByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[USP_BookLending_GetHistoryByCriteria] (
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select lb_Book.TrackingId, lb_Book.TitleEng, Users.UserName, st_Person.NameEng,
	lb_BookLending.* from lb_BookLending 
	inner join lb_Book on lb_BookLending.BookId = lb_Book.Id
	inner join Users on lb_BookLending.UserId = Users.Id
	inner join st_Person on Users.Id = st_Person.UserId where '+@Criteria;
	EXECUTE sp_executesql @sql;

END


GO
/****** Object:  StoredProcedure [dbo].[USP_BookLending_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_BookLending_Insert] (
@BookId int,
@UserId nvarchar(50),
@IssueDate datetime,
@TargatedReturnDate date,
@Status varchar(20),
@Note varchar(100),
@CreatedBy nvarchar(50)
)	
AS
BEGIN
declare @return_status varchar(20)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

BEGIN Tran;	
--Get Validation Data
declare @Status_Old varchar(20);
declare @BookLendingId_Old int;
select @Status_Old = lb_Book.Status, @BookLendingId_Old = lb_Book.BookLendingId from lb_Book where lb_Book.Id = @BookId;

--Check Validation
if(@Status_Old != 'Active')
begin
	set @return_message = @return_message + 'Book status is: '+@Status_Old+'. ';
end

if(@BookLendingId_Old is not null)
begin
	set @return_message = @return_message + 'Book already lent. Lending Reff: '+cast(@BookLendingId_Old as varchar(20))+'.';
end

if(@return_message = '')
begin
	SET NOCOUNT ON;
	INSERT INTO [dbo].[lb_BookLending]
           ([BookId]
           ,[UserId]
           ,[IssueDate]
           ,[TargatedReturnDate]
           ,[Status]
           ,[Note]
           ,[CreatedBy]
           ,[CreatedDateTime])
     VALUES
           (@BookId
           ,@UserId
           ,@IssueDate
           ,@TargatedReturnDate
           ,@Status
           ,@Note
           ,@CreatedBy
           ,GETDATE())
	set @Id = SCOPE_IDENTITY();		
	update lb_Book set BookLendingId = @Id where Id = @BookId;	
	Commit;
	set @return_status = 'yes';
end
else
begin
	rollback;
end


select @return_status as return_status, @Id as id, @return_message as return_message;

END

GO
/****** Object:  StoredProcedure [dbo].[USP_BookLending_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_BookLending_Update] (
@Id int,
@StatusUpdationDate datetime,
@Status varchar(20),
@Note varchar(100),
@UpdatedBy nvarchar(50)
)	
AS
BEGIN
declare @return_status varchar(20)='';
declare @return_message varchar(max)='';

BEGIN TRAN;
--Get Validation Data
declare @Status_Old varchar(20);
declare @BookId int;
select @Status_Old = lb_BookLending.Status, @BookId = lb_BookLending.BookId from lb_BookLending where lb_BookLending.Id = @Id;

--Check Validation
IF(@Status_Old = 'Given' AND @Status = 'Returned')
BEGIN
	update lb_BookLending Set Status = 'Returned',StatusUpdationDate = GETDATE(), Note = @Note, UpdatedBy = @UpdatedBy where lb_BookLending.Id = @Id;
	update lb_Book set BookLendingId = null where Id = @BookId;
	commit;
	set @return_status = 'yes';
END
else IF(@Status_Old = 'Given' AND @Status = 'Lost')
BEGIN
	update lb_BookLending Set Status = 'Lost',StatusUpdationDate = GETDATE(), Note = @Note, UpdatedBy = @UpdatedBy where lb_BookLending.Id = @Id;
	update lb_Book set Status = 'Lost', UpdatedBy=UpdatedBy, UpdatedDate=GETDATE() where Id = @BookId;
	commit;
	set @return_status = 'yes';
END
else IF(@Status_Old='Lost' AND @Status = 'Returned')--Lost>>Receive
BEGIN
	update lb_BookLending Set Status = 'Returned',StatusUpdationDate = GETDATE(), Note = @Note, UpdatedBy = @UpdatedBy where lb_BookLending.Id = @Id;
	update lb_Book set Status = 'Active', BooklendingID = null, UpdatedBy=UpdatedBy, UpdatedDate=GETDATE() where Id = @BookId;
	commit;
	set @return_status = 'yes';
END
else
begin
	rollback;
	set @return_status = 'no';
	set @return_message = 'Shifting status from '''+@Status_Old++''' to ''' +@Status+''' is incompatibale.';
end

select @return_status as return_status, @return_message as return_message;
END

----------------------
--select * from lb_BookLending;
--select * from lb_Book where BookLendingId is not null;

--delete from lb_BookLending;
--update lb_Book set BookLendingId = null, Status = 'Active';
GO
/****** Object:  StoredProcedure [dbo].[USP_Category_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Category_Insert] (
@Category nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from lb_Category where Category=@Category)
		begin
			select -1
		end
	else
		begin
			insert into lb_Category(Category) values (@Category)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Category_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 18-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_Category_Update] (
@Id int,
@Category nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
			Update lb_Category set Category=@Category where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Class_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Class_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_ClassName where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Class_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Class_Insert] (
@Class nvarchar(250),
@ClassNumber int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_ClassName where ClassName=@Class)
		begin
			select -1
		end
	else
		begin
			insert into bs_ClassName(ClassName,ClassNumber) values (@Class,@ClassNumber)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Class_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Class_Update] (
@Id int,
@Class nvarchar(250),
@ClassNumber int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_ClassName set
	ClassName=@Class,ClassNumber=@ClassNumber
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Content_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[USP_Content_GetByCriteria] (
					
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select bs_ClassName.ClassName, bs_Section.Section, bs_Group.GroupName, bs_Shift.Shift,
		bs_Content .* from bs_Content
		left join bs_ClassName on bs_Content.ClassId = bs_ClassName.Id
		left join bs_Section on bs_Content.SectionId = bs_Section.Id
		left join bs_Group on bs_Content.GroupId = bs_Group.Id
		left join bs_Shift on bs_Content.ShiftId = bs_Shift.Id where '+@Criteria;
--print @sql;
	EXECUTE sp_executesql @sql;

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Content_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[USP_Content_GetById] (
@Id int
)
	
AS
BEGIN
SET NOCOUNT ON;
	
select bs_ClassName.ClassName, bs_Section.Section, bs_Group.GroupName, bs_Shift.Shift,
		bs_Content .* from bs_Content
		left join bs_ClassName on bs_Content.ClassId = bs_ClassName.Id
		left join bs_Section on bs_Content.SectionId = bs_Section.Id
		left join bs_Group on bs_Content.GroupId = bs_Group.Id
		left join bs_Shift on bs_Content.ShiftId = bs_Shift.Id
	where bs_Content.Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Content_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE    PROCEDURE [dbo].[USP_Content_Insert] (
@ClassId int,
@GroupId int,
@ShiftId int,
@SectionId int,
@Sequence int,
@Title nvarchar(200),
@FileName nvarchar(200),
@VisibleFileName nvarchar(100),
@YoutubeId nvarchar(200),
@Status nvarchar(10),
@CreatedBy nvarchar(50)
)	
AS
begin
declare @return_status varchar(20)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

begin Tran;	
----Get Validation data
--declare @Status_Old varchar(20);
--declare @BookLendingId_Old int;
--select @Status_Old = lb_Book.Status, @BookLendingId_Old = lb_Book.BookLendingId from lb_Book where lb_Book.Id = @BookId;

----Validation
--if(@Status_Old != 'Active')
--begin
--	set @return_message = @return_message + 'Book status is: '+@Status_Old+'. ';
--end

----Execution
if(@return_message = '')
begin
	begin try
		SET NOCOUNT ON;
		INSERT INTO [dbo].[bs_Content]
		(
		ClassId,
		GroupId,
		ShiftId,
		SectionId,
		Sequence,
		Title,
		FileName,
		VisibleFileName,
		YoutubeId,
		Status,
		CreatedBy,
		CreateDate
		)
		VALUES
		(
		@ClassId,
		@GroupId,
		@ShiftId,
		@SectionId,
		@Sequence,
		@Title,
		@FileName,
		@VisibleFileName,
		@YoutubeId,
		@Status,
		@CreatedBy,
		GETDATE()
		)
		set @Id = SCOPE_IDENTITY();		
		Commit;
		set @return_status = 'yes';
	end try
	begin catch
		rollback;
		set @return_status = 'no';
		set @return_message = ERROR_MESSAGE();
	end catch
end
else
begin
	rollback;
	set @return_status = 'no';
end

select @return_status as return_status, @Id as id, @return_message as return_message;

END

GO
/****** Object:  StoredProcedure [dbo].[USP_Content_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   PROCEDURE [dbo].[USP_Content_Update] (
@Id int,
@StatusUpdationDate datetime,
@Status varchar(20),
@Note varchar(100),
@UpdatedBy nvarchar(50)
)	
AS
BEGIN
declare @return_status varchar(20)='';
declare @return_message varchar(max)='';
begin tran;

--Get Current Info
declare @Status_Old varchar(20);
declare @BookId int;
select @Status_Old = lb_BookLending.Status, @BookId = lb_BookLending.BookId from lb_BookLending where lb_BookLending.Id = @Id;

IF(@Status_Old = 'Given' AND @Status = 'Returned')
BEGIN
	update lb_BookLending Set Status = 'Returned',StatusUpdationDate = GETDATE(), Note = @Note, UpdatedBy = @UpdatedBy where lb_BookLending.Id = @Id;
	update lb_Book set BookLendingId = null where Id = @BookId;
	commit;
	set @return_status = 'yes';
END
else IF(@Status_Old = 'Given' AND @Status = 'Lost')
BEGIN
	update lb_BookLending Set Status = 'Lost',StatusUpdationDate = GETDATE(), Note = @Note, UpdatedBy = @UpdatedBy where lb_BookLending.Id = @Id;
	update lb_Book set Status = 'Lost', UpdatedBy=UpdatedBy, UpdatedDate=GETDATE() where Id = @BookId;
	commit;
	set @return_status = 'yes';
END
else IF(@Status_Old='Lost' AND @Status = 'Returned')--Lost>>Receive
BEGIN
	update lb_BookLending Set Status = 'Returned',StatusUpdationDate = GETDATE(), Note = @Note, UpdatedBy = @UpdatedBy where lb_BookLending.Id = @Id;
	update lb_Book set Status = 'Active', BooklendingID = null, UpdatedBy=UpdatedBy, UpdatedDate=GETDATE() where Id = @BookId;
	commit;
	set @return_status = 'yes';
END
else
begin
	rollback;
	set @return_status = 'no';
	set @return_message = 'Shifting status from '''+@Status_Old++''' to ''' +@Status+''' is incompatibale.';
end

select @return_status as return_status, @return_message as return_message;
END

----------------------
--select * from lb_BookLending;
--select * from lb_Book where BookLendingId is not null;

--delete from lb_BookLending;
--update lb_Book set BookLendingId = null, Status = 'Active';
GO
/****** Object:  StoredProcedure [dbo].[USP_Country_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Country_Insert] (
@Country nvarchar(150)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from lb_Country where Country=@Country)
		begin
			select -1
		end
	else
		begin
			insert into lb_Country(Country) values (@Country)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Dashboard_GetStudent]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Dashboard_GetStudent] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select COUNT(Id) as Student from ss_Student
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Dashboard_GetTeacher]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Dashboard_GetTeacher] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select COUNT(Id) as Teacher from tr_Teacher
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Dashboard_GetUniqueVisit]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Dashboard_GetUniqueVisit] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select Value from bs_UniqueVisit
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Dashboard_UpdateUniqueVisit]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Dashboard_UpdateUniqueVisit] 
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_UniqueVisit set Value=Value+1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Delete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Delete] (
@Table nvarchar(250),
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);
	declare @_Id nvarchar(max);
	set @_Id= Cast(@Id as nvarchar(50))

	--delete from bs_Year where Id=4

	set @sql='delete from '+@Table+' where Id ='+ @_Id
	EXEC ( @sql )
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteIncomplete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 03-10-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_DeleteIncomplete] 
	
AS
BEGIN
	SET NOCOUNT ON;
	
	Delete from Users where Id not in(Select u.id from Users u inner join st_Person p on p.UserId=u.Id 
	inner join ss_Student s on s.PersonId=p.Id where u.RoleId=4) and RoleId=4

	Delete from ss_Student where PersonId not in(Select p.Id from st_Person p 
	inner join ss_Student s on s.PersonId=p.Id)
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Designation_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Designation_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Designation where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Designation_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Designation_Insert] (
@Designation nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Designation where Designation=@Designation)
		begin
			select -1
		end
	else
		begin
			insert into bs_Designation(Designation) values (@Designation)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Designation_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Designation_Update] (
@Id int,
@Designation nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Designation set
	Designation=@Designation
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_District_GetByDivisionId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_District_GetByDivisionId] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_District where DivisionId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_District_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_District_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_District where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_District_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_District_Insert] (
@DivisionId int,
@District nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_District where District=@District and DivisionId=@DivisionId)
		begin
			select -1
		end
	else
		begin
			insert into bs_District(DivisionId,District) values (@DivisionId,@District)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_District_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_District_Update] (
@Id int,
@DivisionId int,
@District nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_District set
	District=@District,
	DivisionId=@DivisionId
	where Id=@Id  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Division_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Division_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Division where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Division_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Division_Insert] (
@Division nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Division where Division=@Division)
		begin
			select -1
		end
	else
		begin
			insert into bs_Division(Division) values (@Division)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Division_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Division_Update] (
@Id int,
@Division nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Division set
	Division=@Division
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Edition_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Edition_Insert] (
@Edition nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from lb_Edition where Edition=@Edition)
		begin
			select -1
		end
	else
		begin
	INSERT INTO lb_Edition(Edition) VALUES
	(@Edition)
	select SCOPE_IDENTITY()
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Edition_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Edition_Update] (
@Id int,
@Edition nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update lb_Edition set 
	Edition=@Edition
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Email_ConfigurationUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Email_ConfigurationUpdate] (
	@DisplayName nvarchar(256),
	@DisplayEmail nvarchar(256),
	@ReplyToEmail nvarchar(256),
	@SMTPServer nvarchar(250),
	@Port int,
	@SSL bit,
	@Authentication bit,
	@UserName nvarchar(250),
	@Password nvarchar(250),
	@IsEmailSent bit
)
AS
BEGIN
	update [EmailConfig]
           set [DisplayName]=@DisplayName
           ,[DisplayEmail]=@DisplayEmail
           ,[ReplyToEmail]=@ReplyToEmail
           ,[SMTPServer]=@SMTPServer
           ,Port=@Port
           ,[SSL]=@SSL
           ,[Authentication]=@Authentication
           ,UserName=@UserName
           ,[Password]=@Password
           ,IsEmailSent=@IsEmailSent
END
GO
/****** Object:  StoredProcedure [dbo].[USP_EmailTemplate_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_EmailTemplate_GetById] (
	@Id int
)
AS
BEGIN
	SELECT * FROM EmailTemplate
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_EmailTemplate_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_EmailTemplate_Insert] (
	@TemplateName nvarchar(2500),
	@Subject	nvarchar(200),
	@Variables nvarchar(500),
	@Body	Text
)
AS
BEGIN
if exists(select * from EmailTemplate where TemplateName=@TemplateName)
	select -1
else
Begin
	
	INSERT INTO EmailTemplate
	(
		TemplateName,
		Subject,
		Variables,
		Body
	)
	VALUES
	(
		@TemplateName,
		@Subject,
		@Variables,
		@Body
	)
	select SCOPE_IDENTITY()
end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_EmailTemplate_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_EmailTemplate_Update] (
	@Id int,
	@Variables nvarchar(500),
	@TemplateName	nvarchar(100),
	@Subject	nvarchar(100),
	@Body Text
)
AS
BEGIN
	
	UPDATE EmailTemplate SET
	TemplateName= @TemplateName	,
	Variables=@Variables,
	Subject= @Subject,
	Body=@Body
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExamType_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_ExamType_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_ExamType
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExamType_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_ExamType_Insert] (
@Name nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_ExamType where ExamType=@Name)
		begin
			select -1
		end
	else
		begin
			insert into bs_ExamType(ExamType) values (@Name)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExamType_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_ExamType_Update] (
@Id int,
@Name nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_ExamType set ExamType=@Name
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExpenseCategory_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_ExpenseCategory_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from acc_ExpenseCategory where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExpenseCategory_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_ExpenseCategory_Insert] (
@Category nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from acc_ExpenseCategory where ExpenseCategory=@Category)
		begin
			select -1
		end
	else
		begin
			insert into acc_ExpenseCategory(ExpenseCategory) values (@Category)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExpenseCategory_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_ExpenseCategory_Update] (
@Id int,
@Category nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update acc_ExpenseCategory set
	ExpenseCategory=@Category
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FailSystem_GetByClassAndGroupId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_FailSystem_GetByClassAndGroupId] (
@ClassId int,
@GroupId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select rs_FailSystem.*,bs_ClassName.Id as ClassId,bs_ClassName.ClassName,bs_Group.Id,bs_Group.GroupName,
	case when er_SubjectToClass.PaperNo=0 
			 then
				SubjectName
			 else
			   SubjectName+'-'+ cast(PaperNo as nvarchar(50)) end as SubjectName
	from rs_FailSystem 
	inner join er_SubjectToClass on rs_FailSystem.SubjectToClassId=er_SubjectToClass.Id
	inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id
	inner join bs_ClassName on er_SubjectToClass.ClassId=bs_ClassName.Id
	inner join bs_Group on er_SubjectToClass.GroupId=bs_Group.Id
	where ClassId=@ClassId and GroupId=@GroupId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FailSystem_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_FailSystem_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select rs_FailSystem.*,bs_ClassName.Id as ClassId,bs_ClassName.ClassName,bs_Group.Id as GroupId,bs_Group.GroupName

	from rs_FailSystem 
	inner join er_SubjectToClass on rs_FailSystem.SubjectToClassId=er_SubjectToClass.Id
	inner join bs_ClassName on er_SubjectToClass.ClassId=bs_ClassName.Id
	inner join bs_Group on er_SubjectToClass.GroupId=bs_Group.Id
	where rs_FailSystem.Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FailSystem_GetBySubjectId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_FailSystem_GetBySubjectId] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select rs_FailSystem.*
	from rs_FailSystem 
	where rs_FailSystem.SubjectToClassId=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FailSystem_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_FailSystem_Insert] (
@SubjectToClassId int,
@Theory decimal(18,2),
@Objective decimal(18,2),
@CreatedBy nvarchar(50),
@Practical decimal(18,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from rs_FailSystem where SubjectToClassId=@SubjectToClassId)
		begin
			select -1
		end
	else
		begin
			insert into rs_FailSystem(SubjectToClassId,SubjectiveFailMarks,ObjectiveFailMarks,CreatedBy,CreatedDate,Practical) 
			values (@SubjectToClassId,@Theory,@Objective,@CreatedBy,SYSDATETIME(),@Practical)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FailSystem_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_FailSystem_Update] (
@Id int,
@SubjectToClassId int,
@Theory decimal(18,2),
@Objective decimal(18,2),
@UpdatedBy nvarchar(50),
@Practical decimal(18,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
			Update rs_FailSystem set 
			SubjectToClassId=@SubjectToClassId,
			SubjectiveFailMarks=@Theory,
			ObjectiveFailMarks=@Objective,
			UpdatedBy=@UpdatedBy,
			UpdatedDate=SYSDATETIME(),
			Practical=@Practical
			where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FatherInformation_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_FatherInformation_Update] (
@Id int,
@FatherNameEng nvarchar(250),
@FatherNameBan nvarchar(250),
@FatherNId nvarchar(250),
@FatherIncome int,
@FatherPhone nvarchar(50),
@FatherQualificationId int,
@FatherProfessionId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	FatherNameEng=@FatherNameEng,
	FatherNameBan=@FatherNameBan,
	FatherNId=@FatherNId,
	FatherIncome =@FatherIncome,
	FatherPhone =@FatherPhone,
	FatherQualificationId=@FatherQualificationId ,
	FatherProfessionId =@FatherProfessionId

where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_FeeHead_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_FeeHead_GetByCriteria] (
					
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select bs_ClassName.ClassName, acc_FeeHead.* from acc_FeeHead
	left join bs_ClassName on acc_FeeHead.ClassId = bs_ClassName.Id where '+@Criteria;
	--print @sql;
	EXECUTE sp_executesql @sql;

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Feehead_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_Feehead_Insert] (
 @FcCode	varchar(50)
,@FullName varchar(100)
,@DisplayName varchar(50)
,@ClassId	int
,@ChargeBy	varchar(20)
,@DefaultAmount	int
,@PriorityOrder	int
,@IsActive	varchar(10)
,@IsActive_ForDueGenerationBySytem varchar(10)
,@CreatedBy	nvarchar(50)
)	
AS
BEGIN
declare @return_status varchar(10)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

--Get Validation data
BEGIN Tran;	
--declare @Status_Old varchar(20);
--select @Status_Old = lb_Book.Status, @BookLendingId_Old = lb_Book.BookLendingId from lb_Book where lb_Book.Id = @BookId;

--Validation
if(exists(select 1 from acc_FeeHead where FullName = @FullName and ClassId = @ClassId))
begin
	set @return_message = @FullName+' already exists for the same class.';
end


if(@return_message = '')
begin
	SET NOCOUNT ON;
	INSERT INTO [dbo].[acc_FeeHead]
           ([FcCode]
           ,[FullName]
           ,[DisplayName]
           ,[ClassId]
           ,[ChargeBy]
           ,[DefaultAmount]
		   ,[PriorityOrder]
           ,[IsActive]
		   ,[IsActive_ForDueGenerationBySytem]
           ,[CreatedBy]
           ,[CreatedDate])
     VALUES
           (@FcCode
           ,@FullName
		   ,@DisplayName
           ,@ClassId
           ,@ChargeBy
           ,@DefaultAmount
		   ,@PriorityOrder
           ,@IsActive
		   ,@IsActive_ForDueGenerationBySytem
           ,@CreatedBy
           ,GETDATE())
	set @Id = SCOPE_IDENTITY();		
	Commit;
	set @return_status = 'yes';
end
else
begin
	rollback;
end


select @return_status as return_status, @Id as id, @return_message as return_message;

END

GO
/****** Object:  StoredProcedure [dbo].[USP_Feehead_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_Feehead_Update] (
 @Id int
,@FcCode	varchar(50)
,@FullName varchar(100)
,@DisplayName varchar(50)
,@ClassId	int
,@ChargeBy	varchar(20)
,@DefaultAmount	int
,@PriorityOrder int
,@IsActive	varchar(10)
,@IsActive_ForDueGenerationBySytem varchar(10)
,@UpdatedBy	nvarchar(50)
)	
AS
BEGIN
declare @return_status varchar(100)='';
declare @return_message varchar(max)='';

--Get Validation data
BEGIN Tran;	
--declare @Status_Old varchar(20);
--select @Status_Old = lb_Book.Status, @BookLendingId_Old = lb_Book.BookLendingId from lb_Book where lb_Book.Id = @BookId;

--Validation
if(exists(select 1 from acc_FeeHead where Id != @Id AND FullName = @FullName and ClassId = @ClassId))
begin
	set @return_message = @FullName+' already exists for the same class.';
end


if(@return_message = '')
begin
	UPDATE [dbo].[acc_FeeHead]
   SET [FcCode] = @FcCode
      ,[FullName] = @FullName
	  ,[DisplayName] = @DisplayName
      ,[ClassId] = @ClassId
      ,[ChargeBy] = @ChargeBy
      ,[DefaultAmount] = @DefaultAmount
	  ,[PriorityOrder] = @PriorityOrder
      ,[IsActive] = @IsActive
	  ,[IsActive_ForDueGenerationBySytem] = @IsActive_ForDueGenerationBySytem
      ,[UpdatedBy] = @UpdatedBy
      ,[UpdatedDate] = getdate()
 WHERE id = @id;
	Commit;
	set @return_status = 'yes';
end
else
begin
	rollback;
end


select @return_status as return_status, @Id as id, @return_message as return_message;

END

GO
/****** Object:  StoredProcedure [dbo].[USP_Gender_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Gender_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Gender where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Gender_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Gender_Insert] (
@Gender nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Gender where Gender=@Gender)
		begin
			select -1
		end
	else
		begin
			insert into bs_Gender(Gender) values (@Gender)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Gender_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Gender_Update] (
@Id int,
@Gender nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Gender set
	Gender=@Gender
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Get_All]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Get_All] (
@Table nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	set @sql='Select * from '+@Table
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Get_AllRole]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Get_AllRole] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from RoleSetup
	where RoleName not in ('SuperAdmin') order by RoleName desc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetAll] (
@Table nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	set @sql='Select TOP(1000) * from '+@Table+' order by Id desc'
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_GetById] (
@Table nvarchar(50),
@Column nvarchar(50),
@Condition nvarchar(50)

)
	
AS
BEGIN
	SET NOCOUNT ON;

	declare @sql nvarchar(max)

	set @sql='Select * from '+@Table+' where '+@Column+'='+@Condition
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Grade_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Grade_GetAll] 
AS
BEGIN
	SET NOCOUNT ON;
	select *,
	(CAST(cast(rs_Grade.StartMarks as int) as varchar)+'-'+CAST(cast(rs_Grade.EndMarks as int) as varchar)) as ClassInterval 
	from rs_Grade
	order by EndMarks desc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Grade_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Grade_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select * from rs_Grade where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Grade_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Grade_Insert] (
@GradeName nvarchar(50),
@GradePoint decimal(5,2),
@StartMarks decimal(5,2),
@EndMarks decimal(5,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from rs_Grade where GradeName=@GradeName)
		begin
			select -1
		end
	else
		begin
			insert into rs_Grade(GradeName,GradePoint,StartMarks,EndMarks) values (@GradeName,@GradePoint,@StartMarks,@EndMarks)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Grade_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Grade_Update] (
@Id int,
@GradeName nvarchar(50),
@GradePoint decimal(5,2),
@StartMarks decimal(5,2),
@EndMarks decimal(5,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from rs_Grade where GradeName=@GradeName and GradePoint=@GradePoint and StartMarks=@StartMarks and EndMarks=@EndMarks)
		begin
			select -1
		end
	else
		begin
			Update rs_Grade set
			GradeName=@GradeName,
			GradePoint=@GradePoint,
			StartMarks=@StartMarks,
			EndMarks=@EndMarks
			where Id=@Id
			select @Id
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Group_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Group_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Group where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Group_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Group_Insert] (
@Group nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Group where GroupName=@Group)
		begin
			select -1
		end
	else
		begin
			insert into bs_Group(GroupName) values (@Group)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Group_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Group_Update] (
@Id int,
@Group nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Group set
	GroupName=@Group
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HomePageSetup_GetAll_Active]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_HomePageSetup_GetAll_Active] 
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_HomePageSetup
	where Status = 'Active'
	order by category, sequence;
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HomePageSetup_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[USP_HomePageSetup_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_HomePageSetup
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HomePageSetup_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_HomePageSetup_Insert] (
@Category nvarchar(50),
@Sequence int,
@Title nvarchar(50),
@Content nvarchar(MAX),	
@ImageLink nvarchar(200),
@YoutubeLink nvarchar(200),
@Status nvarchar(10),
@CreatedBy	nvarchar(50)	
)
	
AS
BEGIN
	SET NOCOUNT ON;
	insert into bs_HomePageSetup(Category,Sequence,Title,Content,ImageLink,YoutubeLink,Status,CreatedBy,CreateDate) 
	values (@Category,@Sequence,@Title,@Content,@ImageLink,@YoutubeLink,@Status,@CreatedBy,GETDATE())
	select SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[USP_HomePageSetup_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_HomePageSetup_Update] (
@Id int,
@Category nvarchar(50),
@Sequence int,
@Title nvarchar(50),
@Content nvarchar(MAX),	
@ImageLink nvarchar(200),
@YoutubeLink nvarchar(200),
@Status nvarchar(10),
@UpdatedBy nvarchar(50)	
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_HomePageSetup set Category=@Category,Sequence=@Sequence,Title=@Title,Content=@Content,ImageLink=@ImageLink,YoutubeLink=@YoutubeLink,Status=@Status,@UpdatedBy=UpdatedBy,UpdateDate=GETDATE()
	where Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Income_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Income_GetAll] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select acc_Income.*, acc_IncomeCategory.IncomeCategory from acc_Income inner join
	acc_IncomeCategory on acc_Income.IncomeCategoryId=acc_IncomeCategory.Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Income_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Income_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from acc_Income where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Income_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Income_Insert] (
@Date datetime,
@Amount decimal(10,2),
@CategoryId int,
@Attachment nvarchar(250),
@Note nvarchar(MAX),
@CreatedBy nvarchar(50),
@CreatedDate datetime
)
	
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO acc_Income(IncomeCategoryId,Date,Amount,Details,Attachment,CreatedBy,CreatedDate) VALUES
	(@CategoryId,@Date,@Amount,@Note,@Attachment,@CreatedBy,@CreatedDate)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_IncomeCategory_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_IncomeCategory_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from acc_IncomeCategory where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_IncomeCategory_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_IncomeCategory_Insert] (
@Category nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from acc_IncomeCategory where IncomeCategory=@Category)
		begin
			select -1
		end
	else
		begin
			insert into acc_IncomeCategory(IncomeCategory) values (@Category)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_IncomeCategory_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_IncomeCategory_Update] (
@Id int,
@Category nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update acc_IncomeCategory set
	IncomeCategory=@Category
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_JobApplication_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_JobApplication_GetByCriteria] (
					
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select bs_Religion.Religion,bs_Gender.Gender,bs_Nationality.Nationality,jb_JobApplication.* from jb_JobApplication
	inner join bs_Religion on jb_JobApplication.ReligionId = bs_Religion.Id
	inner join bs_Gender on jb_JobApplication.GenderId = bs_Gender.Id
	inner join bs_Nationality on jb_JobApplication.NationalityId = bs_Nationality.Id where '+@Criteria;
	--print @sql;
	EXECUTE sp_executesql @sql;

END
GO
/****** Object:  StoredProcedure [dbo].[USP_JobApplication_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE    PROCEDURE [dbo].[USP_JobApplication_GetById] (
@Id int
)
	
AS
BEGIN
SET NOCOUNT ON;
	
select bs_Religion.Religion,bs_Gender.Gender,bs_Nationality.Nationality,jb_JobApplication.* from jb_JobApplication
	inner join bs_Religion on jb_JobApplication.ReligionId = bs_Religion.Id
	inner join bs_Gender on jb_JobApplication.GenderId = bs_Gender.Id
	inner join bs_Nationality on jb_JobApplication.NationalityId = bs_Nationality.Id
	where jb_JobApplication.Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_JobApplication_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_JobApplication_Insert] (

	@FullName varchar(50) NULL,
	@FatherName varchar(50) NULL,
	@MotherName varchar(50) NULL,
	@DateOfBirth date NULL,
	@ReligionId int NULL,
	@GenderId int NULL,
	@NID varchar(20) NULL,
	@MobileNumber varchar(20) NULL,
	@Email varchar(50) NULL,
	@MPO_NTRCA varchar(20) NULL,
	@NationalityId int NULL,
	@PresentAddress varchar(400) NULL,
	@PermanentAddress varchar(400) NULL,
	@FaceImageFileName varchar(50) NULL,
	@SignatureImageFileName varchar(50) NULL,
	@EducationMasterBoard	varchar(50)	NULL,
	@EducationMasterCollege	varchar(100)	NULL,
	@EducationMasterGroup	varchar(50)	NULL,
	@EducationMasterCgpa	varchar(50)	NULL,
	@EducationMasterPassingYear	int	NULL,
	@EducationHonorsBoard	varchar(50)	NULL,
	@EducationHonorsCollege	varchar(100)	NULL,
	@EducationHonorsGroup	varchar(50)	NULL,
	@EducationHonorsCgpa	varchar(50)	NULL,
	@EducationHonorsPassingYear	int	NULL,
	@EducationHscBoard	varchar(50)	NULL,
	@EducationHscCollege	varchar(100)	NULL,
	@EducationHscGroup	varchar(50)	NULL,
	@EducationHscCgpa	varchar(50)	NULL,
	@EducationHscPassingYear	int	NULL,
	@EducationSscBoard	varchar(50)	NULL,
	@EducationSscCollege	varchar(100)	NULL,
	@EducationSscGroup	varchar(50)	NULL,
	@EducationSscCgpa	varchar(50)	NULL,
	@EducationSscPassingYear	int	NULL,
	@EducationJscBoard	varchar(50)	NULL,
	@EducationJscCollege	varchar(100)	NULL,
	@EducationJscGroup	varchar(50)	NULL,
	@EducationJscCgpa	varchar(50)	NULL,
	@EducationJscPassingYear	int	NULL,
	@TrainingCourseName_1	varchar(100)	NULL,
	@TrainingInstituteName_1	varchar(100)	NULL,
	@TrainingInstituteAddress_1	varchar(100)	NULL,
	@TrainingResult_1	varchar(20)	NULL,
	@TrainingStartDate_1	varchar(20)	NULL,
	@TrainingRunning_1	varchar(10)	NULL,
	@TrainingEndDate_1	varchar(20)	NULL,
	@TrainingCourseName_2	varchar(100)	NULL,
	@TrainingInstituteName_2	varchar(100)	NULL,
	@TrainingInstituteAddress_2	varchar(100)	NULL,
	@TrainingResult_2	varchar(20)	NULL,
	@TrainingStartDate_2	varchar(20)	NULL,
	@TrainingRunning_2	varchar(10)	NULL,
	@TrainingEndDate_2	varchar(20)	NULL,
	@TrainingCourseName_3	varchar(100)	NULL,
	@TrainingInstituteName_3	varchar(100)	NULL,
	@TrainingInstituteAddress_3	varchar(100)	NULL,
	@TrainingResult_3	varchar(20)	NULL,
	@TrainingStartDate_3	varchar(20)	NULL,
	@TrainingRunning_3	varchar(10)	NULL,
	@TrainingEndDate_3	varchar(20)	NULL,
	@ExperienceInstitute_1	varchar(100)	NULL,
	@ExperienceDepartment_1	varchar(50)	NULL,
	@ExperienceDesignation_1	varchar(50)	NULL,
	@ExperienceAddress_1	varchar(100)	NULL,
	@ExperienceStartDate_1	varchar(20)	NULL,
	@ExperienceRunning_1	varchar(20)	NULL,
	@ExperienceEndDate_1	varchar(50)	NULL,
	@ExperienceInstitute_2	varchar(100)	NULL,
	@ExperienceDepartment_2	varchar(50)	NULL,
	@ExperienceDesignation_2	varchar(50)	NULL,
	@ExperienceAddress_2	varchar(100)	NULL,
	@ExperienceStartDate_2	varchar(20)	NULL,
	@ExperienceRunning_2	varchar(20)	NULL,
	@ExperienceEndDate_2	varchar(50)	NULL,
	@ExperienceInstitute_3	varchar(100)	NULL,
	@ExperienceDepartment_3	varchar(50)	NULL,
	@ExperienceDesignation_3	varchar(50)	NULL,
	@ExperienceAddress_3	varchar(100)	NULL,
	@ExperienceStartDate_3	varchar(20)	NULL,
	@ExperienceRunning_3	varchar(20)	NULL,
	@ExperienceEndDate_3	varchar(50)	NULL
)	
AS
BEGIN
declare @return_status varchar(20)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

--Get Validation data
BEGIN Tran;	
--declare @Status_Old varchar(20);
--declare @BookLendingId_Old int;
--select @Status_Old = lb_Book.Status, @BookLendingId_Old = lb_Book.BookLendingId from lb_Book where lb_Book.Id = @BookId;

--Validation
--if(@Status_Old != 'Active')
--begin
--	set @return_message = @return_message + 'Book status is: '+@Status_Old+'. ';
--end


if(@return_message = '')
begin
	SET NOCOUNT ON;

INSERT INTO [dbo].[jb_JobApplication]
           ([FullName]
           ,[FatherName]
           ,[MotherName]
           ,[DateOfBirth]
           ,[ReligionId]
           ,[GenderId]
           ,[NID]
           ,[MobileNumber]
           ,[Email]
           ,[MPO_NTRCA]
           ,[NationalityId]
           ,[PresentAddress]
           ,[PermanentAddress]
           ,[FaceImageFileName]
           ,[SignatureImageFileName]
           ,[EducationMasterBoard]
           ,[EducationMasterCollege]
           ,[EducationMasterGroup]
           ,[EducationMasterCgpa]
           ,[EducationMasterPassingYear]
           ,[EducationHonorsBoard]
           ,[EducationHonorsCollege]
           ,[EducationHonorsGroup]
           ,[EducationHonorsCgpa]
           ,[EducationHonorsPassingYear]
           ,[EducationHscBoard]
           ,[EducationHscCollege]
           ,[EducationHscGroup]
           ,[EducationHscCgpa]
           ,[EducationHscPassingYear]
		   ,[EducationSscBoard]
           ,[EducationSscCollege]
           ,[EducationSscGroup]
           ,[EducationSscCgpa]
           ,[EducationSscPassingYear]
           ,[EducationJscBoard]
           ,[EducationJscCollege]
           ,[EducationJscGroup]
           ,[EducationJscCgpa]
           ,[EducationJscPassingYear]
           ,[TrainingCourseName_1]
           ,[TrainingInstituteName_1]
           ,[TrainingInstituteAddress_1]
           ,[TrainingResult_1]
           ,[TrainingStartDate_1]
           ,[TrainingRunning_1]
           ,[TrainingEndDate_1]
           ,[TrainingCourseName_2]
           ,[TrainingInstituteName_2]
           ,[TrainingInstituteAddress_2]
           ,[TrainingResult_2]
           ,[TrainingStartDate_2]
           ,[TrainingRunning_2]
           ,[TrainingEndDate_2]
           ,[TrainingCourseName_3]
           ,[TrainingInstituteName_3]
           ,[TrainingInstituteAddress_3]
           ,[TrainingResult_3]
           ,[TrainingStartDate_3]
           ,[TrainingRunning_3]
           ,[TrainingEndDate_3]
           ,[ExperienceInstitute_1]
           ,[ExperienceDepartment_1]
           ,[ExperienceDesignation_1]
           ,[ExperienceAddress_1]
           ,[ExperienceStartDate_1]
           ,[ExperienceRunning_1]
           ,[ExperienceEndDate_1]
           ,[ExperienceInstitute_2]
           ,[ExperienceDepartment_2]
           ,[ExperienceDesignation_2]
           ,[ExperienceAddress_2]
           ,[ExperienceStartDate_2]
           ,[ExperienceRunning_2]
           ,[ExperienceEndDate_2]
           ,[ExperienceInstitute_3]
           ,[ExperienceDepartment_3]
           ,[ExperienceDesignation_3]
           ,[ExperienceAddress_3]
           ,[ExperienceStartDate_3]
           ,[ExperienceRunning_3]
           ,[ExperienceEndDate_3])
     VALUES
           
           (@FullName
           ,@FatherName
           ,@MotherName
           ,@DateOfBirth
           ,@ReligionId
           ,@GenderId
           ,@NID
           ,@MobileNumber
           ,@Email
           ,@MPO_NTRCA
           ,@NationalityId
           ,@PresentAddress
           ,@PermanentAddress
           ,@FaceImageFileName
           ,@SignatureImageFileName
           ,@EducationMasterBoard
           ,@EducationMasterCollege
           ,@EducationMasterGroup
           ,@EducationMasterCgpa
           ,@EducationMasterPassingYear
           ,@EducationHonorsBoard
           ,@EducationHonorsCollege
           ,@EducationHonorsGroup
           ,@EducationHonorsCgpa
           ,@EducationHonorsPassingYear
           ,@EducationHscBoard
           ,@EducationHscCollege
           ,@EducationHscGroup
           ,@EducationHscCgpa
           ,@EducationHscPassingYear
		   ,@EducationSscBoard
           ,@EducationSscCollege
           ,@EducationSscGroup
           ,@EducationSscCgpa
           ,@EducationSscPassingYear
           ,@EducationJscBoard
           ,@EducationJscCollege
           ,@EducationJscGroup
           ,@EducationJscCgpa
           ,@EducationJscPassingYear
           ,@TrainingCourseName_1
           ,@TrainingInstituteName_1
           ,@TrainingInstituteAddress_1
           ,@TrainingResult_1
           ,@TrainingStartDate_1
           ,@TrainingRunning_1
           ,@TrainingEndDate_1
           ,@TrainingCourseName_2
           ,@TrainingInstituteName_2
           ,@TrainingInstituteAddress_2
           ,@TrainingResult_2
           ,@TrainingStartDate_2
           ,@TrainingRunning_2
           ,@TrainingEndDate_2
           ,@TrainingCourseName_3
           ,@TrainingInstituteName_3
           ,@TrainingInstituteAddress_3
           ,@TrainingResult_3
           ,@TrainingStartDate_3
           ,@TrainingRunning_3
           ,@TrainingEndDate_3
           ,@ExperienceInstitute_1
           ,@ExperienceDepartment_1
           ,@ExperienceDesignation_1
           ,@ExperienceAddress_1
           ,@ExperienceStartDate_1
           ,@ExperienceRunning_1
           ,@ExperienceEndDate_1
           ,@ExperienceInstitute_2
           ,@ExperienceDepartment_2
           ,@ExperienceDesignation_2
           ,@ExperienceAddress_2
           ,@ExperienceStartDate_2
           ,@ExperienceRunning_2
           ,@ExperienceEndDate_2
           ,@ExperienceInstitute_3
           ,@ExperienceDepartment_3
           ,@ExperienceDesignation_3
           ,@ExperienceAddress_3
           ,@ExperienceStartDate_3
           ,@ExperienceRunning_3
           ,@ExperienceEndDate_3)
	set @Id = SCOPE_IDENTITY();
	Commit;
	set @return_status = 'yes';
end
else
begin
	rollback;
end


select @return_status as return_status, @Id as id, @return_message as return_message;

END

GO
/****** Object:  StoredProcedure [dbo].[USP_Language_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Language_Insert] (
@Language nvarchar(100)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from lb_Language where Language=@Language)
		begin
			select -1
		end
	else
		begin
			insert into lb_Language(Language) values (@Language)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Marks_InserXml]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Marks_InserXml] (
@XML nvarchar(max),
@Year int,
@BaseMarks decimal(5,2),
@ExamType int,
@CTOutOf decimal(5,2),
@CreatedBy nvarchar(50)
)
	
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	INSERT Into rs_ObtainMarks
	(
	  StudentToClassId,SubjectId,SubjectiveMarks,ObjectiveMarks,PracticalMarks,OtherMarks,CT1,CT2,CT3,CreatedBy,YearId,ExamTypeId,BaseMarks,CTOutOf
	)
	SELECT StId,SubId,Theory,Objective,Pracrical,SBS,CT1,CT2,CT3,@CreatedBy,@Year,@ExamType,@BaseMarks,@CTOutOf
	FROM OPENXML(@pointerDoc, 'dsMarks/dtMarks',2)
	WITH (
		StId int,
		SubId int,
		Theory decimal(18,2),
		Objective decimal(18,2),
		Pracrical decimal(18,2),
		SBS decimal(18,2),
		CT1 decimal(18,2),
		CT2 decimal(18,2),
		CT3 decimal(18,2)

	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc

	update rs_ObtainMarks  
		set GradePoint=(select g.GradePoint from rs_Grade g where 
	Convert(int,((((ObjectiveMarks+SubjectiveMarks+PracticalMarks+OtherMarks)*(BaseMarks-CTOutOf)/BaseMarks))+((CT1+CT2+CT3)/3))*(100/BaseMarks))  between g.StartMarks and g.EndMarks),
	Grade=(select g.GradeName from rs_Grade g where 
	Convert(int,((((ObjectiveMarks+SubjectiveMarks+PracticalMarks+OtherMarks)*(BaseMarks-CTOutOf)/BaseMarks))+((CT1+CT2+CT3)/3))*(100/BaseMarks))  between g.StartMarks and g.EndMarks)
	Where BaseMarks>0 AND ExamTypeId=@ExamType and YearId=@Year
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Marks_UpdateXml]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Marks_UpdateXml] (
@XML nvarchar(max),
@Year int,
@BaseMarks decimal(5,2),
@ExamType int,
@CTOutOf decimal(5,2),
@UpdatedBy nvarchar(50)
)
	
AS
DECLARE 
		@pointerDoc int
BEGIN
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	Update rs_ObtainMarks set
	StudentToClassId=StId,
	SubjectId=SubId,
	SubjectiveMarks=Theory,
	ObjectiveMarks=Objective,
	PracticalMarks=Pracrical,
	OtherMarks=SBS,
	CT1=C1,
	CT2=C2,
	CT3=C3,
	UpdatedBy=@UpdatedBy,
	YearId=@Year,
	ExamTypeId=@ExamType,
	BaseMarks=@BaseMarks,
	CTOutOf=@CTOutOf
	FROM OPENXML(@pointerDoc, 'dsMarks/dtMarks',2)
	WITH (
		MarksId int,
		StId int,
		SubId int,
		Theory decimal(18,2),
		Objective decimal(18,2),
		Pracrical decimal(18,2),
		SBS decimal(18,2),
		C1 decimal(18,2),
		C2 decimal(18,2),
		C3 decimal(18,2)
	) XMLReceiveDetailsTable
	
	where Id=MarksId
	EXEC sp_xml_removedocument @pointerDoc


--update rs_ObtainMarks  
--		set GradePoint=(select g.GradePoint from rs_Grade g where 
--	Convert(int,((((ObjectiveMarks+SubjectiveMarks+PracticalMarks+OtherMarks)*(BaseMarks-CTOutOf)/BaseMarks))+((CT1+CT2+CT3)/3))*(100/BaseMarks))  between g.StartMarks and g.EndMarks),
--	Grade=(select g.GradeName from rs_Grade g where 
--	Convert(int,((((ObjectiveMarks+SubjectiveMarks+PracticalMarks+OtherMarks)*(BaseMarks-CTOutOf)/BaseMarks))+((CT1+CT2+CT3)/3))*(100/BaseMarks))  between g.StartMarks and g.EndMarks)
--	Where BaseMarks>0 AND ExamTypeId=@ExamType and YearId=@Year
END
GO
/****** Object:  StoredProcedure [dbo].[USP_MotherInformation_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_MotherInformation_Update] (
@Id int,
@MotherNameEng nvarchar(250),
@MotherNameBan nvarchar(250),
@MotherNId nvarchar(250),
@MotherIncome int,
@MotherPhone nvarchar(250),
@MotherQualificationId int,
@MotherProfessionId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	MotherNameEng=@MotherNameEng,
	MotherNameBan=@MotherNameBan,
	MotherNId=@MotherNId,
	MotherIncome =@MotherIncome,
	MotherPhone=@MotherPhone ,
	MotherQualificationId =@MotherQualificationId,
	MotherProfessionId =@MotherProfessionId
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_News_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_News_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_News
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_News_GetLatest]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_News_GetLatest]
	
AS
BEGIN
	SET NOCOUNT ON;
	select top(10) * from bs_News order by Id desc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_News_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_News_Insert] (
@Title nvarchar(250),
@ShortDescription nvarchar(250),
@Details nvarchar(max),
@Date datetime,
@CreatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_News where Title=@Title and Date=@Date)
		begin
			select -1
		end
	else
		begin
			insert into bs_News(Title, ShortDescription,Details,Date,CreatedBy,CreatedDate)
			values(@Title,@ShortDescription,@Details,@Date,@CreatedBy,GETDATE())
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_News_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_News_Update] (
@Id int,
@Title nvarchar(250),
@ShortDescription nvarchar(250),
@Details nvarchar(max),
@Date datetime,
@UpdatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_News set
	Title=@Title,
	ShortDescription=@ShortDescription,
	Details=@Details,
	Date=@Date,
	UpdatedBy=@UpdatedBy
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_Board]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Notice_Board] 
AS
BEGIN
	SET NOCOUNT ON;
		begin
			select * from bs_Notice where Date>=GETDATE()-360 order by Date desc
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_ForAllClass]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Notice_ForAllClass] (
@Year int,
@ClassId int,
@NoticeId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
		begin
			insert into nt_NoticeForClass(Year,ClassId,NoticeId) values(@Year,@ClassId,@NoticeId)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_ForSpecificStudent]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Notice_ForSpecificStudent] (
@Xml nvarchar(MAX)

)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into nt_NoticeForStudent
	(
	  SutdentToClassId,NoticeId
	)
	SELECT Id, NoticeId
	FROM OPENXML(@pointerDoc, 'dsPerson/dtPerson',2)
	WITH (
		Id int,
		NoticeId int
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_ForSpecificTeacher]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Notice_ForSpecificTeacher] (
@Xml nvarchar(MAX)

)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into nt_NoticeForTeacher
	(
	  TeacherId,NoticeId
	)
	SELECT Id, NoticeId
	FROM OPENXML(@pointerDoc, 'dsPerson/dtPerson',2)
	WITH (
		Id int,
		NoticeId int
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Notice_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
		begin
			select * from bs_Notice where Id=@Id
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_GetNoticeForStudent]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Notice_GetNoticeForStudent] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from
	((select NoticeId from nt_NoticeForStudent where nt_NoticeForStudent.SutdentToClassId=@Id) 
	 union 
	(select NoticeId from nt_NoticeForClass where nt_NoticeForClass.ClassId=(select ClassId from er_StudentToClass where Id=@Id))) as t
	inner join bs_Notice as n on t.NoticeId=n.Id
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Notice_Insert] (
@Title nvarchar(250),
@ShortDescription nvarchar(250),
@Details nvarchar(max),
@Date datetime,
@CreatedBy nvarchar(50),
@CreatedDate datetime,
@Attachment nvarchar(120)
)
	
AS
BEGIN
	SET NOCOUNT ON;
		begin
			insert into bs_Notice(Title, ShortDescription,Details,Date,CreatedBy,CreatedDate,Files)
			values(@Title,@ShortDescription,@Details,@Date,@CreatedBy,GETDATE(),@Attachment)
			select SCOPE_IDENTITY()
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Notice_UnseenNoticeForTeacher]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Notice_UnseenNoticeForTeacher] (
@TeacherId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
		begin
			select bs_Notice.*,nt_NoticeForTeacher.IsSeen,nt_NoticeForTeacher.TeacherId from nt_NoticeForTeacher inner join bs_Notice
			on nt_NoticeForTeacher.NoticeId=bs_Notice.Id where nt_NoticeForTeacher.TeacherId=@TeacherId
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_ConfirmOnlinePayment]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_Payment_ConfirmOnlinePayment] (
@TxnId nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update ss_Payment set IsConfirmed=1 where TxnID=@TxnId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_Payment_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from ss_Payment where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_GetDues]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_GetDues] (
@Criteria nvarchar(Max)
)
	
AS
declare @sql nvarchar(max)
BEGIN
	SET NOCOUNT ON;
	set @sql= 'select  s.Id,s.RegNo,p.DueAmount Amount,p.Year,p.Month,p.PaymentTypeId,pt.PaymentType,sps.NameEng,sps.Mobile,cl.ClassName,sc.Section,sf.Shift,g.GroupName,gn.Gender,r.Religion 
from er_StudentToClass c inner join ss_Student s on s.Id=c.StudentId 
			inner join ss_Payment p on p.StudentId=c.StudentId
			left outer join fee_PaymentType pt on pt.Id=p.PaymentTypeId
			inner join st_Person sps on sps.Id=s.PersonId
			inner join bs_ClassName cl on cl.Id=c.ClassId
			inner join bs_Section sc on sc.Id=c.SectionId
			inner join bs_Shift sf on sf.Id=c.ShiftId
			inner join bs_Group g on g.Id=c.GroupId
			inner join bs_Gender gn on gn.Id=sps.GenderId
			inner join bs_Religion r on r.Id=sps.ReligionId
			where c.Id=(Select MAX(Id) from er_StudentToClass ec where ec.StudentId=s.Id) And p.DueAmount>0 '+@Criteria+' Order by Convert(int,p.Month) asc'

			EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_GetDuesByMonthRegNo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_Payment_GetDuesByMonthRegNo] (
@RegNo nvarchar(50),
@Year int,
@Month int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select s.Id,s.RegNo,p.DueAmount Amount,p.Year,p.Month,p.PaymentTypeId,pt.PaymentType from ss_Payment p inner join ss_Student s on s.Id=p.StudentId 
	left outer join fee_PaymentType pt on pt.id=p.PaymentTypeId
where s.RegNo=@RegNo and p.DueAmount>0 and Year=@Year and Month=@Month Order by Convert(int,p.Month) asc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_GetDuesByRegNo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_GetDuesByRegNo] (
@RegNo nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select s.Id,s.RegNo,p.DueAmount Amount,p.Year,p.Month,p.PaymentTypeId,pt.PaymentType,p.Id PaymentId from ss_Payment p inner join ss_Student s on s.Id=p.StudentId 
	left outer join fee_PaymentType pt on pt.id=p.PaymentTypeId
where s.RegNo like '%'+@RegNo and p.DueAmount>0 Order by Convert(int,p.Month) asc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_GetPaymentHistoryByStudentId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_GetPaymentHistoryByStudentId] (
@StudentId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select p.*,f.PaymentType from ss_Payment p left outer join fee_PaymentType f on f.Id=p.PaymentTypeId where StudentId=@StudentId and TotalGiven>0 order by p.Id asc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_GetPreviousPaymentByStudentId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_GetPreviousPaymentByStudentId] (
@StudentId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select SUM(DueAmount) as Due from ss_Payment where StudentId=@StudentId
	group by StudentId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_HistoryByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_Payment_HistoryByCriteria] (
@Criteria nvarchar(Max)
)
	
AS
declare @sql nvarchar(max)
BEGIN
	SET NOCOUNT ON;
		set @sql= 'select * from vw_PaymentDetails where Id>0'+@Criteria

					EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertdbblLog]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payment_InsertdbblLog] (
@StudentId int,
@Amount decimal,
@Mobile nvarchar(50),
@TxnID nvarchar(100)
)
AS
BEGIN
	INSERT Into ss_Payment_dbbl
	(
	  StudentId,Amount,PayerMobile,TxnID
	)Values(@StudentId,@Amount,@Mobile,@TxnID)
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertExcel]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 16-04-2017
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_InsertExcel] (
@RegNo nvarchar(50),
@Amount decimal,
@Year int,
@Month int,
@Feetype int,
@CreatedBy nvarchar(50)
)
AS
BEGIN
	
	INSERT Into ss_Payment
	(
	  StudentId,Amount,DueAmount,TotalGiven,Year,Month,CreatedBy,CreatedDate,PaymentTypeId
	)
	values((Select s.Id from ss_Student s where s.RegNo=@RegNo),@Amount,@Amount,0,@Year,@Month,@CreatedBy,GETDATE(),@Feetype)
		
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertForClass]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_InsertForClass] (
@Xml nvarchar(MAX),
@CreatedBy nvarchar(50),
@CreatedDate datetime,
@months nvarchar(50), 
@Year int
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into fee_PaymentForClass
	(
	  PaymentTypeId,YearId,[Month],ClassId,Amount,GroupId,CreatedBy,CreatedDate
	)
	SELECT PayID,YId,MID,CID,Amount,GroupId,@CreatedBy,@CreatedDate
	FROM OPENXML(@pointerDoc, 'dsPayment/dtPayment',2)
	WITH (
		PayID int,
		YId int,
		MID nvarchar(50),
		CID int,
		Amount int,
		GroupId int
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc

	BEGIN
	INSERT INTO ss_Payment(StudentId, Year, Month, DueAmount, Amount, TotalGiven, CreatedBy, PaymentTypeId) select s.Id, p.YearId,p.Month,p.Amount,
	p.Amount,0,@CreatedBy,p.PaymentTypeId from fee_PaymentForClass p 
	inner join er_StudentToClass c on c.ClassId=p.ClassId
	inner join ss_Student s on s.Id=c.StudentId 
	where c.StudentId not in(
	select StudentId from ss_Payment sp where sp.Year=p.YearId and sp.Month=p.Month  and sp.StudentId=c.StudentId and sp.PaymentTypeId=p.PaymentTypeId
	) and c.Id=(select Max(Id) from er_StudentToClass where StudentId=c.StudentId)
	and p.YearId=@Year and p.Month in (@months)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertForStudent]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Payment_InsertForStudent] (
@StudentId int,
@Year int,
@Month int,
@Amount decimal,
@PaymentTypeId int,
@CreatedBy nvarchar(50)
)
AS


	BEGIN
	INSERT INTO ss_Payment(StudentId, Year, Month, DueAmount, Amount, CreatedBy, PaymentTypeId)  
	Values(@StudentId,@Year,@Month,@Amount,@Amount,@CreatedBy,@PaymentTypeId)
	END


GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertScholarship]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 26-12-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_InsertScholarship] (
@StudentId int,
@Year int,
@Month int,
@Amount decimal(18,2),
@Remarks nvarchar(250),
@CreatedBy nvarchar(50)
)
AS
BEGIN
	
	SET NOCOUNT ON;
	INSERT Into fee_Scholarship
	(
	  StudentId,Years,Months,Amount,Remarks,CreatedBy
	) Values(@StudentId,@Year,@Month,@Amount,@Remarks,@CreatedBy)

		Update ss_Payment set DueAmount=DueAmount-@Amount Where StudentId=@StudentId and Month=@Month
		and Year=@Year and PaymentTypeId=10
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertStudentPayment]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_InsertStudentPayment] (
@Xml nvarchar(MAX),
@CreatedBy nvarchar(50),
@CreatedDate datetime
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into ss_Payment
	(
	  StudentId,Year,Month,Amount,TotalGiven,DueAmount,CreatedBy,CreatedDate
	)
	SELECT StudentId,Year,Month,Total,Paid,Due,@CreatedBy,@CreatedDate
	FROM OPENXML(@pointerDoc, 'dsStudentPayment/TotalPayment',2)
	WITH (
		StudentId int,
		Year int,
		Month int,
		Total decimal(18,2),
		Paid decimal(18,2),
		Due decimal(18,2)
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_InsertStudentPaymentOnline]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_InsertStudentPaymentOnline] (
@StudentId int,
@Year int,
@Month int,
@Amount decimal,
@CreatedBy nvarchar(50),
@Mobile nvarchar(50),
@TxnID nvarchar(100),
@PaymentTypeId int,
@PayMode nvarchar(50)
)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN
		--Delete from ss_Payment where StudentId=@StudentId and TotalGiven=0
		Update ss_Payment set TotalGiven=TotalGiven+@Amount, DueAmount=DueAmount-@Amount, PayerMobile=@Mobile,TxnID=@TxnID,PayMode=@PayMode , UpdatedDate=GETDATE(), UpdatedBy=@CreatedBy 
		where StudentId=@StudentId and PaymentTypeId=@PaymentTypeId and Year=@Year and Month=@Month
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_ScholarshipByStudentId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 26-12-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_ScholarshipByStudentId] (
@StudentId int
)
AS
BEGIN
	
	SET NOCOUNT ON;
	Select *,DateName( month , DateAdd( month ,Months , -1 ) ) month from fee_Scholarship where StudentId=@StudentId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_ScholarshipByStudentIdYearMonth]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 26-12-2016
-- =============================================
Create PROCEDURE [dbo].[USP_Payment_ScholarshipByStudentIdYearMonth] (
@StudentId int,
@Year int,
@Month int
)
AS
BEGIN
	
	SET NOCOUNT ON;
	Select *,DateName( month , DateAdd( month ,Months , -1 ) ) month from fee_Scholarship where StudentId=@StudentId and Years=@Year and Months=@Month
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_StudentPaymentInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_StudentPaymentInsert] (
@Year nvarchar(50),
@Month nvarchar(50),
@StudentId int,
@Total decimal(18,2),
@GivenAmount decimal(18,2),
@CreatedBy nvarchar(50)
)
AS
BEGIN
	IF EXISTS (select * from ss_Payment where Year=@Year and Month=@Month and StudentId=@StudentId)
		begin
			update ss_Payment set
			Amount=@Total,
			TotalGiven=@GivenAmount,
			DueAmount=@Total-@GivenAmount
			where Year=@Year and Month=@Month and StudentId=@StudentId
		end
	else
	begin
		insert into ss_Payment (Year,Month,Date,StudentId,Amount,TotalGiven,DueAmount,CreatedBy,CreatedDate)
		values
		(@Year,@Month,GETDATE(),@StudentId,@Total,@GivenAmount,@Total-@GivenAmount,@CreatedBy,GETDATE())
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_SummeryByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_SummeryByCriteria] (
@Criteria nvarchar(Max)
)
	
AS
declare @sql nvarchar(max)
BEGIN
	SET NOCOUNT ON;
		set @sql= 'select SUM(Amount) Amount,SUM(TotalGiven) TotalGiven,SUM(DueAmount) DueAmount,RegNo,ClassName,NameEng,Year,Month,Mobile   from vw_PaymentDetails where Id>0 '+@Criteria+' group by RegNo,ClassName,NameEng,Year,Month,Mobile'

					EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_Update] (
@Id int,
@Year int,
@Month int,
@Amount decimal,
@TotalGiven decimal,
@DueAmount decimal,
@Mobile nvarchar(50),
@TxnID nvarchar(100),
@PaymentTypeId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	UPdate ss_Payment set Year=@Year,Month=@Month,Amount=@Amount,TotalGiven=@TotalGiven,DueAmount=@DueAmount,PayerMobile=@Mobile,TxnID=@TxnID, PaymentTypeId=@PaymentTypeId where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_UpdateDueByStudentId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Payment_UpdateDueByStudentId] (
@StudentId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update ss_Payment set DueAmount=0 where StudentId=@StudentId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payment_UpdateForClass]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payment_UpdateForClass] (
@Id int,
@Amount decimal,
@UpdateddBy nvarchar(50),
@Year int,
@month int,
@classs int,
@group int
)
AS
BEGIN
	Update fee_PaymentForClass set Amount=@Amount,UpdatedBy=@UpdateddBy,UpdatedDate=GETDATE() where Id=@Id

	update	ss_Payment set Amount=@Amount, DueAmount=@Amount-DueAmount, UpdatedBy=@UpdateddBy,UpdatedDate=GETDATE() where Year=@Year and Month=@month and StudentId in  (select StudentId from er_StudentToClass  where ClassId=@classs and GroupId=@group and Year=@Year)

END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentMethod_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_PaymentMethod_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_PaymentMethod where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentMethod_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_PaymentMethod_Insert] (
@PaymentMethod nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_PaymentMethod where MethodName=@PaymentMethod)
		begin
			select -1
		end
	else
		begin
			insert into bs_PaymentMethod(MethodName) values (@PaymentMethod)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentMethod_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_PaymentMethod_Update] (
@Id int,
@PaymentMethod nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_PaymentMethod set
	MethodName=@PaymentMethod
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentType_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_PaymentType_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from fee_PaymentType where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentType_GetByYear]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_PaymentType_GetByYear] (
@YearId int,
@Month nvarchar(50),
@ClassId int,
@GroupId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select *,
	(select SUM(Amount) from fee_PaymentForClass where fee_PaymentForClass.YearId=@YearId and fee_PaymentForClass.ClassId=@ClassId and GroupId=@GroupId and fee_PaymentForClass.Month=@Month) as Total
	 from fee_PaymentForClass 
	inner join fee_PaymentType on fee_PaymentForClass.PaymentTypeId=fee_PaymentType.Id 
	where fee_PaymentForClass.YearId=@YearId and fee_PaymentForClass.ClassId=@ClassId and fee_PaymentForClass.GroupId=@GroupId and fee_PaymentForClass.Month=@Month
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentType_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_PaymentType_Insert] (
@Type nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from fee_PaymentType where PaymentType=@Type)
		begin
			select -1
		end
	else
		begin
			insert into fee_PaymentType(PaymentType) values (@Type)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PaymentType_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_PaymentType_Update] (
@Id int,
@Type nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update fee_PaymentType set
	PaymentType=@Type
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_AllowanceDeleteByTypeId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_AllowanceDeleteByTypeId] (
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;
	delete from pr_AllowanceToType
	where TypeId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_AllowanceGetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_AllowanceGetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from pr_Allowance where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_AllowanceGetByTypeId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_AllowanceGetByTypeId] (
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;
	select * from pr_AllowanceToType
	where TypeId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_AllowanceInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_AllowanceInsert] (
@Allowance nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from pr_Allowance where Allowance=@Allowance)
		begin
			select -1
		end
	else
		begin
			insert into pr_Allowance(Allowance) values (@Allowance)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_AllowanceUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_AllowanceUpdate] (
@Id int,
@Allowance nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update pr_Allowance set
	Allowance=@Allowance
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_DeductionDeleteByTypeId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_DeductionDeleteByTypeId] (
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;
	delete from pr_DeductionToType
	where TypeId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_DeductionGetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_DeductionGetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from pr_Deduction where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_DeductionGetByTypeId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payroll_DeductionGetByTypeId] (
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;
	select * from pr_DeductionToType
	where TypeId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_DeductionInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_DeductionInsert] (
@Deduction nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from pr_Deduction where Deduction=@Deduction)
		begin
			select -1
		end
	else
		begin
			insert into pr_Deduction(Deduction) values (@Deduction)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_DeductionUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_DeductionUpdate] (
@Id int,
@Deduction nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update pr_Deduction set
	Deduction=@Deduction
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_GetAllowanceBytypeId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payroll_GetAllowanceBytypeId] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select pr_AllowanceToType.*,pr_Allowance.Allowance,pr_Type.Basic,
	cast((pr_Type.Basic*pr_AllowanceToType.AllowancePercent)/100 as decimal(10,2)) as AllowanceAmount
	 from pr_AllowanceToType inner join pr_Allowance 
	on pr_AllowanceToType.AllowanceId=pr_Allowance.Id inner join pr_Type
	on pr_AllowanceToType.TypeId=pr_Type.Id

	where TypeId=2
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_GetDeductionBytypeId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_GetDeductionBytypeId] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select pr_DeductionToType.*,pr_Deduction.Deduction,pr_Type.Basic,
	cast((pr_Type.Basic*pr_DeductionToType.DeductionPercent)/100 as decimal(10,2)) as DeductionAmount
	 from pr_DeductionToType inner join pr_Deduction 
	on pr_DeductionToType.DeductionId=pr_Deduction.Id inner join pr_Type
	on pr_DeductionToType.TypeId=pr_Type.Id

	where TypeId=1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_GetPayrollForTeacher]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payroll_GetPayrollForTeacher] (
@Pin nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	select pr_Type.*,pr_SalaryScale.Scale,st_Person.NameEng,bs_Designation.Designation,tr_Teacher.TeacherPin from pr_StaffToType inner join pr_Type 
	on pr_StaffToType.TypeId=pr_Type.Id inner join pr_SalaryScale
	on pr_Type.ScaleId=pr_SalaryScale.Id inner join tr_Teacher
	on pr_StaffToType.PinCode=tr_Teacher.TeacherPin inner join st_Person
	on tr_Teacher.PersonId=st_Person.Id inner join bs_Designation
	on tr_Teacher.DesignationId=bs_Designation.Id
	where pr_StaffToType.PinCode=@Pin
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_InserAllowanceToType]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_InserAllowanceToType] (
@Xml nvarchar(MAX),
@CreatedBy nvarchar(50),
@CreatedDate datetime
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into pr_AllowanceToType
	(
	  TypeId,AllowanceId,AllowancePercent,CreatedBy,CreatedDate
	)
	SELECT TId,AId,Amount,@CreatedBy,@CreatedDate
	FROM OPENXML(@pointerDoc, 'dsAllowance/dtAllowance',2)
	WITH (
		TId int,
		AId int,
		Amount int
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_InserDeductionToType]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_InserDeductionToType] (
@Xml nvarchar(MAX),
@CreatedBy nvarchar(50),
@CreatedDate datetime
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into pr_DeductionToType
	(
	  TypeId,DeductionId,DeductionPercent,CreatedBy,CreatedDate
	)
	SELECT TId,DId,Amount,@CreatedBy,@CreatedDate
	FROM OPENXML(@pointerDoc, 'dsDeduction/dtDeduction',2)
	WITH (
		TId int,
		DId int,
		Amount int
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_SalaryScaleGetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_SalaryScaleGetById] (
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;
	select * from pr_SalaryScale
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_SalaryScaleInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_SalaryScaleInsert] (
@Scale nvarchar(50),
@Description nvarchar(250)
)
AS
BEGIN
	SET NOCOUNT ON;
	insert into pr_SalaryScale (Scale,[Description]) values(@Scale,@Description)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_SalaryScaleUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_SalaryScaleUpdate] (
@Id int,
@Scale nvarchar(50),
@Description nvarchar(250)
)
AS
BEGIN
	SET NOCOUNT ON;
	Update pr_SalaryScale set
	Scale=@Scale,
	Description=@Description
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_TypeGetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Payroll_TypeGetById] (
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;
	select pr_Type.*,pr_SalaryScale.Scale from pr_Type inner join pr_SalaryScale on pr_Type.ScaleId=pr_SalaryScale.Id
	where pr_Type.Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_TypeInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_TypeInsert] (
@Type nvarchar(50),
@ScaleId int,
@Basic decimal(10,2)
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from pr_Type where Type=@Type)
		begin
			select -1
		end
	else
		begin
			insert into pr_Type([Type],ScaleId,[Basic]) values (@Type,@ScaleId,@Basic)
			select SCOPE_IDENTITY()
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Payroll_TypeUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Payroll_TypeUpdate] (
@Id int,
@Type nvarchar(50),
@ScaleId int,
@Basic decimal(10,2)
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	SET NOCOUNT ON;
	update pr_Type set
	Type=@Type,
	ScaleId=@ScaleId,
	Basic=@Basic
	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_AllImageUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Person_AllImageUpdate] (
@PersonId int,
@PersonImage nvarchar(250),
@FatherImage nvarchar(250),
@MotherImage nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	PersonImage=@PersonImage,
	FatherImage=@FatherImage,
	MotherImage=@MotherImage
	where Id=@PersonId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_FatherImageUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Person_FatherImageUpdate] (
@PersonId int,
@Photo nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	FatherImage=@Photo
	where Id=@PersonId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_GetByPersonId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_GetByPersonId] (
@PersonId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select st_Person.*,Users.Password,
	ss_Student.RegNo as RegistrationNo,
	bs_BloodGroup.BloodGroup as BloodGroupName,
	bs_Gender.Gender,
	bs_Religion.Religion,
	bs_ClassName.ClassName,
	bs_Group.GroupName,
	bs_Shift.Shift,
	bs_Section.Section,
	er_StudentToClass.*,
	er_StudentToClass.RollNo,
	st_ParmanentAddress.DivisionId,
	st_ParmanentAddress.DistrictId,
	st_ParmanentAddress.ThanaId,
	st_ParmanentAddress.Address,
	st_ParmanentAddress.PostalCode,
	st_ParmanentAddress.PostOffice,
	(select Division from bs_Division where bs_Division.Id=st_ParmanentAddress.DivisionId) as DivName,
	(select District  from bs_District where bs_District.Id=st_ParmanentAddress.DistrictId) as DisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_ParmanentAddress.ThanaId) as Thana,
	st_PresentAddress.DivisionId as presentDiv,
	st_PresentAddress.DistrictId as presentDis,
	st_PresentAddress.ThanaId as presentThana,
	st_PresentAddress.PostOffice as presentPO,
	st_PresentAddress.PostalCode as presentPC,
	st_PresentAddress.Address as presentAddress,
	(select Division from bs_Division where bs_Division.Id=st_PresentAddress.DivisionId) as presentDivName,
	(select District  from bs_District where bs_District.Id=st_PresentAddress.DistrictId) as presentDisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_PresentAddress.ThanaId) as presentThanaName,

	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEduId,
	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEdu,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProId,

	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEdu,
	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEduId,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfessionId

	from st_Person 
	inner join Users on st_Person.UserId=Users.Id
	left outer join ss_Student on st_Person.Id=ss_Student.PersonId
	left outer join er_StudentToClass on ss_Student.Id=er_StudentToClass.StudentId
	left outer join bs_ClassName on er_StudentToClass.ClassId=bs_ClassName.Id
	left outer join bs_Group on er_StudentToClass.GroupId=bs_Group.Id
	left outer join bs_Shift on er_StudentToClass.ShiftId=bs_Shift.Id
	left outer join bs_Section on er_StudentToClass.SectionId=bs_Section.Id
	left outer join bs_Gender on st_Person.GenderId=bs_Gender.Id
	left outer join bs_Religion on st_Person.ReligionId=bs_Religion.Id
	left outer join bs_BloodGroup on st_Person.BloodGroup=bs_BloodGroup.Id
	left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId
	left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId
	where st_Person.Id=@PersonId and er_StudentToClass.Year = (select MAX(er_StudentToClass.Year) from er_StudentToClass where er_StudentToClass.StudentId=ss_Student.Id)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_ImageUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Person_ImageUpdate] (
@PersonId int,
@Photo nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	PersonImage=@Photo
	where Id=@PersonId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_MotherImageUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Person_MotherImageUpdate] (
@PersonId int,
@Photo nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	MotherImage=@Photo
	where Id=@PersonId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_PermanentAddressInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_PermanentAddressInsert] (
@PersonId int,
@DivisionId int,	
@DistrictId int,
@ThanaId int,
@PostOffice nvarchar(250),
@PostCode nvarchar(50),
@Address nvarchar(256)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	insert into st_ParmanentAddress(
	PersonId,DivisionId,DistrictId,ThanaId,PostOffice,PostalCode,Address) values(@PersonId,@DivisionId,@DistrictId,@ThanaId,@PostOffice,@PostCode,@Address)
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_PermanentAddressUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_PermanentAddressUpdate] (
@PersonId int,
@DivisionId int,	
@DistrictId int,
@ThanaId int,
@PostOffice nvarchar(250),
@PostCode nvarchar(50),
@Address nvarchar(256)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from st_ParmanentAddress where PersonId=@PersonId)
		begin
			update st_ParmanentAddress set
			DivisionId=@DivisionId,
			DistrictId=@DistrictId,
			ThanaId=@ThanaId,
			PostOffice=@PostOffice,
			PostalCode=@PostCode,
			Address=@Address

			where PersonId=@PersonId
		end
	else
		begin
			insert into st_ParmanentAddress(
	PersonId,DivisionId,DistrictId,ThanaId,PostOffice,PostalCode,Address) values(@PersonId,@DivisionId,@DistrictId,@ThanaId,@PostOffice,@PostCode,@Address)
		end


	
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_PersonalInfoInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_PersonalInfoInsert] (
@NameEng nvarchar(250),
@NameBan nvarchar(250),
@GenderId int,
@ReligionId int,	
@Nationality nvarchar(250),
@DateofBirth datetime,
@BirthCertificate nvarchar(250),
@PhoneNo nvarchar(250),
@Mobile nvarchar(250),
@PhoneHome nvarchar(250),
@MobileHome nvarchar(250),
@Email nvarchar(250),
@Fax nvarchar(250),
@BloodGroup nvarchar(250),
@PersonImage nvarchar(250),
@UserId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
			insert into st_Person(
			NameEng,
			NameBan,
			GenderId,
			ReligionId,	
			Nationality,
			DateofBirth,
			BirthCertificate,
			PhoneNo,
			Mobile,
			PhoneHome,
			MobileHome,
			Email,
			Fax,
			BloodGroup,
			PersonImage ,
			UserId) values(
			@NameEng,
			@NameBan,
			@GenderId,
			@ReligionId,	
			@Nationality,
			@DateofBirth,
			@BirthCertificate,
			@PhoneNo,
			@Mobile,
			@PhoneHome,
			@MobileHome,
			@Email,
			@Fax,
			@BloodGroup,
			@PersonImage ,
			@UserId
			)
			select SCOPE_IDENTITY()
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_PresentAddressInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_PresentAddressInsert] (
@PersonId int,
@DivisionId int,	
@DistrictId int,
@ThanaId int,
@PostOffice nvarchar(250),
@PostCode nvarchar(50),
@Address nvarchar(256)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	insert into st_PresentAddress(
	PersonId,DivisionId,DistrictId,ThanaId,PostOffice,PostalCode,Address) values(@PersonId,@DivisionId,@DistrictId,@ThanaId,@PostOffice,@PostCode,@Address)
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_PresentAddressUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_PresentAddressUpdate] (
@PersonId int,
@DivisionId int,	
@DistrictId int,
@ThanaId int,
@PostOffice nvarchar(250),
@PostCode nvarchar(50),
@Address nvarchar(256)
)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	IF EXISTS (select * from st_PresentAddress where PersonId=@PersonId)
		begin
			update st_PresentAddress set
			DivisionId=@DivisionId,
			DistrictId=@DistrictId,
			ThanaId=@ThanaId,
			PostOffice=@PostOffice,
			PostalCode=@PostCode,
			Address=@Address
			where PersonId=@PersonId
		end
	else
		begin
			insert into st_PresentAddress(
	PersonId,DivisionId,DistrictId,ThanaId,PostOffice,PostalCode,Address) values(@PersonId,@DivisionId,@DistrictId,@ThanaId,@PostOffice,@PostCode,@Address)
		end

	
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Person_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Person_Update] (
@Id int,
@NameEng nvarchar(250),
@NameBan nvarchar(250),
@Gender int,
@ReligionId int,	
@Nationality nvarchar(250),
@DateofBirth datetime,
@BirthCertificate nvarchar(50),
@PhoneNo nvarchar(250),
@Mobile nvarchar(250),
@PhoneHome nvarchar(250),
@MobileHome nvarchar(250),
@Email nvarchar(250),
@Fax nvarchar(250),
@BloodGroup nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update st_Person set
	NameEng=@NameEng,
	NameBan=@NameBan,
	GenderId=@Gender,
	ReligionId=@ReligionId,	
	Nationality=@Nationality,
	DateofBirth=@DateofBirth,
	BirthCertificate=@BirthCertificate,
	PhoneNo=@PhoneNo,
	Mobile=@Mobile,
	PhoneHome=@PhoneHome,
	MobileHome=@MobileHome,
	Email=@Email,
	Fax=@Fax,
	BloodGroup=@BloodGroup

	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PersonId_GetByUserName]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_PersonId_GetByUserName] (
@UserName nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select p.Id from Users u inner join st_Person p on p.UserId=u.Id where u.UserName=@UserName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Profession_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Profession_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Profession where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Profession_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Profession_Insert] (
@Profession nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Profession where Profession=@Profession)
		begin
			select -1
		end
	else
		begin
			insert into bs_Profession(Profession) values (@Profession)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Profession_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Profession_Update] (
@Id int,
@Profession nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Profession set
	Profession=@Profession
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Publisher_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Publisher_Insert] (
@Publisher nvarchar(100)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from lb_Publisher where Publisher=@Publisher)
		begin
			select -1
		end
	else
		begin
			insert into lb_Publisher(Publisher) values (@Publisher)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Qualification_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Qualification_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Qualification where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Qualification_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Qualification_Insert] (
@Qualification nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Qualification where Qualification=@Qualification)
		begin
			select -1
		end
	else
		begin
			insert into bs_Qualification(Qualification) values (@Qualification)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Qualification_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Qualification_Update] (
@Id int,
@Qualification nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Qualification set
	Qualification=@Qualification
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Quota_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_Quota_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Quota where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Quota_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_Quota_Insert] (
@Quota nvarchar(50),
@Percentage decimal(18,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Quota where QuotaName=@Quota)
		begin
			select -1
		end
	else
		begin
			insert into bs_Quota(QuotaName,QuotaPercent) values (@Quota,@Percentage)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Quota_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_Quota_Update] (
@Id int,
@Quota nvarchar(50),
@Percentage decimal(18,2)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Quota set
	QuotaName=@Quota,QuotaPercent=@Percentage
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_RegistrationNo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_RegistrationNo] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select RegNo from bs_RegistrationNo 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_RegistrationNo_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_RegistrationNo_Update] 
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_RegistrationNo
	set RegNo=RegNo+1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Religion_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Religion_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Religion where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Religion_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Religion_Insert] (
@Religion nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Religion where Religion=@Religion)
		begin
			select -1
		end
	else
		begin
			insert into bs_Religion(Religion) values (@Religion)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Religion_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Religion_Update] (
@Id int,
@Religion nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Religion set
	Religion=@Religion
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_GetforStudentIdCard]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Report_GetforStudentIdCard] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	set @sql='select st_Person.NameEng,bs_BloodGroup.BloodGroup,bs_ClassName.ClassName, bs_Group.GroupName, bs_Shift.Shift,bs_Section.Section,
			ss_Student.RegNo,er_StudentToClass.RollNo,er_StudentToClass.Year, st_Person.Mobile,st_Person.PersonImage
			from er_StudentToClass 
			inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id
			inner join st_Person on ss_Student.PersonId=st_Person.Id
			inner join bs_ClassName on er_StudentToClass.ClassId=bs_ClassName.Id
			inner join bs_Group on er_StudentToClass.GroupId=bs_Group.Id
			inner join bs_Shift on er_StudentToClass.ShiftId=bs_Shift.Id
			inner join bs_Section on er_StudentToClass.SectionId=bs_Section.Id
			left outer join bs_BloodGroup on st_Person.BloodGroup=bs_BloodGroup.Id where '+@Criteria

EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_GetMarks]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Report_GetMarks] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	declare @year nvarchar(10)
	declare @class nvarchar(10)
	declare @group nvarchar(10)
	set @year=SUBSTRING(@Criteria,23,4)
	set @class=SUBSTRING(@Criteria,58,2)
	set @group=SUBSTRING(@Criteria,90,2)
	

	if(@Criteria<>'')
	begin
	   set @sql='select rs_ObtainMarks.*,er_StudentToClass.ClassId,er_StudentToClass.GroupId,er_StudentToClass.ShiftId,er_StudentToClass.SectionId,
st_Person.NameEng,st_Person.FatherNameEng,st_Person.MotherNameEng,er_SubjectToClass.SubjectId as SubId,er_SubjectToClass.PaperNo,er_SubjectToClass.CategoryId,er_SubjectToClass.IsOptional,
ss_Student.RegNo,bs_SubjectName.SubjectName,
SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks as Total,  
(select Max(SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks) 
   from rs_ObtainMarks inner join er_StudentToClass on rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id 
   where rs_ObtainMarks.YearId='+@year+' and er_StudentToClass.ClassId='+@class+' and er_StudentToClass.GroupId='+@group+') as highest,
''FFF'' as GradeLetter,''-1111'' as GradePoint,
	case when BaseMarks=50.00 
		 then
			cast(((SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks)*100)/BaseMarks as decimal(5,2))
		 else
		    cast((SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks)as decimal(5,2)) end as ConvertedMarks

from rs_ObtainMarks
inner join er_StudentToClass on rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id
inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id
inner join st_Person on ss_Student.PersonId=st_Person.Id 
inner join er_SubjectToClass on rs_ObtainMarks.SubjectId=er_SubjectToClass.Id
inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where ' + @Criteria +' order by ss_Student.RegNo'
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_GetStudentAttendence]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Report_GetStudentAttendence] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select st_Person.*,ss_Attendence.Date,ss_Attendence.Year as AttendenceYear, ss_Attendence.CreatedBy,ss_Attendence.IsPresent, ss_Student.Id as StudentId,ss_Student.RegNo,er_StudentToClass.Id as StudentToClassId,
	   (select ClassName from bs_ClassName where bs_ClassName.Id=er_StudentToClass.ClassId) as Class,
	   (select GroupName from bs_Group where bs_Group.Id=er_StudentToClass.GroupId) as GroupName,
	   (select Shift from bs_Shift where bs_Shift.Id=er_StudentToClass.ShiftId) as Shift,
	   (select Section from bs_Section where bs_Section.Id=er_StudentToClass.SectionId) as Section
	   
        from ss_Student  
		inner join er_StudentToClass on ss_Student.Id=er_StudentToClass.StudentId
		inner join st_Person on ss_Student.PersonId=st_Person.Id
		inner join ss_Attendence on er_StudentToClass.Id=ss_Attendence.StudentToClassId where ' + @Criteria
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_GetSubjectMarks]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Report_GetSubjectMarks] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	declare @year nvarchar(10)
	declare @class nvarchar(10)
	declare @group nvarchar(10)
	set @year=SUBSTRING(@Criteria,23,4)
	set @class=SUBSTRING(@Criteria,58,2)
	set @group=SUBSTRING(@Criteria,90,2)
	

	if(@Criteria<>'')
	begin
	   set @sql='select rs_ObtainMarks.*,er_StudentToClass.ClassId,er_StudentToClass.GroupId,er_StudentToClass.ShiftId,er_StudentToClass.SectionId,
st_Person.NameEng,st_Person.FatherNameEng,st_Person.MotherNameEng,er_SubjectToClass.SubjectId as SubId,er_SubjectToClass.PaperNo,er_SubjectToClass.CategoryId,er_SubjectToClass.IsOptional,
ss_Student.RegNo,
case when er_SubjectToClass.PaperNo=0
		 then
			case when IsOptional=0 then SubjectName else SubjectName+'' (op)'' end
		 else
			case when IsOptional=0 then SubjectName+''-''+ cast(PaperNo as nvarchar(50)) else SubjectName+''-''+ cast(PaperNo as nvarchar(50))+'' (Op)'' end
	end as SubjectName,
SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks as Total,  
(select Max(SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks) 
   from rs_ObtainMarks as a inner join er_StudentToClass on a.StudentToClassId=er_StudentToClass.Id 
   where a.YearId=2014 and er_StudentToClass.ClassId=6 and er_StudentToClass.GroupId=1 and a.SubjectId=rs_ObtainMarks.SubjectId) as highest,
''FFF'' as GradeLetter,''-1111'' as GradePoint,
	case when BaseMarks=50.00 
		 then
			cast(((SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks)*100)/BaseMarks as decimal(5,2))
		 else
		    cast((SubjectiveMarks+ObjectiveMarks+PracticalMarks+OtherMarks)as decimal(5,2)) end as ConvertedMarks

from rs_ObtainMarks 
inner join er_StudentToClass on rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id
inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id
inner join st_Person on ss_Student.PersonId=st_Person.Id 
inner join er_SubjectToClass on rs_ObtainMarks.SubjectId=er_SubjectToClass.Id
inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where ' + @Criteria +' order by ss_Student.RegNo'
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_GetTeacherInfo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Report_GetTeacherInfo]
	
AS
BEGIN
	SET NOCOUNT ON;
	select st_Person.*,
		st_PresentAddress.*,
		st_ParmanentAddress.*,
		tr_Teacher.Id as TeacherId,
		tr_Teacher.TeacherPin,
		tr_Teacher.Joindate,
		tr_Teacher.NId,
bs_Designation.Designation,
bs_SchoolInformation.*,bs_SchoolInformation.Address as SchoolAddress
		from tr_Teacher 
		inner join st_Person on tr_Teacher.PersonId=st_Person.Id 
		inner join bs_Designation on tr_Teacher.DesignationId=bs_Designation.Id
		inner join bs_Gender on st_Person.GenderId=bs_Gender.Id
		left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId 
		left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId
		Cross join bs_SchoolInformation
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_StudentInfo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_Report_StudentInfo] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select st_Person.*,ss_Student.Id as StudentId,ss_Student.RegNo as RegistrationNo,er.Id as StudentToClassId,er.RollNo,
       (select ClassName from bs_ClassName where bs_ClassName.Id=er.ClassId) as Class,
       (select GroupName from bs_Group where bs_Group.Id=er.GroupId) as GroupName,
       (select Shift from bs_Shift where bs_Shift.Id=er.ShiftId) as Shift,
       (select Section from bs_Section where bs_Section.Id=er.SectionId) as Section,g.Gender,r.Religion
	   
        from ss_Student  
        inner join er_StudentToClass er on ss_Student.Id=er.StudentId
        inner join st_Person on ss_Student.PersonId=st_Person.Id
        inner join bs_Gender g on g.Id=st_Person.GenderId
        inner join bs_Religion r on r.Id=st_Person.ReligionId where ' + @Criteria
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Report_SubjectToClass]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Report_SubjectToClass] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select er_SubjectToClass.*,bs_ClassName.ClassName,bs_Group.GroupName,
	case when er_SubjectToClass.PaperNo=0 
		 then
			SubjectName
		 else
		   SubjectName+'-'+ cast(PaperNo as nvarchar(50)) end as SubjectName
	 from er_SubjectToClass 
	inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id
	inner join bs_ClassName on er_SubjectToClass.ClassId=bs_ClassName.Id
	inner join bs_Group on er_SubjectToClass.GroupId=bs_Group.Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Result_MarksDetails]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Result_MarksDetails] (
@StudentToClassId int,
@Year int,
@ExamType int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select r.ExamTypeId,r.Grade,r.GradePoint,r.Positions,r.StudentToClassId,r.SubjectId,r.YearId,b.SubjectName,c.TotalSubject,
(select SUM(q.ActualMarks) from rs_Result q where q.StudentToClassId=r.StudentToClassId and q.ExamTypeId=r.ExamTypeId and q.YearId=r.YearId) TotalMarks,
r.ActualMarks as Marks,
 (select Max(s.ActualMarks) from rs_Result s inner join er_StudentToClass es on es.Id=s.StudentToClassId
where s.ExamTypeId=r.ExamTypeId and s.YearId=r.YearId and s.SubjectId=r.SubjectId and es.ClassId=e.ClassId) MaxSubMarks,
(select Count(*) from er_SubjectToClass sb inner join er_SubjectToStudent ss on ss.SubjectId=sb.Id where ss.IsOptional=1 
and ss.StudentToClassId=r.StudentToClassId and sb.ClassId=e.ClassId and sb.SubjectId=b.Id) IsOptional,
(select TOP(1) sb.ResultCount from er_SubjectToClass sb where sb.ClassId=e.ClassId and sb.SubjectId=b.Id) ResultCount,
(Select COUNT(*) from ss_Attendence a where a.IsPresent=1 and a.StudentToClassId=r.StudentToClassId) Attendance,
(select COUNT(*) from rs_Result q where q.GradePoint=0 and q.StudentToClassId=r.StudentToClassId and q.ExamTypeId=r.ExamTypeId and q.YearId=r.YearId) FailedIn
 from rs_Result r
inner join bs_SubjectName b on b.Id=r.SubjectId
inner join er_StudentToClass e on e.Id=r.StudentToClassId
inner join bs_ClassName c on c.Id=e.ClassId
Where r.YearId=@Year and r.StudentToClassId=@StudentToClassId and r.ExamTypeId=@ExamType
Order by r.StudentToClassId,b.Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_RFID_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 06-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_RFID_Insert] (
@cardNumber nvarchar(500),
@LocationId nvarchar(100),
@GateNo nvarchar(100)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
		begin
			insert into RFID(CardNumber,GateNo,LocationId)
                      values (@cardNumber,@LocationId,@GateNo)
                      
			select SCOPE_IDENTITY()
		end
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_Delete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Role_Delete] (
@ID int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Delete from RoleSetup where Id=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Role_GetById] (
@ID int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select * from RoleSetup where Id=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_GetPriority]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Role_GetPriority] (
@RoleId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select Priority from RoleSetup where Id=@RoleId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_GetUnderPriority]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Role_GetUnderPriority] (
@Priority int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select * from RoleSetup where Priority>=@Priority
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Role_Insert] (
@RoleName nvarchar(50),
@Description nvarchar(50),
@ParentId int,
@Priority int,
@CreatedBy nvarchar(50),
@CreateDate date
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from RoleSetup where RoleName=@RoleName)
		begin
			select -1
		end
	else
		begin
			insert into RoleSetup(RoleName, [Description],ParentId ,Priority,CreateBy, CreateDate) 
			values 
		   (@RoleName,@Description,@ParentId,@Priority,@CreatedBy,@CreateDate)
			select SCOPE_IDENTITY()
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Role_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Role_Update] (
@ID int,
@RoleName nvarchar(50),
@Description nvarchar(50),
@ParentId int,
@Priority int,
@UpdateBy nvarchar(50),
@UpdateDate date
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from RoleSetup where RoleName=@RoleName and Priority=@Priority)
		begin
			select -1
		end
	else
		begin
			Update RoleSetup set 
			RoleName=@RoleName, 
			[Description]=@Description, 
			ParentId=@ParentId,
			Priority=@Priority,
			UpdateBy=@UpdateBy, 
			UpdateDate=@UpdateDate
			where Id= @ID
			select @ID
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Routine_AdmissionRoutineDelete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 17-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_Routine_AdmissionRoutineDelete] (
@CircularId int
)
AS
BEGIN
	SET NOCOUNT ON;
	Delete from ad_ExamSchedule 
	where CircularId=@CircularId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Routine_AdmissionRoutineInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 17-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_Routine_AdmissionRoutineInsert] (
@Xml nvarchar(MAX)
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into ad_ExamSchedule
	(
	  CircularId,ExamStartTime,ExamEndTime,ExamDate
	)
	SELECT CircularId,StartTime,EndTime,ExamDate
	FROM OPENXML(@pointerDoc, 'dsRoutine/dtRoutine',2)
	WITH (
		CircularId int,
		StartTime nvarchar(20),
		EndTime nvarchar(20),
		ExamDate date
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Routine_ClassRoutineInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Routine_ClassRoutineInsert] (
@Xml nvarchar(MAX),
@Year nvarchar(50),
@ClassId nvarchar(50),
@GroupId nvarchar(50),
@ShiftId nvarchar(50),
@SectionId nvarchar(50),
@Day nvarchar(50)
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into bs_ClassRoutine
	(
	  Year,ClassId,GroupId,ShiftId,SectionId,Day,Period,SubjectId,StartTime,EndTime,TeacherId
	)
	SELECT @Year,@ClassId,@GroupId,@ShiftId,@SectionId,@Day,PeriodNo,SubjectId,StartTime,EndTime,Teacher
	FROM OPENXML(@pointerDoc, 'dsRoutine/dtRoutine',2)
	WITH (
		PeriodNo int,
		SubjectId int,
		StartTime nvarchar(20),
		EndTime nvarchar(20),
		Teacher int
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Routine_ExamRoutineInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Routine_ExamRoutineInsert] (
@Xml nvarchar(MAX),
@Year int,
@ClassId int,
@GroupId int,
@ShiftId int,
@ExamTypeId int
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into bs_ExamRoutine
	(
	  Year,ClassId,GroupId,ShiftId,SubjectId,StartTime,EndTime,ExamDate,ExamTypeId
	)
	SELECT @Year,@ClassId,@GroupId,@ShiftId,SubjectId,StartTime,EndTime,ExamDate,@ExamTypeId
	FROM OPENXML(@pointerDoc, 'dsRoutine/dtRoutine',2)
	WITH (
		SubjectId int,
		StartTime nvarchar(20),
		EndTime nvarchar(20),
		ExamDate nvarchar(30)
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Routine_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Routine_GetByCriteria] (
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select distinct cr.Period,(Select top(1) cl from (Select Period,StartTime+''-''+EndTime+''/ ''+(select case when er_SubjectToClass.PaperNo=0 then SubjectName else SubjectName+''-''+ 
cast(PaperNo as nvarchar(50)) end as SubjectName from er_SubjectToClass inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where er_SubjectToClass.Id=csr.SubjectId)
	 +''/ ''+(select NameEng from st_Person tr where tr.Id=csr.TeacherId) as cl, Day from bs_ClassRoutine csr where '+@Criteria+') as t where t.Day=''Saturday'' and t.Period=cr.Period) as ''Saturday'',
	 
	 (Select top(1) cl from (Select Period,StartTime+''-''+EndTime+''/ ''+CHAR(10)+(select case when er_SubjectToClass.PaperNo=0 then SubjectName else SubjectName+''-''+ 
cast(PaperNo as nvarchar(50)) end as SubjectName from er_SubjectToClass inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where er_SubjectToClass.Id=csr.SubjectId)
	 +''/ ''+(select NameEng from st_Person tr where tr.Id=csr.TeacherId) as cl, Day from bs_ClassRoutine csr where '+@Criteria+') as t where t.Day=''Sunday'' and t.Period=cr.Period) as ''Sunday'',
	 
	 (Select top(1) cl from (Select Period,StartTime+''-''+EndTime+''/ ''+(select case when er_SubjectToClass.PaperNo=0 then SubjectName else SubjectName+''-''+ 
cast(PaperNo as nvarchar(50)) end as SubjectName from er_SubjectToClass inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where er_SubjectToClass.Id=csr.SubjectId)
	 +''/ ''+(select NameEng from st_Person tr where tr.Id=csr.TeacherId) as cl, Day from bs_ClassRoutine csr where '+@Criteria+') as t where t.Day=''Monday'' and t.Period=cr.Period) as ''Monday'',
	 
	 (Select top(1) cl from (Select Period,StartTime+''-''+EndTime+''/ ''+(select case when er_SubjectToClass.PaperNo=0 then SubjectName else SubjectName+''-''+ 
cast(PaperNo as nvarchar(50)) end as SubjectName from er_SubjectToClass inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where er_SubjectToClass.Id=csr.SubjectId)
	 +''/ ''+(select NameEng from st_Person tr where tr.Id=csr.TeacherId) as cl, Day from bs_ClassRoutine csr where '+@Criteria+') as t where t.Day=''Tuesday'' and t.Period=cr.Period) as ''Tuesday'',
	 
	 (Select top(1) cl from (Select Period,StartTime+''-''+EndTime+''/ ''+(select case when er_SubjectToClass.PaperNo=0 then SubjectName else SubjectName+''-''+ 
cast(PaperNo as nvarchar(50)) end as SubjectName from er_SubjectToClass inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where er_SubjectToClass.Id=csr.SubjectId)
	 +''/ ''+(select NameEng from st_Person tr where tr.Id=csr.TeacherId) as cl, Day from bs_ClassRoutine csr where '+@Criteria+') as t where t.Day=''Wednesday'' and t.Period=cr.Period) as ''Wednesday'',
	
	 (Select top(1) cl from (Select Period,StartTime+''-''+EndTime+''/ ''+(select case when er_SubjectToClass.PaperNo=0 then SubjectName else SubjectName+''-''+ 
cast(PaperNo as nvarchar(50)) end as SubjectName from er_SubjectToClass inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id where er_SubjectToClass.Id=csr.SubjectId)
	 +''/ ''+(select NameEng from st_Person tr where tr.Id=csr.TeacherId) as cl, Day from bs_ClassRoutine csr where '+@Criteria+') as t where t.Day=''Thursday'' and t.Period=cr.Period) as ''Thursday''
	 
	 from bs_ClassRoutine cr where '+@Criteria 
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Routine_GetExamRoutineByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Routine_GetExamRoutineByCriteria] (
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select bs_ExamRoutine.*,(bs_ExamRoutine.StartTime+'' - ''+bs_ExamRoutine.EndTime)  as ExamTime,
case when er_SubjectToClass.PaperNo=0 
		 then
			SubjectName
		 else
		   SubjectName+''-''+ cast(PaperNo as nvarchar(50)) end as SubjectName
	 from bs_ExamRoutine inner join er_SubjectToClass 
	 on bs_ExamRoutine.SubjectId=er_SubjectToClass.Id inner join bs_SubjectName 
	 on er_SubjectToClass.SubjectId=bs_SubjectName.Id where '+@Criteria 
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Rt_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 30-04-2017
-- =============================================
Create PROCEDURE [dbo].[USP_Rt_GetAll] 
AS
BEGIN
	SET NOCOUNT ON;

Select p.*,s.Shift from rt_Period p inner join bs_Shift s on s.Id=p.ShiftId

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Rt_InsertPeriod]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 30-04-2017
-- =============================================
Create PROCEDURE [dbo].[USP_Rt_InsertPeriod] (
@Period nvarchar(50),
@StartTime  nvarchar(50),
@EndTime  nvarchar(50),
@Orders  int,
@ShiftId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from rt_Period where Period=@Period and ShiftId=@ShiftId)
		begin
			select -1
		end
	else
		begin
			insert into rt_Period(Period,StartTime,EndTime,Orders,ShiftId) values (@Period,@StartTime,@EndTime,@Orders,@ShiftId)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Rt_PeriodGetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 30-04-2017
-- =============================================
Create PROCEDURE [dbo].[USP_Rt_PeriodGetById] 
(
@Id int
)
AS
BEGIN
	SET NOCOUNT ON;

Select * from rt_Period Where Id=@Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Rt_UpdatePeriod]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 30-04-2017
-- =============================================
Create PROCEDURE [dbo].[USP_Rt_UpdatePeriod] (
@Id int,
@Period nvarchar(50),
@StartTime  nvarchar(50),
@EndTime  nvarchar(50),
@Orders  int,
@ShiftId int
)
	
AS
BEGIN
	SET NOCOUNT ON;

Update rt_Period set Period=@Period,StartTime=@StartTime,EndTime=@EndTime,Orders=@Orders,ShiftId=@ShiftId
Where Id=@Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Section_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Section_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Section where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Section_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Section_Insert] (
@Section nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Section where Section=@Section)
		begin
			select -1
		end
	else
		begin
			insert into bs_Section(Section) values (@Section)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Section_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Section_Update] (
@Id int,
@Section nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Section set
	Section=@Section
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Setting_GeneralSettingUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Setting_GeneralSettingUpdate] (
@Theme nvarchar(20),
@DateFormat nvarchar(20),
@TimeZone nvarchar(5),
@Button nvarchar(20),
@Panel nvarchar(20)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update bs_GeneralSetting set Theme=@Theme,DateFormat=@DateFormat,TimeZone=@TimeZone,Button=@Button,Panel=@Panel
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Setting_GetNotificationById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Setting_GetNotificationById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Notification where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Setting_NotificationInset]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Setting_NotificationInset] (
@Title nvarchar(250),
@SendEmail bit,
@SendSMS bit
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Insert into bs_Notification(Title, SendEmail, SendSMS) Values(@Title, @SendEmail, @SendSMS)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Setting_SchoolInfoUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Setting_SchoolInfoUpdate] (
@Name nvarchar(250),
@Code nvarchar(20),
@Year nvarchar(5),
@EstdBy nvarchar(50),
@Address nvarchar(250),
@Description nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update bs_SchoolInformation set 
	Name=@Name,
	Code=@Code,
	EstablishedYear=@Year,
	EstablishedBy=@EstdBy,
	Address=@Address,
	Description=@Description
	where Id=1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Setting_SMSGetwayUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Setting_SMSGetwayUpdate] (
@URL nvarchar(250),
@UserName nvarchar(50),
@Password nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update bs_SMSGetway set URL=@URL,UserName=@UserName,Password=@Password
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Shift_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Shift_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Shift where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Shift_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Shift_Insert] (
@Shift nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Shift where Shift=@Shift)
		begin
			select -1
		end
	else
		begin
			insert into bs_Shift(Shift) values (@Shift)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Shift_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Shift_Update] (
@Id int,
@Shift nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Shift set
	Shift=@Shift
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SMSTemplete_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_SMSTemplete_GetById] (
	@Id int
)
AS
BEGIN
	select * from SMSTemplete	
	where Id=@Id
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SMSTemplete_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_SMSTemplete_Insert] (
	@Name nvarchar(250),
	@Variable nvarchar(500),
	@Message	Text
)
AS
BEGIN
if exists(select * from SMSTemplete where Name=@Name)
	select -1
else
Begin
	
	INSERT INTO SMSTemplete
	(
		Name,
		Variable,
		Message
	)
	VALUES
	(
		@Name,@Variable,@Message
	)
	select SCOPE_IDENTITY()
end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SMSTemplete_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_SMSTemplete_Update] (
	@Id int,
	@Name nvarchar(250),
	@Variable nvarchar(500),
	@Message	Text
)
AS
BEGIN
	Update SMSTemplete set
	Name=@Name,
	Variable=@Variable,
	Message=@Message
	where Id=@Id
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_StaticContent_GetByPageName]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_StaticContent_GetByPageName]
	@PageName nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
    select * from bs_StaticContent
	 where PageName=@PageName
	 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_StaticContent_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_StaticContent_Update]
	@PageName nvarchar(50),
	@Content nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
    
    update bs_StaticContent set
	 Contents=@Content
	 where PageName=@PageName
    
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_AttendenceByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Student_AttendenceByCriteria] (
@Criteria nvarchar(max),
@Date datetime,
@AttendanceType int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select ss_Attendence.*,st_Person.NameEng from ss_Attendence inner join er_StudentToClass
	on ss_Attendence.StudentToClassId=er_StudentToClass.Id inner join ss_Student
	on er_StudentToClass.StudentId=ss_Student.Id inner join st_Person
	on ss_Student.PersonId=st_Person.Id where ' + @Criteria+' and ss_Attendence.Date='+cast(@Date as nvarchar(200))+' and ss_Attendence.AttendenceType='+@AttendanceType
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_AttendenceByDateAndType]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Student_AttendenceByDateAndType] (
@Date datetime,
@AttendanceType int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from ss_Attendence where Date=@Date and AttendenceType=@AttendanceType
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_AttendenceInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 04-05-2017
-- =============================================
Create PROCEDURE [dbo].[USP_Student_AttendenceInsert] (
@Year nvarchar(50),
@Month nvarchar(50),
@Date datetime,
@CreatedBy nvarchar(50),
@StudentToClassId int,
@IsPresent bit,
@AttendenceType int
)
	
AS
BEGIN

	SET NOCOUNT ON;
	IF EXISTS (select * from ss_Attendence where StudentToClassId=@StudentToClassId and Date=@Date)
		begin
			Update ss_Attendence set IsPresent=@IsPresent,AttendenceType=@AttendenceType where StudentToClassId=@StudentToClassId and Date=@Date
		end
	else
		begin
			INSERT Into ss_Attendence(StudentToClassId,IsPresent,AttendenceType,Year,Month,Date,CreatedBy)
			values(@StudentToClassId,@IsPresent,@AttendenceType,@Year,@Month,@Date,@CreatedBy)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_AttendenceInsertXML]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Student_AttendenceInsertXML] (
@XML nvarchar(max),
@Year nvarchar(50),
@Month nvarchar(50),
@Date datetime,
@CreatedBy nvarchar(50)
)
	
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	INSERT Into ss_Attendence
	(
	  StudentToClassId,IsPresent,AttendenceType,Year,Month,Date,CreatedBy,CreatedDate
	)
	SELECT StId,Present,TypeAtt,@Year,@Month,@Date,@CreatedBy,GETDATE()
	FROM OPENXML(@pointerDoc, 'dsAttendence/dtAttendence',2)
	WITH (
		StId int,
		Present bit,
		TypeAtt tinyint

	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_ClassInfoByUserId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_ClassInfoByUserId] (
@UserId nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select er_StudentToClass.Id,ss_Student.RegNo,er_StudentToClass.Year,er_StudentToClass.StudentId,er_StudentToClass.ClassId,er_StudentToClass.GroupId,er_StudentToClass.ShiftId,er_StudentToClass.SectionId
	from st_Person inner join ss_Student on
	st_Person.Id=ss_Student.PersonId inner join 
	er_StudentToClass on ss_Student.Id=er_StudentToClass.StudentId where er_StudentToClass.Id=(select Max(Id) from er_StudentToClass where StudentId=ss_Student.Id) and st_Person.UserId=@UserId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetAttendenceByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Student_GetAttendenceByCriteria] (
@Criteria nvarchar(max),
@StudentToClassId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select ss_Attendence.*,st_Person.NameEng from ss_Attendence inner join er_StudentToClass
	on ss_Attendence.StudentToClassId=er_StudentToClass.Id inner join ss_Student
	on er_StudentToClass.StudentId=ss_Student.Id inner join st_Person
	on ss_Student.PersonId=st_Person.Id where ss_Attendence.StudentToClassId='+cast(@StudentToClassId as nvarchar(10))+' and ' + @Criteria+' order by ss_Attendence.Date asc'
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetByAllClass]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[USP_Student_GetByAllClass] 
(
@Year int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select count(er_StudentToClass.Id) as Student,bs_ClassName.ClassName from er_StudentToClass inner join bs_ClassName
on er_StudentToClass.ClassId=bs_ClassName.Id where er_StudentToClass.Year=@Year group by ClassId,ClassName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_GetByCriteria] (
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	set @sql='select distinct er_StudentToClass.Id as StudentToClassId,er_StudentToClass.*,
				st_Person.*,bs_ClassName.ClassName,bs_Group.GroupName,bs_Shift.Shift,bs_Section.Section,Users.UserName
				from er_StudentToClass 
				inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id
				inner join st_Person on ss_Student.PersonId=st_Person.Id 
				inner join bs_ClassName on er_StudentToClass.ClassId=bs_ClassName.Id
				inner join bs_Group on er_StudentToClass.GroupId=bs_Group.Id
				inner join bs_Shift on er_StudentToClass.ShiftId=bs_Shift.Id
				inner join bs_Section on er_StudentToClass.SectionId=bs_Section.Id
				left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId
				inner join Users on Users.Id=st_Person.UserId
				left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId where ' +@Criteria+' order by er_StudentToClass.RollNo asc'

	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Student_GetById] (
@Id int
)
	
AS
BEGIN
	Select st_Person.*,
	ss_Student.RegNo as RegistrationNo,
	bs_BloodGroup.BloodGroup as BloodGroupName,
	bs_Gender.Gender,
	bs_Religion.Religion,
	st_ParmanentAddress.DivisionId,
	st_ParmanentAddress.DistrictId,
	st_ParmanentAddress.ThanaId,
	st_ParmanentAddress.Address,
	st_ParmanentAddress.PostalCode,
	st_ParmanentAddress.PostOffice,
	(select Division from bs_Division where bs_Division.Id=st_ParmanentAddress.DivisionId) as DivName,
	(select District  from bs_District where bs_District.Id=st_ParmanentAddress.DistrictId) as DisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_ParmanentAddress.ThanaId) as Thana,
	st_PresentAddress.DivisionId as presentDiv,
	st_PresentAddress.DistrictId as presentDis,
	st_PresentAddress.ThanaId as presentThana,
	st_PresentAddress.PostOffice as presentPO,
	st_PresentAddress.PostalCode as presentPC,
	st_PresentAddress.Address as presentAddress,
	(select Division from bs_Division where bs_Division.Id=st_PresentAddress.DivisionId) as presentDivName,
	(select District  from bs_District where bs_District.Id=st_PresentAddress.DistrictId) as presentDisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_PresentAddress.ThanaId) as presentThanaName,

	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEduId,
	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEdu,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProId,

	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEdu,
	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEduId,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfessionId

	from ss_Student 
	inner join st_Person on ss_Student.PersonId=st_Person.Id 
	left outer join bs_Gender on st_Person.GenderId=bs_Gender.Id
	left outer join bs_Religion on st_Person.ReligionId=bs_Religion.Id
	left outer join bs_BloodGroup on st_Person.BloodGroup=bs_BloodGroup.Id
	left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId
	left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId where st_Person.Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetByPersonId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Student_GetByPersonId] (
@PersonId int
)
	
AS
BEGIN
	select * from ss_Student where PersonId=@PersonId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetForMarksEdit]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_GetForMarksEdit] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	set @sql='select distinct * from rs_ObtainMarks inner join er_StudentToClass on rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id
inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id
inner join st_Person on ss_Student.PersonId=st_Person.Id 
left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId 
left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId  where ' +@Criteria+'  order by er_StudentToClass.RollNo'
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetInformationByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Student_GetInformationByCriteria] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)

	if(@Criteria<>'')
	begin
	   set @sql='select st_Person.*,ss_Student.Id as StudentId,ss_Student.RegNo as RegistrationNo,er_StudentToClass.Id as StudentToClassId,er_StudentToClass.RollNo,er_StudentToClass.Year ,
	   (select ClassName from bs_ClassName where bs_ClassName.Id=er_StudentToClass.ClassId) as Class,
	   (select GroupName from bs_Group where bs_Group.Id=er_StudentToClass.GroupId) as GroupName,
	   (select Shift from bs_Shift where bs_Shift.Id=er_StudentToClass.ShiftId) as Shift,
	   (select Section from bs_Section where bs_Section.Id=er_StudentToClass.SectionId) as Section,g.Gender,r.Religion,ss_Student.CardNo
	   
        from ss_Student  
		inner join er_StudentToClass on ss_Student.Id=er_StudentToClass.StudentId
		inner join st_Person on ss_Student.PersonId=st_Person.Id
		inner join bs_Gender g on g.Id=st_Person.GenderId
		inner join bs_Religion r on r.Id=st_Person.ReligionId where ' + @Criteria
		EXECUTE sp_executesql @sql
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetLastRoll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Student_GetLastRoll] (
@Criteria nvarchar(max)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	set @sql='select top(1) RollNo from er_StudentToClass where ' +@Criteria+' order by RollNo desc'
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetStudentSubjectWise]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_GetStudentSubjectWise] (
@ClassId int,
@GroupId int,
@SubjectId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	   select st_Person.*,ss_Student.Id as StudentId,ss_Student.RegNo,er_StudentToClass.RollNo, er_StudentToClass.Id as StudentToClassId,
	   (select ClassName from bs_ClassName where bs_ClassName.Id=er_StudentToClass.ClassId) as Class,
	   (select GroupName from bs_Group where bs_Group.Id=er_StudentToClass.GroupId) as GroupName,
	   (select Shift from bs_Shift where bs_Shift.Id=er_StudentToClass.ShiftId) as Shift,
	   (select Section from bs_Section where bs_Section.Id=er_StudentToClass.SectionId) as Section,
	   
	   (select SubjectiveMarks from rs_ObtainMarks where rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id and rs_ObtainMarks.SubjectId=@SubjectId) as SubjectiveMarks,
	   (select ObjectiveMarks from rs_ObtainMarks where rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id and rs_ObtainMarks.SubjectId=@SubjectId) as ObjectiveMarks,
	   (select PracticalMarks from rs_ObtainMarks where rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id and rs_ObtainMarks.SubjectId=@SubjectId) as PracticalMarks,
	   (select OtherMarks from rs_ObtainMarks where rs_ObtainMarks.StudentToClassId=er_StudentToClass.Id and rs_ObtainMarks.SubjectId=@SubjectId) as OtherMarks
	   
        from rs_ObtainMarks 
        inner join er_SubjectToStudent on rs_ObtainMarks.StudentToClassId=er_SubjectToStudent.StudentToClassId 
		inner join er_StudentToClass on er_SubjectToStudent.StudentToClassId=er_StudentToClass.Id
		inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id 
		inner join st_Person on ss_Student.PersonId= st_Person.Id
		where er_StudentToClass.ClassId=@ClassId and er_StudentToClass.GroupId=@GroupId and er_SubjectToStudent.SubjectId=@SubjectId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_GetWhoseMarksNotEntry]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_GetWhoseMarksNotEntry] (
@Criteria nvarchar(max),
@SubjectId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	set @sql='select distinct er_StudentToClass.Id as StudentToClassId,er_StudentToClass.*,
st_Person.*
from er_StudentToClass 
inner join ss_Student on er_StudentToClass.StudentId=ss_Student.Id
inner join st_Person on ss_Student.PersonId=st_Person.Id 
left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId 
left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId where ' +@Criteria +' and er_StudentToClass.Id not in (select rs_ObtainMarks.StudentToClassId from rs_ObtainMarks where SubjectId='+ cast(@SubjectId as nvarchar(50))+' and '+@Criteria+')  order by er_StudentToClass.RollNo '
	EXECUTE sp_executesql @sql
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_IDCard]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_IDCard] (
@RegNo nvarchar(50)
)
	
AS
BEGIN
SET NOCOUNT ON;
select s.RegNo STAFFID,p.NameEng EMPLOYEENAME,'Blood Group: '+bg.BloodGroup BLOODGROUP,p.PersonImage from ss_Student s
inner join st_Person p on p.Id=s.PersonId
left outer join bs_BloodGroup bg on bg.Id=p.BloodGroup
WHERE s.RegNo=@RegNo
	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_Insert] (
@PersonId int,
@RegNo nvarchar(50),
@AddmissionDate datetime,
@AddmissionYear nvarchar(50),
@CreatedBy nvarchar(50),
@CreatedDate datetime,
@ApplicationId bigint
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from ss_Student where RegNo=@RegNo)
		begin
		    delete  from st_Person where Id=@PersonId
			select -1
		end
	else
		begin
			insert into ss_Student(PersonId,RegNo,AdmissionDate,AdmissionYear,CreatedBy,CreatedDate,ApplicationId) values (
			@PersonId,@RegNo,@AddmissionDate,@AddmissionYear,@CreatedBy,@CreatedDate,@ApplicationId)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_RegNo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 19-09-2016
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_RegNo] 
	
AS
BEGIN
	SET NOCOUNT ON;
	--select TOP(1) *,SUBSTRING(RegNo,8,6) 'RegNos' from ss_Student order by Convert(int,SUBSTRING(RegNo,8,6)) desc
	select TOP(1) *,RIGHT(RegNo,6) 'RegNos' from ss_Student order by Convert(int,RIGHT(RegNo,6)) desc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Student_UnassignStudent]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Student_UnassignStudent] (
@Year nvarchar(50))
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	select st_Person.*, 
	ss_Student.RegNo,
	ss_Student.AdmissionYear,
	ss_Student.AdmissionDate, 
	ss_Student.Id as StudentId
	from ss_Student 
	inner join st_Person on ss_Student.PersonId=st_Person.Id where ss_Student.Id not in(
	select StudentId from er_StudentToClass where year=@Year)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDetail_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_StudentDetail_GetByCriteria] (
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max)
	set @sql=
	'Select 
	
	ss_Student.Id as Student_Id, 
	ss_Student.RegNo as Student_RegistrationNumber, 
	(CASE WHEN ss_Student.CurrentBalance is not null THEN ss_Student.CurrentBalance ELSE 0 END) as Student_CurrentBalance,
	st_Person.NameEng as Student_Name, 
	bs_Group.GroupName as Student_Group, 
	bs_Shift.Shift as Student_Shift, 
	bs_Section.Section as Student_Section, 
	bs_ClassName.ClassName as Student_Class, 
	bs_ClassName.Id as Class_Id, 
	vw_StudentToClass_Last.RollNo as StudentToClass_RollNo,
	bs_BloodGroup.BloodGroup as BloodGroupName,
	bs_Gender.Gender,
	bs_Religion.Religion,
	st_ParmanentAddress.DivisionId,
	st_ParmanentAddress.DistrictId,
	st_ParmanentAddress.ThanaId,
	st_ParmanentAddress.Address,
	st_ParmanentAddress.PostalCode,
	st_ParmanentAddress.PostOffice,
	(select Division from bs_Division where bs_Division.Id=st_ParmanentAddress.DivisionId) as DivName,
	(select District  from bs_District where bs_District.Id=st_ParmanentAddress.DistrictId) as DisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_ParmanentAddress.ThanaId) as Thana,
	st_PresentAddress.DivisionId as presentDiv,
	st_PresentAddress.DistrictId as presentDis,
	st_PresentAddress.ThanaId as presentThana,
	st_PresentAddress.PostOffice as presentPO,
	st_PresentAddress.PostalCode as presentPC,
	st_PresentAddress.Address as presentAddress,
	(select Division from bs_Division where bs_Division.Id=st_PresentAddress.DivisionId) as presentDivName,
	(select District  from bs_District where bs_District.Id=st_PresentAddress.DistrictId) as presentDisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_PresentAddress.ThanaId) as presentThanaName,

	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEduId,
	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEdu,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProId,

	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEdu,
	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEduId,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfessionId

	from ss_Student 
	join vw_StudentToClass_Last on ss_Student.Id = vw_StudentToClass_Last.StudentId
	join bs_ClassName on vw_StudentToClass_Last.ClassId = bs_ClassName.Id
	join bs_Group on vw_StudentToClass_Last.GroupId = bs_Group.Id
	join bs_Shift on vw_StudentToClass_Last.ShiftId = bs_Shift.Id
	join bs_Section on vw_StudentToClass_Last.SectionId = bs_Section.Id

	join st_Person on ss_Student.PersonId=st_Person.Id 
	left outer join bs_Gender on st_Person.GenderId=bs_Gender.Id
	left outer join bs_Religion on st_Person.ReligionId=bs_Religion.Id
	left outer join bs_BloodGroup on st_Person.BloodGroup=bs_BloodGroup.Id
	left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId
	left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId
	where '+@Criteria+' order by ss_Student.RegNo;';
	
	EXECUTE sp_executesql @sql;
END
GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_GenerateLateFee]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_StudentDue_GenerateLateFee]
AS
INSERT INTO [dbo].[acc_StudentDue_2021_to_2030]
		([TableName]
		,[TransectionIdentifier]
		,[EffectiveYear]
		,[EffectiveMonthSerial]
		,[EffectiveYearAndMonthSerial]
		,[StudentId]
		,[FeeHeadId]
		,[DefaultAmount]
		,[WaiverPercentage]
		,[AppliedAmount]
		,[ChargeBy]
		,[ShortStatus]
		,[LongStatus]
		,[StudentFeeMappingId]
		,[CreatedBy]
		,[CreatedDate]
		,[Note])

select 
		'acc_StudentDue_2021_to_2030' as [TableName]
		,'ST DUE/'+convert(varchar(36),NEWID()) as[TransectionIdentifier]
		,StudentDue_Tution.EffectiveYear
		,StudentDue_Tution.EffectiveMonthSerial
		,StudentDue_Tution.EffectiveYearAndMonthSerial
		,StudentDue_Tution.StudentId
		,(select acc_FeeHead_Late.Id from acc_FeeHead as acc_FeeHead_Late where acc_FeeHead_Late.FcCode like '%Late Fee%') as FeeHeadId
		,(select acc_FeeHead_Late.DefaultAmount from acc_FeeHead as acc_FeeHead_Late where acc_FeeHead_Late.FcCode like '%Late Fee%') as DefaultAmount
		,null as WaiverPercentage
		,(select acc_FeeHead_Late.DefaultAmount from acc_FeeHead as acc_FeeHead_Late where acc_FeeHead_Late.FcCode like '%Late Fee%') as AppliedAmount
		,'Process' as ChargeBy
		,'Unpaid' as ShortStatus
		,null as LongStatus
		,null as StudentFeeMappingId
		,'Process' as CreatedBy
		,GETDATE() as CreatedDate
		,'Due to not pay tution in time' Note

from acc_StudentDue_2021_to_2030 as StudentDue_Tution

join acc_FeeHead on StudentDue_Tution.FeeHeadId = acc_FeeHead.Id left join acc_StudentDue_2021_to_2030 as StudentDue_Late
	on StudentDue_Late.FeeHeadId = (select acc_FeeHead_Late.Id from acc_FeeHead as acc_FeeHead_Late where acc_FeeHead_Late.FcCode like '%Late Fee%')
	and StudentDue_Tution.StudentId = StudentDue_Late.StudentId
	and StudentDue_Tution.EffectiveYearAndMonthSerial = StudentDue_Late.EffectiveYearAndMonthSerial

where StudentDue_Tution.ShortStatus = 'Unpaid'
and acc_FeeHead.FcCode like '%Tution Fee%'
and StudentDue_Late.Id is null;

update acc_StudentDue_2021_to_2030 set TrackingId='ST.DU/'+CONVERT(varchar(10),EffectiveYear)+'/'+CONVERT(varchar(10),Id)
where TrackingId is null;

GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_InsertBySystem]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[USP_StudentDue_InsertBySystem] (
 @TransectionIdentifier varchar(50)
,@EffectiveYear	int
,@EffectiveMonthSerial	int
,@StudentId	int
,@FeeHeadId	int
,@DefaultAmount	decimal(18, 2)
,@WaiverPercentage	decimal(5, 2)
,@AppliedAmount	decimal(18, 2)
,@ChargeBy	varchar(20)
,@ShortStatus	varchar(20)
,@LongStatus	varchar(50)
,@EntryBy	nvarchar(50)
,@StudentFeeMappingId	int
,@Note	varchar(100)
,@DeveloperNote	varchar(50)	
)	
AS
BEGIN
declare @return_status varchar(10)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

BEGIN TRY 
	--Get Validation data
	BEGIN TRAN;
	IF(@EffectiveYear >= 2021 AND @EffectiveYear <= 2030)
	BEGIN
		IF(exists(select 1 from acc_StudentDue_2021_to_2030 where StudentId = @StudentId and FeeHeadId = @FeeHeadId and EffectiveYear = @EffectiveYear AND EffectiveMonthSerial = @EffectiveMonthSerial))
		BEGIN
			set @return_status = 'no';
			set @return_message = 'Already Exists';
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[acc_StudentDue_2021_to_2030]
			([TableName]
			,[TransectionIdentifier]
			,[EffectiveYear]
			,[EffectiveMonthSerial]
			,[EffectiveYearAndMonthSerial]
			,[StudentId]
			,[FeeHeadId]
			,[DefaultAmount]
			,[WaiverPercentage]
			,[AppliedAmount]
			,[ChargeBy]
			,[ShortStatus]
			,[LongStatus]
			,[StudentFeeMappingId]
			,[CreatedBy]
			,[CreatedDate]
			,[Note])
			 VALUES
			('acc_StudentDue_2021_to_2030'
			,@TransectionIdentifier
			,@EffectiveYear
			,@EffectiveMonthSerial
			,CONVERT(varchar(4),@EffectiveYear) + '-' +(case when @EffectiveMonthSerial < 10 then '0'+CONVERT(varchar(2),@EffectiveMonthSerial) else CONVERT(varchar(2),@EffectiveMonthSerial) end)
			,@StudentId
			,@FeeHeadId
			,@DefaultAmount
			,@WaiverPercentage
			,@AppliedAmount
			,@ChargeBy
			,@ShortStatus
			,@LongStatus
			,@StudentFeeMappingId
			,@EntryBy
			,getdate()
			,@Note)
			set @Id = SCOPE_IDENTITY();		
			Commit;
			set @return_status = 'yes';
		END
	END
	ELSE
	BEGIN
		ROLLBACK;
		set @return_status = 'no';
		set @return_message = 'Effective Year not allowed'; 
	END
	
END TRY 
BEGIN CATCH
	ROLLBACK;
	set @return_status = 'no';
	set @return_message = ERROR_MESSAGE(); 
END CATCH  

select @return_status as return_status, @Id as id, @return_message as return_message;

END


GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_InsertByUser]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[USP_StudentDue_InsertByUser] (
 @IsMultipleEntry bit
,@TransectionIdentifier	varchar(50)
,@EffectiveYear	int
,@EffectiveMonthSerial	int
,@StudentId	int
,@FeeHeadId	int
,@DefaultAmount	decimal(18, 2)
--,@WaiverPercentage	decimal(5, 2)
,@AppliedAmount	decimal(18, 2)
,@ChargeBy	varchar(20)
,@ShortStatus	varchar(20)
,@LongStatus	varchar(50)
,@EntryBy	nvarchar(50)
--,@StudentFeeMappingId	int
,@Note	varchar(100)
,@DeveloperNote	varchar(50)	
)	
AS
BEGIN
declare @return_status varchar(10)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

BEGIN TRY 
	--Get Validation data
	BEGIN TRAN;
	IF(@EffectiveYear >= 2021 and @EffectiveYear <= 2030)
	BEGIN
		IF(@IsMultipleEntry = 0 AND exists(select 1 from acc_StudentDue_2021_to_2030 where StudentId = @StudentId and FeeHeadId = @FeeHeadId and EffectiveYear = @EffectiveYear AND EffectiveMonthSerial = @EffectiveMonthSerial))
		BEGIN
			set @return_status = 'no';
			set @return_message = 'Already Exists';
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[acc_StudentDue_2021_to_2030]
			([TableName]
			,[TransectionIdentifier]
			,[EffectiveYear]
			,[EffectiveMonthSerial]
			,[EffectiveYearAndMonthSerial]
			,[StudentId]
			,[FeeHeadId]
			,[DefaultAmount]
			--,[WaiverPercentage]
			,[AppliedAmount]
			,[ChargeBy]
			,[ShortStatus]
			,[LongStatus]
			--,[StudentFeeMappingId]
			,[CreatedBy]
			,[CreatedDate]
			,[Note])
			 VALUES
			('acc_StudentDue_2021_to_2030'
			,@TransectionIdentifier
			,@EffectiveYear
			,@EffectiveMonthSerial
			,CONVERT(varchar(4),@EffectiveYear) + '-' +(case when @EffectiveMonthSerial < 10 then '0'+CONVERT(varchar(2),@EffectiveMonthSerial) else CONVERT(varchar(2),@EffectiveMonthSerial) end)
			,@StudentId
			,@FeeHeadId
			,@DefaultAmount
			--,@WaiverPercentage
			,@AppliedAmount
			,@ChargeBy
			,@ShortStatus
			,@LongStatus
			--,@StudentFeeMappingId
			,@EntryBy
			,getdate()
			,@Note)
			set @Id = SCOPE_IDENTITY();		
			Commit;
			set @return_status = 'yes';
		END
	END
	ELSE
	BEGIN
		ROLLBACK;
		set @return_status = 'no';
		set @return_message = 'Effective Year'+@EffectiveYear+' not allowed. Contact to MIS.'; 
	END
	
END TRY 
BEGIN CATCH
	ROLLBACK;
	set @return_status = 'no';
	set @return_message = ERROR_MESSAGE(); 
END CATCH  

select @return_status as return_status, @Id as id, @return_message as return_message;

END


GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_Transectional_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_StudentDue_Transectional_GetByCriteria] (
@ClassId int = null,
@FeeHeadId int = null,
@GroupId int = null,
@ShiftId int = null,
@SectionId int = null,
@StudentId int = null,
@RegistrationNumber varchar(30) = null,
@EffectiveYearAndMonthSeeialFrom varchar(10) = null,
@EffectiveYearAndMonthSeeialTo varchar(10) = null,
@ShortStatus varchar(20) = null,
@TransectionIdentifier varchar(50) = null,
@Invoice_TransectionIdentifier varchar(50) = null
)
	
AS
BEGIN
--set @FeeHeadId = 1;
	select  --top 1 
	0 as FirstColumn,
	
	ss_Student.Id as Student_Id, 
	ss_Student.RegNo as Student_RegistrationNumber, 
	st_Person.NameEng as Student_Name, 
	bs_ClassName.ClassName as Student_Class, 
	bs_Group.GroupName as Student_Group, 
	bs_Shift.Shift as Student_Shift, 
	bs_Section.Section as Student_Section, 
	bs_ClassName.ClassName as Student_Class, 

	acc_FeeHead.Id as Fee_Id,
	acc_FeeHead.DisplayName as Fee_DisplayName,
	acc_FeeHead.FullName as Fee_FullName,
	--acc_FeeHead.DefaultAmount as Fee_DefaultAmount,

	--acc_StudentFeeMapping.Id as Mapping_Id,
	--acc_StudentFeeMapping.DefaultAmount as Mapping_DefaultAmount,
	--acc_StudentFeeMapping.WaiverPercentage as Mapping_WaiverPercentage,
	--acc_StudentFeeMapping.AppliedAmount as Mapping_AppliedAmount,
	--acc_StudentFeeMapping.IsActive as Mapping_IsActive,

	ttv_acc_StudentDue.Id as StudentDue_Id,
	ttv_acc_StudentDue.TrackingId as StudentDue_TrackingId,
	ttv_acc_StudentDue.TransectionIdentifier as StudentDue_TransectionIdentifier,
	ttv_acc_StudentDue.EffectiveYear as StudentDue_EffectiveYear,
	ttv_acc_StudentDue.EffectiveMonthSerial as StudentDue_EffectiveMonthSerial,
	[master].dbo.[MYSVF_GetMonthName](ttv_acc_StudentDue.EffectiveMonthSerial) as StudentDue_EffectiveMonthName,
	ttv_acc_StudentDue.DefaultAmount as StudentDue_DefaultAmount,
	ttv_acc_StudentDue.WaiverPercentage as StudentDue_WaiverPercentage,
	ttv_acc_StudentDue.AppliedAmount as StudentDue_AppliedAmount,
	ttv_acc_StudentDue.ChargeBy as StudentDue_ChargeBy,
	ttv_acc_StudentDue.ShortStatus as StudentDue_ShortStatus,
	ttv_acc_StudentDue.LongStatus as StudentDue_LongStatus,
	ttv_acc_StudentDue.StudentFeeMappingId as StudentDue_StudentFeeMappingId,
	ttv_acc_StudentDue.CreatedBy as StudentDue_CreatedBy,
	ttv_acc_StudentDue.CreatedDate as StudentDue_CreatedDate,
	ttv_acc_StudentDue.Note as StudentDue_Note,
	
	1 as LastColumn
	from ttv_acc_StudentDue
	join ss_Student on ttv_acc_StudentDue.StudentId = ss_Student.Id
	join st_Person on ss_Student.PersonId =st_Person.Id
	join vw_StudentToClass_Last as studentCurrentInfo on ss_Student.Id = studentCurrentInfo.StudentId
	join bs_ClassName on studentCurrentInfo.ClassId = bs_ClassName.Id
	join bs_Group on studentCurrentInfo.GroupId = bs_Group.Id
	join bs_Shift on studentCurrentInfo.ShiftId = bs_Shift.Id
	join bs_Section on studentCurrentInfo.SectionId = bs_Section.Id
	----left join acc_StudentFeeMapping on studentCurrentInfo.Id = acc_StudentFeeMapping.StudentId AND acc_StudentFeeMapping.IsActive = @StudentFeeMappingIsActive
	join acc_FeeHead on ttv_acc_StudentDue.FeeHeadId = acc_FeeHead.Id --AND acc_FeeHead.IsActive = @FeeHeadIsActive AND (acc_FeeHead.ClassId = studentCurrentInfo.ClassId OR acc_FeeHead.ClassId is null)
	
	where 1=1 
	AND (@ClassId is null or (bs_ClassName.Id = @ClassId))
	AND (@FeeHeadId is null or (acc_FeeHead.Id = @FeeHeadId))
	AND (@GroupId is null or (studentCurrentInfo.GroupId = @GroupId))
	AND (@ShiftId is null or (studentCurrentInfo.ShiftId = @ShiftId))
	AND (@SectionId is null or (studentCurrentInfo.SectionId = @SectionId))
	AND (@StudentId is null or (ss_Student.Id = @StudentId))
	AND (@RegistrationNumber is null or (ss_Student.RegNo like '%'+@RegistrationNumber+'%'))

	
	AND (@EffectiveYearAndMonthSeeialFrom is null or (ttv_acc_StudentDue.EffectiveYearAndMonthSerial >= @EffectiveYearAndMonthSeeialFrom))
	AND (@EffectiveYearAndMonthSeeialTo is null or (ttv_acc_StudentDue.EffectiveYearAndMonthSerial <= @EffectiveYearAndMonthSeeialTo))
	AND (@ShortStatus is null or (ttv_acc_StudentDue.ShortStatus = @ShortStatus))
	AND (@TransectionIdentifier is null or (ttv_acc_StudentDue.TransectionIdentifier = @TransectionIdentifier))
	AND (@Invoice_TransectionIdentifier is null or (ttv_acc_StudentDue.Invoice_TransectionIdentifier = @Invoice_TransectionIdentifier))
	order by ss_Student.RegNo, ttv_acc_StudentDue.EffectiveYear, ttv_acc_StudentDue.EffectiveMonthSerial, acc_FeeHead.PriorityOrder;

END




--DECLARE @RC int
--DECLARE @ClassId int
--DECLARE @FeeHeadId int
--DECLARE @GroupId int
--DECLARE @ShiftId int
--DECLARE @SectionId int
--DECLARE @RegistrationNumber varchar(30)
--DECLARE @EffectiveYear int
--DECLARE @EffectiveMonthSerial int
--DECLARE @Status varchar(10)
--DECLARE @PaymentStatus varchar(10)

---- TODO: Set parameter values here.

--EXECUTE @RC = [dbo].[USP_StudentDue_Short_GetByCriteria] 
--   @ClassId
--  ,@FeeHeadId
--  ,@GroupId
--  ,@ShiftId
--  ,@SectionId
--  ,@RegistrationNumber
--  ,@EffectiveYear
--  ,@EffectiveMonthSerial
--  ,@Status
--  ,@PaymentStatus;

  --select * from vw_StudentToClass_Last where StudentId = '1290'






GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_Transectional_Pay_ByInternalUser]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[USP_StudentDue_Transectional_Pay_ByInternalUser](
@TransectionIdentifier varchar(50),
@Invoice_TransectionIdentifier varchar(50),
@PaidBy varchar(50)
)
AS
BEGIN
	declare @return_status varchar(20)='';
	declare @Id int= 0;
	declare @return_message varchar(max)='';
	print 1;
	BEGIN TRY
	BEGIN TRAN;
		--Validation
		IF(NOT Exists(SELECT top 1 1 from ttv_acc_StudentDue where TransectionIdentifier = @TransectionIdentifier))
		BEGIN
			set @return_message = 'No table found for given TransectionIdentifier. Contct MIS.'; 
		END
		
		--Execution
		IF(@return_message = '')
		BEGIN
			DECLARE @Student_Id int;
			DECLARE @Student_CurrentBalance decimal(18,2);
			DECLARE @Due_AppliedAmount decimal(18,2);
			DECLARE @Due_ShortStatus varchar(20);
			DECLARE @Invoice_RemainingBalance decimal(18,2);

			select @Student_Id = ss_Student.Id, 
			@Student_CurrentBalance = ss_Student.CurrentBalance, 
			@Due_AppliedAmount = Due.AppliedAmount, 
			@Due_ShortStatus = Due.ShortStatus
			from ttv_acc_StudentDue as Due
			join ss_Student on Due.StudentId = ss_Student.Id
			where Due.TransectionIdentifier = @TransectionIdentifier;

			select @Invoice_RemainingBalance = ttv_acc_StudentInvoice.RemainingBalance
			from ttv_acc_StudentInvoice 
			where ttv_acc_StudentInvoice.TransectionIdentifier = @Invoice_TransectionIdentifier;

			IF(@Student_Id is not null AND @Student_CurrentBalance > = @Due_AppliedAmount AND @Due_ShortStatus = 'Unpaid')
			BEGIN
				
				declare @rowCount_1 int;
				Update ttv_acc_StudentDue 
				set Invoice_TransectionIdentifier =  @Invoice_TransectionIdentifier, 
				StudentNewBalance = @Student_CurrentBalance,
				PaidBy = @PaidBy,
				PaidDate = Getdate(),
				ShortStatus = 'Paid', 
				LongStatus = 'Paid by-InternalUser/Cash'
				where ttv_acc_StudentDue.TransectionIdentifier = @TransectionIdentifier;
				set @rowCount_1 = @@rowcount;

				declare @rowCount_2 int;
				IF(@rowCount_1 > 0)
				BEGIN
					Update ttv_acc_StudentInvoice 
					set RemainingBalance = @Invoice_RemainingBalance - @Due_AppliedAmount 
					where ttv_acc_StudentInvoice.TransectionIdentifier = @Invoice_TransectionIdentifier;
				set @rowCount_2 = @@rowcount;
				END

				declare @rowCount_3 int;
				IF(@rowCount_2 > 0)
				BEGIN
					Update ss_Student 
					set CurrentBalance = @Student_CurrentBalance - @Due_AppliedAmount 
					where ss_Student.Id = @Student_Id;
					set @rowCount_3 = @@rowcount;
				END
				
				IF(@rowCount_1 > 0 AND @rowCount_2 > 0 AND @rowCount_3 > 0)
				BEGIN
					COMMIT;
					set @return_status = 'yes';
				END
				ELSE
				BEGIN
					ROLLBACK;
					set @return_status = 'no';
					set @return_message = 'One or more table not updated. Contct MIS.'; 
				END
			END
			ELSE
			BEGIN
				Update ttv_acc_StudentDue 
				set Invoice_TransectionIdentifier =  @Invoice_TransectionIdentifier
				where ttv_acc_StudentDue.TransectionIdentifier = @TransectionIdentifier;
				COMMIT;
				set @return_status = 'no';
				set @return_message = 'Failed. CB:'+CONVERT(varchar(10), @Student_CurrentBalance)+' C.Stat=' + @Due_ShortStatus; 
			END
		END
		ELSE
		BEGIN
			ROLLBACK;
			set @return_status = 'no';
		END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		set @return_status = 'no';
		set @return_message = ERROR_MESSAGE(); 
	END CATCH
	select @return_status as return_status, @Id as id, @return_message as return_message;
END


GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_Transectional_Pay_ByInternalUser_obsolate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[USP_StudentDue_Transectional_Pay_ByInternalUser_obsolate](
@TransectionIdentifier varchar(50),
@Invoice_TransectionIdentifier varchar(50),
@PaidBy varchar(50)
)
AS
BEGIN
	declare @return_status varchar(20)='';
	declare @Id int= 0;
	declare @return_message varchar(max)='';
	print 1;
	BEGIN TRY
	BEGIN TRAN;
		DECLARE @TableName varchar(50) = (SELECT top 1 TableName from stv_acc_StudentDue where TransectionIdentifier = @TransectionIdentifier);
		--SET @Id = (SELECT Item FROM [master].dbo.[MYTVF_STRING_SPLIT](@TransectionIdentifier,'/') where Serial = 2);
		DECLARE @AppliedAmount decimal(18,2);

		DECLARE @Student_Id int;
		DECLARE @Student_CurrentBalance decimal(18,2);
		DECLARE @Due_AppliedAmount decimal(18,2);
		DECLARE @Due_ShortStatus varchar(20);
		DECLARE @Invoice_RemainingBalance decimal(18,2);

		IF(@tableName = 'acc_StudentDue_2021_to_2030')
		BEGIN
			select @Student_Id = ss_Student.Id, 
			@Student_CurrentBalance = ss_Student.CurrentBalance, 
			@Due_AppliedAmount = Due.AppliedAmount, 
			@Due_ShortStatus = Due.ShortStatus
			from acc_StudentDue_2021_to_2030 as Due
			join ss_Student on Due.StudentId = ss_Student.Id
			where Due.TransectionIdentifier = @TransectionIdentifier;

			select @Invoice_RemainingBalance = stv_acc_StudentInvoice.RemainingBalance
			from stv_acc_StudentInvoice 
			where stv_acc_StudentInvoice.TransectionIdentifier = @Invoice_TransectionIdentifier;

			IF(@Student_Id is not null AND @Student_CurrentBalance > = @Due_AppliedAmount AND @Due_ShortStatus = 'Unpaid')
			BEGIN
				Update ss_Student 
				set CurrentBalance = @Student_CurrentBalance - @Due_AppliedAmount 
				where ss_Student.Id = @Student_Id;
				
				Update stv_acc_StudentInvoice 
				set RemainingBalance = @Invoice_RemainingBalance - @Due_AppliedAmount 
				where stv_acc_StudentInvoice.TransectionIdentifier = @Invoice_TransectionIdentifier;

				Update acc_StudentDue_2021_to_2030 
				set Invoice_TransectionIdentifier =  @Invoice_TransectionIdentifier, 
				StudentNewBalance = @Student_CurrentBalance,
				PaidBy = @PaidBy,
				PaidDate = Getdate(),
				ShortStatus = 'Paid', 
				LongStatus = 'Paid by-InternalUser/Cash'
				where acc_StudentDue_2021_to_2030.TransectionIdentifier = @TransectionIdentifier;
				COMMIT;
				set @return_status = 'yes';
			END
			ELSE
			BEGIN
				Update acc_StudentDue_2021_to_2030 
				set Invoice_TransectionIdentifier =  @Invoice_TransectionIdentifier
				where acc_StudentDue_2021_to_2030.TransectionIdentifier = @TransectionIdentifier;
				COMMIT;
				set @return_status = 'no';
				set @return_message = 'Failed. CB:'+CONVERT(varchar(10), @Student_CurrentBalance)+' C.Stat=' + @Due_ShortStatus; 
			END
		END
		ELSE
		BEGIN
			ROLLBACK;
			set @return_status = 'no';
			set @return_message = 'No table found for given TransectionIdentifier. Contct MIS.'; 
		END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		set @return_status = 'no';
		set @return_message = ERROR_MESSAGE(); 
	END CATCH
	select @return_status as return_status, @Id as id, @return_message as return_message;
END


GO
/****** Object:  StoredProcedure [dbo].[USP_StudentDue_Transectional_Pay_ByProcess]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[USP_StudentDue_Transectional_Pay_ByProcess](
@TransectionIdentifier varchar(50),
@Invoice_TransectionIdentifier varchar(50)
)
AS
BEGIN
	declare @return_status varchar(20)='';
	declare @Id int= 0;
	declare @return_message varchar(max)='';
	print 1;
	BEGIN TRY
	BEGIN TRAN;
		--Validation
		IF(NOT Exists(SELECT top 1 1 from ttv_acc_StudentDue where TransectionIdentifier = @TransectionIdentifier))
		BEGIN
			set @return_message = 'No table found for given TransectionIdentifier. Contct MIS.'; 
		END
		
		--Execution
		IF(@return_message = '')
		BEGIN
			DECLARE @Student_Id int;
			DECLARE @Student_CurrentBalance decimal(18,2);
			DECLARE @Due_AppliedAmount decimal(18,2);
			DECLARE @Due_ShortStatus varchar(20);
			DECLARE @Invoice_RemainingBalance decimal(18,2);

			select @Student_Id = ss_Student.Id, 
			@Student_CurrentBalance = ss_Student.CurrentBalance, 
			@Due_AppliedAmount = Due.AppliedAmount, 
			@Due_ShortStatus = Due.ShortStatus
			from ttv_acc_StudentDue as Due
			join ss_Student on Due.StudentId = ss_Student.Id
			where Due.TransectionIdentifier = @TransectionIdentifier;

			select @Invoice_RemainingBalance = ttv_acc_StudentInvoice.RemainingBalance
			from ttv_acc_StudentInvoice 
			where ttv_acc_StudentInvoice.TransectionIdentifier = @Invoice_TransectionIdentifier;

			IF(@Student_Id is not null AND @Student_CurrentBalance > = @Due_AppliedAmount AND @Due_ShortStatus = 'Unpaid')
			BEGIN
				
				declare @rowCount_1 int;
				Update ttv_acc_StudentDue 
				set Invoice_TransectionIdentifier =  @Invoice_TransectionIdentifier, 
				StudentNewBalance = @Student_CurrentBalance,
				PaidBy = 'Process',
				PaidDate = Getdate(),
				ShortStatus = 'Paid', 
				LongStatus = 'Paid by-InternalUser/Cash'
				where ttv_acc_StudentDue.TransectionIdentifier = @TransectionIdentifier;
				set @rowCount_1 = @@rowcount;

				declare @rowCount_2 int;
				IF(@rowCount_1 > 0)
				BEGIN
					Update ttv_acc_StudentInvoice 
					set RemainingBalance = @Invoice_RemainingBalance - @Due_AppliedAmount 
					where ttv_acc_StudentInvoice.TransectionIdentifier = @Invoice_TransectionIdentifier;
				set @rowCount_2 = @@rowcount;
				END

				declare @rowCount_3 int;
				IF(@rowCount_2 > 0)
				BEGIN
					Update ss_Student 
					set CurrentBalance = @Student_CurrentBalance - @Due_AppliedAmount 
					where ss_Student.Id = @Student_Id;
					set @rowCount_3 = @@rowcount;
				END
				
				IF(@rowCount_1 > 0 AND @rowCount_2 > 0 AND @rowCount_3 > 0)
				BEGIN
					COMMIT;
					set @return_status = 'yes';
				END
				ELSE
				BEGIN
					ROLLBACK;
					set @return_status = 'no';
					set @return_message = 'One or more table not updated. Contct MIS.'; 
				END
			END
			ELSE
			BEGIN
				Update ttv_acc_StudentDue 
				set Invoice_TransectionIdentifier =  @Invoice_TransectionIdentifier
				where ttv_acc_StudentDue.TransectionIdentifier = @TransectionIdentifier;
				COMMIT;
				set @return_status = 'no';
				set @return_message = 'Failed. CB:'+CONVERT(varchar(10), @Student_CurrentBalance)+' C.Stat=' + @Due_ShortStatus; 
			END
		END
		ELSE
		BEGIN
			ROLLBACK;
			set @return_status = 'no';
		END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		set @return_status = 'no';
		set @return_message = ERROR_MESSAGE(); 
	END CATCH
	select @return_status as return_status, @Id as id, @return_message as return_message;
END


GO
/****** Object:  StoredProcedure [dbo].[USP_StudentFeeMapping_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_StudentFeeMapping_GetByCriteria] (
@FeeHeadIsActive varchar(10),--Mendatory
@StudentFeeMappingIsActive varchar(10),--Mendatory
@ClassId int = null,
@FeeHeadId int = null,
@GroupId int = null,
@ShiftId int = null,
@SectionId int = null,
@RegistrationNumber varchar(30) = null,
@FeeHeadIsActive_ForDueGenerationBySytem varchar(10) = null
)
	
AS
BEGIN
--set @FeeHeadId = 1;
	select  --top 1 
	0 as FirstColumn,
	ss_Student.Id as Student_Id, 
	ss_Student.RegNo as Student_RegistrationNumber, 
	st_Person.NameEng as Student_Name, 
	bs_ClassName.ClassName as Student_Class, 
	bs_Group.GroupName as Student_Group, 
	bs_Shift.Shift as Student_Shift, 
	bs_Section.Section as Student_Section, 
	bs_ClassName.ClassName as Student_Class, 

	acc_FeeHead.Id as Fee_Id,
	acc_FeeHead.FullName as Fee_FullName,
	acc_FeeHead.DefaultAmount as Fee_DefaultAmount,
	acc_StudentFeeMapping.Id as Mapping_Id,
	acc_StudentFeeMapping.DefaultAmount as Mapping_DefaultAmount,
	acc_StudentFeeMapping.WaiverPercentage as Mapping_WaiverPercentage,
	acc_StudentFeeMapping.AppliedAmount as Mapping_AppliedAmount,
	acc_StudentFeeMapping.IsActive as Mapping_IsActive,
	1 as LastColumn
	from
	ss_Student
	join st_Person on ss_Student.PersonId =st_Person.Id
	join vw_StudentToClass_Last as studentCurrentInfo on ss_Student.Id = studentCurrentInfo.StudentId
	join bs_ClassName on studentCurrentInfo.ClassId = bs_ClassName.Id
	join bs_Group on studentCurrentInfo.GroupId = bs_Group.Id
	join bs_Shift on studentCurrentInfo.ShiftId = bs_Shift.Id
	join bs_Section on studentCurrentInfo.SectionId = bs_Section.Id
	join acc_StudentFeeMapping on studentCurrentInfo.StudentId = acc_StudentFeeMapping.StudentId AND acc_StudentFeeMapping.IsActive = @StudentFeeMappingIsActive 
	join acc_FeeHead on acc_StudentFeeMapping.FeeHeadId = acc_FeeHead.Id AND acc_FeeHead.IsActive = @FeeHeadIsActive AND (acc_FeeHead.ClassId = studentCurrentInfo.ClassId OR acc_FeeHead.ClassId is null)
	
	where 1=1 
	AND (@ClassId is null or (bs_ClassName.Id = @ClassId))
	AND (@FeeHeadId is null or (acc_FeeHead.Id = @FeeHeadId))
	AND (@FeeHeadIsActive_ForDueGenerationBySytem is null OR acc_FeeHead.IsActive_ForDueGenerationBySytem = @FeeHeadIsActive_ForDueGenerationBySytem) 
	AND (@GroupId is null or (studentCurrentInfo.GroupId = @GroupId))
	AND (@ShiftId is null or (studentCurrentInfo.ShiftId = @ShiftId))
	AND (@SectionId is null or (studentCurrentInfo.SectionId = @SectionId))
	AND (@RegistrationNumber is null or (ss_Student.RegNo like '%'+@RegistrationNumber+'%'))
	order by ss_Student.RegNo,acc_FeeHead.PriorityOrder;

END

--	exec USP_StudentFeeMapping_GetByCriteria @ClassId = null, @FeeHeadId = null,@GroupId = null,@ShiftId= null,@SectionId= null,@RegistrationNumber = null, @FeeHeadIsActive='Active', @StudentFeeMappingIsActive = 'Active'

GO
/****** Object:  StoredProcedure [dbo].[USP_StudentFeeMapping_InsertOrUpdate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[USP_StudentFeeMapping_InsertOrUpdate] (
 @Id int
,@StudentId int
,@FeeHeadId int
,@DefaultAmount	decimal(18, 2)
,@WaiverPercentage	decimal(5, 2)
,@ConsumptionUnit	decimal(5, 2)
,@AppliedAmount decimal(18, 2)
,@IsActive varchar(10)
,@EntryBy nvarchar(50)
)	
AS
BEGIN
declare @return_status varchar(10)='';
--declare @Id int= 0;
declare @return_message varchar(max)='';

BEGIN TRY 
	BEGIN Tran;
	--Validation: Check Duplicate Transport Fee Mapping
	IF(exists(select 1 from acc_FeeHead where acc_FeeHead.Id = @FeeHeadId AND acc_FeeHead.FcCode like '%Transport Fee%') AND @IsActive = 'Active')
	BEGIN
		declare @ConfilctingFeeHead_FullName varchar(100) = (select acc_FeeHead.FullName from acc_StudentFeeMapping
		join acc_FeeHead on acc_StudentFeeMapping.FeeHeadId = acc_FeeHead.Id
		where acc_StudentFeeMapping.StudentId = @StudentId
		and acc_StudentFeeMapping.FeeHeadId != @FeeHeadId
		and acc_StudentFeeMapping.IsActive = 'Active'
		and acc_FeeHead.FcCode like '%Transport Fee%'
		);
		IF(@ConfilctingFeeHead_FullName is not null)
		BEGIN
			set @return_message = 'Conflict with Fee Head: '+ @ConfilctingFeeHead_FullName;
		END
	END
	
	IF(@return_message = '')
	BEGIN
		--IF @FeeHeadId != 0 >> Update
		if(@Id is not null)
		begin
			update acc_StudentFeeMapping 
			set DefaultAmount= @DefaultAmount, 
			WaiverPercentage= @WaiverPercentage,
			ConsumptionUnit= @ConsumptionUnit,
			AppliedAmount= @AppliedAmount,
			IsActive = @IsActive,
			UpdatedBy = @EntryBy,
			UpdatedDate = getdate()
			where Id = @Id;
			COMMIT;
			set @return_status = 'yes';
		end
		--ELSE IF Exist >> Update
		else if(exists(select 1 from acc_StudentFeeMapping where StudentId = @StudentId and FeeHeadId = @FeeHeadId))
		begin
			update acc_StudentFeeMapping 
			set DefaultAmount= @DefaultAmount, 
			WaiverPercentage= @WaiverPercentage,
			ConsumptionUnit= @ConsumptionUnit,
			AppliedAmount= @AppliedAmount,
			IsActive = @IsActive,
			UpdatedBy = @EntryBy,
			UpdatedDate = getdate()
			where StudentId = @StudentId and FeeHeadId = @FeeHeadId;
			COMMIT;
			set @return_status = 'yes';
		end
		--ELSE Insert
		else
		begin
			SET NOCOUNT ON;
			INSERT INTO [dbo].[acc_StudentFeeMapping]
				   ([StudentId]
				   ,[FeeHeadId]
				   ,[DefaultAmount]
				   ,[WaiverPercentage]
				   ,[ConsumptionUnit]
				   ,[AppliedAmount]			   
				   ,[IsActive]
				   ,[CreatedBy]
				   ,[CreatedDate])
			 VALUES
				   (@StudentId
				   ,@FeeHeadId
				   ,@DefaultAmount
				   ,@WaiverPercentage
				   ,@ConsumptionUnit
				   ,@AppliedAmount
				   ,@IsActive
				   ,@EntryBy
				   ,GETDATE())
			set @Id = SCOPE_IDENTITY();		
			Commit;
			set @return_status = 'yes';
		end
	END
	ELSE
	BEGIN
		rollback;
	END
END TRY 
BEGIN CATCH
	rollback;
	set @return_status = 'no';
	set @return_message = ERROR_MESSAGE(); 
END CATCH  

select @return_status as return_status, @Id as id, @return_message as return_message;

END


GO
/****** Object:  StoredProcedure [dbo].[USP_StudentFeeMapping_Setup_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_StudentFeeMapping_Setup_GetByCriteria] (
@ClassId int,--Mendatory
@FeeHeadId int,--Mendatory
@GroupId int = null,
@ShiftId int = null,
@SectionId int = null,
@RegistrationNumber varchar(30) = null
)
AS
BEGIN
	select  --top 1 
	0 as FirstColumn,
	ss_Student.Id as Student_Id, 
	ss_Student.RegNo as Student_RegistrationNumber, 
	st_Person.NameEng as Student_Name, 
	bs_ClassName.ClassName as Student_Class, 
	bs_Group.GroupName as Student_Group, 
	bs_Shift.Shift as Student_Shift, 
	bs_Section.Section as Student_Section, 
	bs_ClassName.ClassName as Student_Class, 

	acc_FeeHead.Id as Fee_Id,
	acc_FeeHead.FullName as Fee_FullName,
	acc_FeeHead.DefaultAmount as Fee_DefaultAmount,
	acc_FeeHead.MaxAmount as Fee_MaxAmount,
	
	acc_StudentFeeMapping.Id as Mapping_Id,
	acc_StudentFeeMapping.WaiverPercentage as Mapping_WaiverPercentage,
	acc_StudentFeeMapping.ConsumptionUnit as Mapping_ConsumptionUnit,
	acc_StudentFeeMapping.AppliedAmount as Mapping_AppliedAmount,
	acc_StudentFeeMapping.IsActive as Mapping_IsActive,
	1 as LastColumn
	
	from ss_Student
	join st_Person on ss_Student.PersonId =st_Person.Id
	join vw_StudentToClass_Last as studentCurrentInfo on ss_Student.Id = studentCurrentInfo.StudentId and @ClassId = studentCurrentInfo.ClassId
	join bs_ClassName on studentCurrentInfo.ClassId = bs_ClassName.Id
	join bs_Group on studentCurrentInfo.GroupId = bs_Group.Id
	join bs_Shift on studentCurrentInfo.ShiftId = bs_Shift.Id
	join bs_Section on studentCurrentInfo.SectionId = bs_Section.Id
	
	join acc_FeeHead on  @FeeHeadId = acc_FeeHead.Id AND (acc_FeeHead.ClassId = @ClassId OR acc_FeeHead.ClassId is null)
	
	left join acc_StudentFeeMapping on ss_Student.Id = acc_StudentFeeMapping.StudentId and acc_StudentFeeMapping.FeeHeadId = @FeeHeadId
	
	where 1=1 
	--AND (@ClassId is null or (bs_ClassName.Id = @ClassId))
	--AND (@FeeHeadId is null or (acc_FeeHead.Id = @FeeHeadId))
	AND (@GroupId is null or (studentCurrentInfo.GroupId = @GroupId))
	AND (@ShiftId is null or (studentCurrentInfo.ShiftId = @ShiftId))
	AND (@SectionId is null or (studentCurrentInfo.SectionId = @SectionId))
	AND (@RegistrationNumber is null or (ss_Student.RegNo like '%'+@RegistrationNumber+'%'))
	order by ss_Student.RegNo;
END

--exec USP_StudentFeeMapping_Setup_GetByCriteria @ClassId = 1,@FeeHeadId = 17,@GroupId = null,@ShiftId= null,@SectionId= null,@RegistrationNumber = null

GO
/****** Object:  StoredProcedure [dbo].[USP_StudentIdCard_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 15-04-2017
-- =============================================
create PROCEDURE [dbo].[USP_StudentIdCard_Update] (
@StudentId int,
@CardNo nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;

update ss_Student set CardNo=@CardNo where Id=@StudentId

END
GO
/****** Object:  StoredProcedure [dbo].[USP_StudentInvoice_Insert_ByInternalUser]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_StudentInvoice_Insert_ByInternalUser] (
@TransectionIdentifier varchar(50),
@StudentId	int,
@DepositedAmount	decimal(18, 2),
@CreatedBy	nvarchar(50),
@Status	varchar(50),
@Note	varchar(100),
@DeveloperNote	varchar(50)
)	
AS
BEGIN
declare @return_status varchar(20)='';
declare @Id int= 0;
declare @return_message varchar(max)='';

	BEGIN TRY 
		BEGIN TRAN;
		declare @EffectiveYear	int=YEAR(GETDATE());
		IF EXISTS(select 1 from ss_Student where ss_Student.Id = @StudentId)
		BEGIN
			declare @OldBalance decimal(18,2) = (select (case when ss_Student.CurrentBalance is not null then ss_Student.CurrentBalance else 0 end) from ss_Student where ss_Student.Id = @StudentId);
			declare @NewBalance decimal(18,2) = @OldBalance + @DepositedAmount;
			
			update ss_Student set CurrentBalance = @NewBalance where ss_Student.Id = @StudentId;
			
			IF(@EffectiveYear >= 2021 AND @EffectiveYear <= 2030)
			BEGIN
				INSERT INTO [dbo].[acc_StudentInvoice_2021_to_2030]
				([TableName]
				,[TransectionIdentifier]
				,[EffectiveYear]
				,[StudentId]
				,[OldBalance]
				,[DepositedAmount]
				,[NewBalance]
				,[RemainingBalance]
				,[CreatedBy]
				,[CreatedDate]
				,[Status]
				,[Note]
				,[DeveloperNote])
				VALUES
				('acc_StudentInvoice_2021_to_2030'
				,@TransectionIdentifier
				,@EffectiveYear
				,@StudentId
				,@OldBalance
				,@DepositedAmount
				,@NewBalance
				,@NewBalance
				,@CreatedBy
				,GETDATE()
				,@Status
				,@Note
				,@DeveloperNote)
				set @Id = SCOPE_IDENTITY();
				Commit;
				set @return_status = 'yes';
			END
			ELSE
			BEGIN
				ROLLBACK;
				set @return_status = 'no';
				set @return_message = 'Effective Year not allowed'; 
			END
		END
		ELSE
		BEGIN
			ROLLBACK;
			set @return_status = 'no';
			set @return_message = 'Student not found'; 
		END
	END TRY 
	BEGIN CATCH
	ROLLBACK;
	set @return_status = 'no';
	set @return_message = ERROR_MESSAGE(); 
	END CATCH  
	select @return_status as return_status, @Id as id, @return_message as return_message;
END






GO
/****** Object:  StoredProcedure [dbo].[USP_StudentInvoice_Transectional_GetByCriteria]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    PROCEDURE [dbo].[USP_StudentInvoice_Transectional_GetByCriteria] (
					
@Criteria nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max);

	set @sql='select stv_acc_StudentInvoice.* from stv_acc_StudentInvoice
	where '+@Criteria;
	--print @sql;
	EXECUTE sp_executesql @sql;

END
GO
/****** Object:  StoredProcedure [dbo].[USP_StudentToClass_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_StudentToClass_Insert] (
@StudentId int,
@Year nvarchar(50),
@ClassId int,
@GroupId int,
@ShiftId int,
@SectionId int,
@RollNo int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from er_StudentToClass where Year=@Year and StudentId=@StudentId)
		begin
			select -1
		end
	else
		begin
		  insert into er_StudentToClass(StudentId,Year,ClassId,GroupId,ShiftId,SectionId,RollNo) values (
		  @StudentId,@Year,@ClassId,@GroupId,@ShiftId,@SectionId,@RollNo)
		  select SCOPE_IDENTITY()
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_StudentToClass_InsertXML]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_StudentToClass_InsertXML] (
@XML nvarchar(max),
@Year nvarchar(50),
@ClassId int,
@GroupId int,
@ShiftId int,
@SectionId int
)
	
AS
DECLARE 
		@pointerDoc int
		Declare @RollNo int
BEGIN
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	set @RollNo= cast((select Max(RollNo) from er_StudentToClass where Year=@Year and ClassId=@ClassId and GroupId=@GroupId and ShiftId=@ShiftId and SectionId=@SectionId) as int)
	INSERT Into er_StudentToClass
	(
	  StudentId,Year,ClassId,GroupId,ShiftId,SectionId,RollNo
	)
	SELECT StId,@Year,@ClassId,@GroupId,@ShiftId,@SectionId,@RollNo+1
	FROM OPENXML(@pointerDoc, 'dsAssign/dtAssign',2)
	WITH (
		StId int
	) XMLReceiveDetailsTable
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_StudentToClass_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_StudentToClass_Update] (
@StudentId int,
@Year nvarchar(50),
@ClassId int,
@GroupId int,
@ShiftId int,
@SectionId int,
@RollNo int
)
	
AS
BEGIN
	SET NOCOUNT ON;

		  update er_StudentToClass set ClassId=@ClassId,GroupId=@GroupId,ShiftId=@ShiftId,SectionId=@SectionId,RollNo=@RollNo
		  where StudentId=@StudentId and Year=@Year

END
GO
/****** Object:  StoredProcedure [dbo].[USP_SubCategory_GetSubCategoryByCategoryId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 18-09-2016
-- =============================================
Create PROCEDURE [dbo].[USP_SubCategory_GetSubCategoryByCategoryId] (
@CategoryId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	
			Select * from lb_SubCategory where CategoryId=@CategoryId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SubCategory_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_SubCategory_Insert] (
@CategoryId int,
@SubCategory nvarchar(100)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from lb_SubCategory where CategoryId=@CategoryId and Subcategory=@SubCategory)
		begin
			select -1
		end
	else
		begin
			insert into lb_SubCategory(SubCategory,CategoryId) values (@SubCategory,@CategoryId)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Subject_GetByClassId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Subject_GetByClassId] (
@ClassId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select er_SubjectToClass.*,
	case when er_SubjectToClass.PaperNo=0 
		 then
			SubjectName
		 else
		   SubjectName+'-'+ cast(PaperNo as nvarchar(50)) end as SubjectName
	 from er_SubjectToClass 
	inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id
	where ClassId=@ClassId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Subject_GetByGetByClassAndGroupId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Subject_GetByGetByClassAndGroupId] (
@ClassId int,
@GroupId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select er_SubjectToClass.*,
	case when er_SubjectToClass.PaperNo=0
		 then
			case when IsOptional=0 then SubjectName else SubjectName+' (Op)' end
		 else
			case when IsOptional=0 then SubjectName+'-'+ cast(PaperNo as nvarchar(50)) else SubjectName+'-'+ cast(PaperNo as nvarchar(50))+' (Op)' end
	end as SubjectName
	from er_SubjectToClass 
	inner join bs_SubjectName on er_SubjectToClass.SubjectId=bs_SubjectName.Id
	where ClassId=@ClassId and GroupId=@GroupId
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Subject_SubjectToStudentInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Subject_SubjectToStudentInsert] (
@CreatedBy nvarchar(50),
@XML nvarchar(max)

)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	INSERT Into er_SubjectToStudent
	(
	  StudentToClassId,SubjectId,IsOptional,CreatedBy,CreatedDate
	)
	SELECT StuId,SubId,Optional,@CreatedBy,Getdate()
	FROM OPENXML(@pointerDoc, 'dsSubject/dtSubject',2)
	WITH (
	    StuId int,
		SubId int,
		Optional bit
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SubjectName_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_SubjectName_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_SubjectName where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SubjectName_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_SubjectName_Insert] (
@Name nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_SubjectName where SubjectName=@Name)
		begin
			select -1
		end
	else
		begin
			insert into bs_SubjectName(SubjectName) values (@Name)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SubjectName_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_SubjectName_Update] (
@Id int,
@Name nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_SubjectName set
	SubjectName=@Name
	where Id=@Id
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SubjectToClass_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_SubjectToClass_Insert] (
@ClassId int,
@GroupId int,
@SubjectId int,
@CategoryId int,
@PaperNo int,
@IsOPtional bit,
@ResultCount bit,
@CreatedBy nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from er_SubjectToClass where ClassId=@ClassId and GroupId=@GroupId and SubjectId=@SubjectId and PaperNo=@PaperNo)
		begin
			select -1
		end
	else
		begin
			insert into er_SubjectToClass(ClassId,GroupId,SubjectId,CategoryId,PaperNo,IsOPtional,ResultCount,CreatedBy,CreatedDate) values 
			(@ClassId,@GroupId,@SubjectId,@CategoryId,@PaperNo,@IsOPtional,@ResultCount,@CreatedBy,GETDATE())
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Task_GetAll] 
	
AS
BEGIN
	SET NOCOUNT ON;
	select *,
case when r.ParentId=0 then 'Root'
else (select TextEng from TaskManager as t where t.Id=r.ParentId) end as Parent from TaskManager as r
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_GetAllByRoleId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[USP_Task_GetAllByRoleId] (
@Role int)
	
AS
BEGIN
	SET NOCOUNT ON;
	if(@Role=1)
		begin
			select * from TaskManager order by OrderColumn asc
		end
	else
		begin
			select TaskManager.* from TaskPermission 
			inner join  TaskManager on TaskPermission.TaskId=TaskManager.Id 
			where TaskPermission.RoleId=@Role order by OrderColumn asc
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Task_GetById] (
@Id int
)
	
AS
BEGIN
	select * from TaskManager where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_GetChild]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Task_GetChild] (
@ParentId int,
@RoleId int
)
AS
BEGIN
	SET NOCOUNT ON;
	if(@RoleId=1)
	begin
		select TaskManager.*,TaskManager.Id as TaskId from TaskManager where parentId=@ParentId order by OrderColumn asc
	end
	else
	begin
		select * from TaskPermission 
		inner join TaskManager on TaskPermission.TaskId=TaskManager.Id 
		where TaskPermission.RoleId=@RoleId and TaskManager.ParentId=@ParentId order by OrderColumn asc
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_GetParent]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Task_GetParent] (
@Role int)
	
AS
BEGIN
	SET NOCOUNT ON;
	if(@Role=1)
		begin
			select * from TaskManager where parentId=0 order by OrderColumn asc
		end
	else
		begin
			select TaskManager.* from TaskPermission 
			inner join  TaskManager on TaskPermission.TaskId=TaskManager.Id 
			where parentId=0 and TaskPermission.RoleId=@Role order by OrderColumn asc
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Task_Insert] (
@TextEng nvarchar(256),
@TextBan nvarchar(256),
@URL nvarchar(256),
@ParentId int,
@CreatedBy nvarchar(256),
@CreatedDate datetime,
@Icon nvarchar(100)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from TaskManager where TextEng=@TextEng and ParentId=@ParentId)
		begin
			select -1
		end
	else
		begin
			insert into TaskManager(TextEng,TextBan,URL,ParentId,CreatedBy,CreatedDate,Icon) values
			(@TextEng,@TextBan,@URL,@ParentId,@CreatedBy,@CreatedDate,@Icon)
			select 1
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Task_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Task_Update] (
@Id int,
@TextEng nvarchar(256),
@TextBan nvarchar(256),
@URL nvarchar(256),
@ParentId int,
@UpdatedBy nvarchar(256),
@UpdatedDate datetime,
@Icon nvarchar(100)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update TaskManager set
	TextEng=@TextEng,
	TextBan=@TextBan,
	URL=@URL,
	ParentId=@ParentId,
	Icon=@Icon,
	UpdatedBy=@UpdatedBy,
	UpdatedDate=@UpdatedDate

	where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TaskPermission_Delete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_TaskPermission_Delete] (
@RoleId int
)
AS
BEGIN
	SET NOCOUNT ON;
	delete from TaskPermission where RoleId=@RoleId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TaskPermission_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_TaskPermission_Insert] (
@Xml nvarchar(MAX)
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into TaskPermission
	(
	  TaskId,
	  RoleId,
	  CreatedBy,
	  CreatedDate
	)
	SELECT TId, RId,CdBy,CDate
	FROM OPENXML(@pointerDoc, 'ds/TaskToRole',2)
	WITH (
		TId int,
		RId int,
		CdBy nvarchar(256),
		CDate datetime
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TC_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 23-01-2017
-- =============================================
CREATE PROCEDURE [dbo].[USP_TC_Insert] (
@RegNo nvarchar(50),
@Remarks nvarchar(250)
)
	
AS
BEGIN
	--SET NOCOUNT ON;
	--insert into ss_Student_TC select *,GETDATE(),@Remarks from ss_Student where RegNo=@RegNo
	--IF EXISTS (select * from ss_Student_TC where RegNo=@RegNo)
	--	begin
	--		Delete from ss_Student  where RegNo=@RegNo
	--	end

	insert into ss_Student_TC(
	[Id]
	,[PersonId]
	,[RegNo]
	,[AdmissionDate]
	,[AdmissionYear]
	,[CreatedBy]
	,[CreatedDate]
	,[UpdatedBy]
	,[UpdatedDate]
	,[CardId]
	,[CardNo]
	,[ApplicationId]
	,[IsAdmitted]
	,[Status]
	,[DisabledReg]
	,[DisabledPersonId]
	,[CurrentBalance]
	,[TcDate]
	,[Reason])		 
	select top 1
	[Id]
	,[PersonId]
	,[RegNo]
	,[AdmissionDate]
	,[AdmissionYear]
	,[CreatedBy]
	,[CreatedDate]
	,[UpdatedBy]
	,[UpdatedDate]
	,[CardId]
	,[CardNo]
	,[ApplicationId]
	,[IsAdmitted]
	,[Status]
	,[DisabledReg]
	,[DisabledPersonId]
	,[CurrentBalance]
	,GETDATE()
	,@Remarks
	from ss_Student where RegNo=@RegNo;
	Delete from ss_Student where RegNo=@RegNo;
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_AttendenceGetByDate]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Teacher_AttendenceGetByDate] (
@Date datetime
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select tr_Attendence.*, st_Person.NameEng from tr_Attendence inner join tr_Teacher on tr_Attendence.TeacherId=tr_Teacher.Id
inner join st_Person on tr_Teacher.PersonId=st_Person.Id where tr_Attendence.Date=@Date
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_AttendenceInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_AttendenceInsert] (
@Xml nvarchar(MAX),
@Year nvarchar(50),
@Month nvarchar(50),
@CreatedBy nvarchar(50),
@CreatedDate datetime
)
AS
DECLARE 
		@pointerDoc int
BEGIN
	
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into tr_Attendence
	(
	  Date,TeacherId,InTime,OutTime,Year,Month,CreatedBy,CreatedDate
	)
	SELECT Dt,TId,timeIn,OutTime,@Year,@Month,@CreatedBy,@CreatedDate
	FROM OPENXML(@pointerDoc, 'dsAttendence/dtAttendence',2)
	WITH (
		Dt datetime,
		TId int,
		timeIn nvarchar(50),
		OutTime nvarchar(50)
	) XMLReceiveDetailsTable
	
	
	EXEC sp_xml_removedocument @pointerDoc
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_EducationInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_EducationInsert] (
@TeacherId int,
@XML nvarchar(max)
)
	
AS
DECLARE @pointerDoc int
BEGIN
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into tr_Education
			(
			  TeacherId,
			  DegreeName,
			  Subject,
			  Board,
			  PassingYear,Grade,GPAScale, ResultDivision
			)
			SELECT @TeacherId,DegreeName,Subject,Board,PassingYear,Grade,GPAScale,ResultDivision
			FROM OPENXML(@pointerDoc, 'dsEducation/dtEducation',2)
			WITH (
				DegreeName nvarchar(256),
				Subject nvarchar(50),
				Board nvarchar(256),
				PassingYear nvarchar(50),
				Grade nvarchar(50),
				GPAScale nvarchar(50),
				ResultDivision nvarchar(50)
			) XMLReceiveDetailsTable
			EXEC sp_xml_removedocument @pointerDoc

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_GetAll] 
	
AS
BEGIN
	SET NOCOUNT ON;
		select st_Person.*,
		bs_Gender.Gender,
		st_PresentAddress.*,
		st_ParmanentAddress.*,
		tr_Teacher.Id as TeacherId,
		tr_Teacher.TeacherPin,
		tr_Teacher.Joindate,
		tr_Teacher.NId,
		Users.UserName
		from tr_Teacher 
		inner join st_Person on tr_Teacher.PersonId=st_Person.Id 
		inner join bs_Designation on tr_Teacher.DesignationId=bs_Designation.Id
		inner join bs_Gender on st_Person.GenderId=bs_Gender.Id
		left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId 
		left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId 
		inner join Users on Users.Id=st_Person.UserId
		where Users.RoleId=3
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_GetByPersonId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_GetByPersonId] (
@PersonId int
)
	
AS
BEGIN
	select t.*,d.Designation from tr_Teacher t inner join bs_Designation d on d.Id=t.DesignationId where t.PersonId=@PersonId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_GetDetailsById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_GetDetailsById] (
@TeacherId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Select tr_Teacher.*,st_Person.*,Users.Password,
	bs_BloodGroup.BloodGroup as BloodGroupName,
	bs_Designation.Designation,
	bs_Gender.Gender,
	bs_Religion.Religion,
	st_ParmanentAddress.DivisionId,
	st_ParmanentAddress.DistrictId,
	st_ParmanentAddress.ThanaId,
	st_ParmanentAddress.Address,
	st_ParmanentAddress.PostalCode,
	st_ParmanentAddress.PostOffice,
	(select Division from bs_Division where bs_Division.Id=st_ParmanentAddress.DivisionId) as DivName,
	(select District  from bs_District where bs_District.Id=st_ParmanentAddress.DistrictId) as DisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_ParmanentAddress.ThanaId) as Thana,
	st_PresentAddress.DivisionId as presentDiv,
	st_PresentAddress.DistrictId as presentDis,
	st_PresentAddress.ThanaId as presentThana,
	st_PresentAddress.PostOffice as presentPO,
	st_PresentAddress.PostalCode as presentPC,
	st_PresentAddress.Address as presentAddress,
	(select Division from bs_Division where bs_Division.Id=st_PresentAddress.DivisionId) as presentDivName,
	(select District  from bs_District where bs_District.Id=st_PresentAddress.DistrictId) as presentDisName,
	(select Thana from bs_Thana where bs_Thana.Id=st_PresentAddress.ThanaId) as presentThanaName,

	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEduId,
	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.FatherQualificationId) as FatherEdu,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.FatherProfessionId) as FatherProId,

	(select Qualification from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEdu,
	(select Id from bs_Qualification where bs_Qualification.Id=st_Person.MotherQualificationId) as MotherEduId,
	(select Profession  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfession,
	(select Id  from bs_Profession where bs_Profession.Id=st_Person.MotherProfessionId) as MotherProfessionId

	from  tr_Teacher
	inner join st_Person  on tr_Teacher.PersonId=st_Person.Id
	inner join Users on st_Person.UserId=Users.Id
	left outer join bs_Gender on st_Person.GenderId=bs_Gender.Id
	left outer join bs_Religion on st_Person.ReligionId=bs_Religion.Id
	left outer join bs_BloodGroup on st_Person.BloodGroup=bs_BloodGroup.Id
	left outer join st_ParmanentAddress on st_Person.Id=st_ParmanentAddress.PersonId
	left outer join st_PresentAddress on st_Person.Id=st_PresentAddress.PersonId
	inner join bs_Designation on bs_Designation.Id=tr_Teacher.DesignationId
	where tr_Teacher.Id=@TeacherId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_Insert] (
@PersonId int,
@DesignationId int,
@TeacherPin nvarchar(50),
@NId nvarchar(50),
@JoinDate datetime,
@CreatedBy nvarchar(50),
@CreatedDate datetime
) 
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @TeacherId int
	declare @pointerDocEdu int
	declare @pointerDocTrain int

	IF EXISTS (select * from tr_Teacher where TeacherPin=@TeacherPin)
		begin
		    delete  from st_Person where Id=@PersonId
			select -1
		end
	else
		begin
			insert into tr_Teacher(PersonId,DesignationId,TeacherPin,NId,Joindate,CreatedBy,CreatedDate) values (
			@PersonId,@DesignationId,@TeacherPin,@NId,@JoinDate,@CreatedBy,GETDATE())
			select SCOPE_IDENTITY()
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_InsertPayScale]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Teacher_InsertPayScale] (
@TypeId int,
@PersonId int
)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from pr_StaffToType where TypeId=@TypeId and PersonId=@PersonId)
		begin
			select -1
		end
	else
		begin
			insert into pr_StaffToType(TypeId,PersonId) Values (@TypeId, @PersonId)
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_TrainingInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Teacher_TrainingInsert] (
@TeacherId int,
@XML nvarchar(max)
)
	
AS
DECLARE @pointerDoc int
BEGIN
	EXEC sp_xml_preparedocument @pointerDoc OUTPUT, @xml
	
	INSERT Into tr_Training
			(
			  TeacherId,TrainingName,InstituteName,StartDate,EndDate,Topics,Duration
			)
			SELECT @TeacherId,TrainingName,InstituteName,StartDate,EndDate,Topics,Duration
			FROM OPENXML(@pointerDoc, 'dsTraining/dtTraining',2)
			WITH (
				TrainingName nvarchar(256),
				InstituteName nvarchar(50),
				StartDate datetime,
				EndDate datetime,
				Topics nvarchar(50),
				Duration int
			) XMLReceiveDetailsTable
			EXEC sp_xml_removedocument @pointerDoc

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Teacher_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
Create PROCEDURE [dbo].[USP_Teacher_Update] (
@PersonId int,
@DesignationId int,
@NId nvarchar(50),
@JoinDate datetime
) 
	
AS
BEGIN
	SET NOCOUNT ON;
	Update tr_Teacher set DesignationId=@DesignationId,NId=@NId,Joindate=@JoinDate where PersonId=@PersonId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TeacherEducation_GetByPersonId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_TeacherEducation_GetByPersonId] (
@TeacherId int
)
	
AS
BEGIN
	select * from tr_Education where TeacherId=@TeacherId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TeacherTraining_GetByPersonId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_TeacherTraining_GetByPersonId] (
@TeacherId int
)
	
AS
BEGIN
	select * from tr_Training where TeacherId=@TeacherId
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Thana_GetByDistrictId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Thana_GetByDistrictId] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Thana where DistrictId=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Thana_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Thana_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Thana where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Thana_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Thana_Insert] (
@DistrictId int,
@Thana nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Thana where DistrictId=@DistrictId and Thana=@Thana)
		begin
			select -1
		end
	else
		begin
			insert into bs_Thana(DistrictId,Thana) values (@DistrictId,@Thana)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Thana_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Thana_Update] (
@Id int,
@DistrictId int,
@Thana nvarchar(250)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Thana set
	Thana=@Thana,
	DistrictId=@DistrictId
	where Id=@Id  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Unis_GetLast]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 24-07-2017
-- =============================================
create PROCEDURE [dbo].[USP_Unis_GetLast] 
	
AS
BEGIN
	SET NOCOUNT ON;
	SELECT MAX(CDate+''+CTime) MXDATE FROM PunchData

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Unis_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 24-07-2017
-- =============================================
CREATE PROCEDURE [dbo].[USP_Unis_Insert] (
@RegNo nvarchar(50),
@CDate nvarchar(8),
@CTime nvarchar(6),
@CardNo nvarchar(50),
@LtId int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from ss_Attendence where Date=Convert(date,@CDate) and StudentToClassId=(Select TOP(1) c.Id from er_StudentToClass c inner join ss_Student s on s.Id=c.StudentId and s.RegNo=@RegNo and c.Year=(select MAX(Year) from er_StudentToClass where StudentId=c.StudentId)))
		begin
			update ss_Attendence set IsPresent=1 where Date=Convert(date,@CDate) and StudentToClassId=(Select TOP(1) c.Id from er_StudentToClass c inner join ss_Student s on s.Id=c.StudentId and s.RegNo=@RegNo and c.Year=(select MAX(Year) from er_StudentToClass where StudentId=c.StudentId))
		end
	else
		begin
			insert into ss_Attendence(StudentToClassId,[Date],IsPresent,Month,Year,CreatedBy,CreatedDate,AttendenceType) 
			values ((Select TOP(1) c.Id from er_StudentToClass c inner join ss_Student s on s.Id=c.StudentId and s.RegNo=@RegNo and c.Year=(select MAX(Year) from er_StudentToClass where StudentId=c.StudentId)),CONVERT(date,@CDate),1,convert(nvarchar(6),DATEPART(mm,CONVERT(date,@CDate))),convert(nvarchar(6),DATEPART(yyyy,CONVERT(date,@CDate))),'UNIS',GETDATE(),1)
	end

	if(not exists(select * from PunchData where CDate=@CDate and CTime=@CTime and RegNo=@RegNo))
		begin
		insert into PunchData(RegNo,CDate,CTime,CardNo,LtId) values(@RegNo,@CDate,@CTime,@CardNo,@LtId)
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateRegNo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 21-12-2016
-- =============================================
Create PROCEDURE [dbo].[USP_UpdateRegNo] (
@PersonId int,
@RegNo nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update ss_Student set RegNo=@RegNo where PersonId=@PersonId

	update Users set UserName=@RegNo where Id=(Select UserId from st_Person where Id=@PersonId)
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_Active]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_Active] (
@Id nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
			Update Users set 
			IsActive=1
			where UserName=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_ChangePassword]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Users_ChangePassword] (
@UserName nvarchar(50),
@Password nvarchar(150)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	Update Users set [Password]=@Password
	where UserName=@UserName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_Delete]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Users_Delete] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
			delete from  Users 
			where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_GetAll]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_GetAll] 
	
AS
BEGIN
	SET NOCOUNT ON;
			select u.*,r.RoleName,p.NameEng from  Users u
			inner join RoleSetup r on r.Id=u.RoleId
			inner join st_person p on p.UserId=u.Id

END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_GetByUserId]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_GetByUserId] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select u.*,r.RoleName,r.Priority, p.NameEng,p.Mobile,p.Email from  Users u 
	inner join RoleSetup r on u.RoleId=r.Id 
	inner join st_person p on p.UserId=u.Id
	
	where u.Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_GetByUserName]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_GetByUserName] (
@UserName nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select u.*,r.RoleName,r.Priority, p.NameEng,p.Mobile,p.Email from  Users u 
	inner join RoleSetup r on u.RoleId=r.Id 
	inner join st_person p on p.UserId=u.Id
	
	where u.UserName=@UserName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Users_GetLoginInfo]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_GetLoginInfo] (
@UserName nvarchar(50),
@Password nvarchar(150)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select Users.*,RoleSetup.RoleName,RoleSetup.Priority,st_Person.Id as PersonId, st_Person.NameEng from  Users inner join RoleSetup
	on Users.RoleId=RoleSetup.Id inner join st_Person
	on Users.Id=st_Person.UserId	
	where Users.UserName=@UserName and [Password]=@Password and Users.IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_InActive]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_InActive] (
@Id nvarchar(50)
)
	
AS
BEGIN
	SET NOCOUNT ON;
			Update Users set 
			IsActive=0
			where UserName=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_Insert] (
@UserName nvarchar(50),
@RoleId int,
@Password nvarchar(256),
@Email nvarchar(150),
@CreateBy nvarchar(50),
@CreateDate datetime
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from Users where UserName=@UserName)
		begin
			select -1
		end
	else
		begin
			insert into Users(UserName,RoleId,Password,Email,CreateBy,CreateDate) values
			(@UserName,@RoleId,@Password,@Email,@CreateBy,@CreateDate)
			select SCOPE_IDENTITY()
		end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_LastLogin]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Users_LastLogin] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
			Update Users set 
			LastLoginDate=SYSDATETIME()
			where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_PersonInsert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Users_PersonInsert] (
@UserId int,
@Name nvarchar(50),
@Mobile nvarchar(20),
@Email nvarchar(150)
)
	
AS
BEGIN
	SET NOCOUNT ON;
	insert into st_person(UserId,NameEng,Mobile,Email) values(@UserId,@Name,@Mobile,@Email)
	select SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Users_Update] (
@Id int,
@RoleId int,
@Email nvarchar(150),
@UpdateBy nvarchar(50),
@UpdateDate datetime
)
	
AS
BEGIN
	SET NOCOUNT ON;
			Update Users set 
			RoleId=@RoleId,
			Email=@Email,
			UpdateBy=@UpdateBy,
			UpdateDate=@UpdateDate
			where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Users_WrongPasswordAttempt]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[USP_Users_WrongPasswordAttempt] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
			Update Users set 
			WrongPasswordAttempt=WrongPasswordAttempt+1
			where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Year_GetById]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Year_GetById] (
@Id int
)
	
AS
BEGIN
	SET NOCOUNT ON;
	select * from bs_Year where Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Year_GetDefault]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
create PROCEDURE [dbo].[USP_Year_GetDefault] 
	
AS
BEGIN
	SET NOCOUNT ON;
	Select * from bs_Year where IsDefault=1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Year_Insert]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Year_Insert] (
@Year nvarchar(250),
@Isdefault bit
)
	
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (select * from bs_Year where Year=@Year)
		begin
			select -1
		end
	else
		begin
			insert into bs_Year(Year,IsDefault) values (@Year,@Isdefault)
			select SCOPE_IDENTITY()
		end

	
  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Year_Update]    Script Date: 2/26/2023 10:47:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Md Sarowar Hossen
-- Create date: 29-09-2015
-- =============================================
CREATE PROCEDURE [dbo].[USP_Year_Update] (
@Id int,
@Year nvarchar(250),
@Isdefault bit
)
	
AS
BEGIN
	SET NOCOUNT ON;
	update bs_Year set
	Year=@Year,
	IsDefault=@Isdefault
	where Id=@Id
  
END
GO

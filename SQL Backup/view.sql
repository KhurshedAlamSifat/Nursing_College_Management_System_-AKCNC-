USE [school]
GO
/****** Object:  View [dbo].[stv_acc_StudentDue]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[stv_acc_StudentDue] AS
SELECT * FROM acc_StudentDue_2021_to_2030
--UNION ALL
--SELECT * FROM acc_StudentDue_2026_to_2030;
GO
/****** Object:  View [dbo].[stv_acc_StudentInvoice]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[stv_acc_StudentInvoice] AS
SELECT * FROM acc_StudentInvoice_2021_to_2030
--UNION ALL
--SELECT * FROM acc_StudentDue_2026_to_2030;
GO
/****** Object:  View [dbo].[ttv_acc_StudentDue]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ttv_acc_StudentDue] AS
SELECT * FROM acc_StudentDue_2021_to_2030
--UNION ALL
--SELECT * FROM acc_StudentDue_2026_to_2030;
GO
/****** Object:  View [dbo].[ttv_acc_StudentInvoice]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[ttv_acc_StudentInvoice] AS
SELECT * FROM acc_StudentInvoice_2021_to_2030
--UNION ALL
--SELECT * FROM acc_StudentDue_2026_to_2030;
GO
/****** Object:  View [dbo].[vw_GetAllStudent]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_GetAllStudent]
AS
SELECT DISTINCT 
                         dbo.er_StudentToClass.Year AS Expr3, dbo.er_StudentToClass.CreatedDate AS Expr4, dbo.er_StudentToClass.UpdatedBy AS Expr5, dbo.er_StudentToClass.UpdatedDate AS Expr6, 
                         dbo.er_StudentToClass.RollNo AS Expr7, dbo.st_Person.Id AS Expr1, dbo.st_Person.NameEng, dbo.st_Person.NameBan, dbo.st_Person.FatherNameEng, dbo.st_Person.FatherNameBan, 
                         dbo.st_Person.MotherNameEng, dbo.st_Person.MotherNameBan, dbo.st_Person.ReligionId, dbo.st_Person.Nationality, dbo.st_Person.DateofBirth, dbo.st_Person.PhoneNo, dbo.st_Person.Mobile, 
                         dbo.st_Person.PhoneHome, dbo.st_Person.MobileHome, dbo.st_Person.Email, dbo.st_Person.Fax, dbo.st_Person.FatherNId, dbo.st_Person.MotherNId, dbo.st_Person.IsFreedomFighter, dbo.st_Person.IsTribal, 
                         dbo.st_Person.IsPhysicallyDefect, dbo.st_Person.FatherIncome, dbo.st_Person.MotherIncome, dbo.st_Person.FatherPhone, dbo.st_Person.MotherPhone, dbo.st_Person.FatherImage, 
                         dbo.st_Person.MotherImage, dbo.st_Person.FatherQualificationId, dbo.st_Person.FatherProfessionId, dbo.st_Person.MotherQualificationId, dbo.st_Person.MotherProfessionId, dbo.st_Person.PersonImage, 
                         dbo.st_Person.GenderId, dbo.st_Person.BirthCertificate, dbo.st_Person.UserId, dbo.bs_ClassName.ClassName, dbo.bs_Group.GroupName, dbo.bs_Shift.Shift, dbo.bs_Section.Section, dbo.Users.UserName, 
                         dbo.ss_Student.RegNo, dbo.bs_BloodGroup.BloodGroup AS Expr2, dbo.er_StudentToClass.*
FROM            dbo.er_StudentToClass INNER JOIN
                         dbo.ss_Student ON dbo.er_StudentToClass.StudentId = dbo.ss_Student.Id INNER JOIN
                         dbo.st_Person ON dbo.ss_Student.PersonId = dbo.st_Person.Id INNER JOIN
                         dbo.bs_ClassName ON dbo.er_StudentToClass.ClassId = dbo.bs_ClassName.Id INNER JOIN
                         dbo.bs_Group ON dbo.er_StudentToClass.GroupId = dbo.bs_Group.Id INNER JOIN
                         dbo.bs_Shift ON dbo.er_StudentToClass.ShiftId = dbo.bs_Shift.Id INNER JOIN
                         dbo.bs_Section ON dbo.er_StudentToClass.SectionId = dbo.bs_Section.Id LEFT OUTER JOIN
                         dbo.st_PresentAddress ON dbo.st_Person.Id = dbo.st_PresentAddress.PersonId INNER JOIN
                         dbo.Users ON dbo.Users.Id = dbo.st_Person.UserId INNER JOIN
                         dbo.bs_BloodGroup ON dbo.st_Person.BloodGroup = dbo.bs_BloodGroup.Id LEFT OUTER JOIN
                         dbo.st_ParmanentAddress ON dbo.st_Person.Id = dbo.st_ParmanentAddress.PersonId
GO
/****** Object:  View [dbo].[vw_PaymentDetails]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_PaymentDetails]
AS
SELECT        TOP (100) PERCENT p.Id, p.StudentId, p.Year, p.Month, p.Date, p.DueAmount, p.Amount, p.TotalGiven, p.CreatedBy, p.CreatedDate, p.UpdatedBy, p.UpdatedDate, p.TxnID, p.PayerMobile, p.IsConfirmed, 
                         p.PaymentTypeId, s.Id AS Expr1, s.PersonId, s.RegNo, s.AdmissionDate, s.AdmissionYear, s.CardId, s.CardNo, s.ApplicationId, s.IsAdmitted, er.StudentId AS Expr7, er.ClassId, er.GroupId, er.ShiftId, er.SectionId, 
                         er.Year AS erYear, er.RollNo, c.ClassName, c.ClassNumber, g.GroupName, sec.Section, sft.Shift, ps.NameEng, ps.NameBan, ps.FatherNameEng, ps.FatherNameBan, ps.MotherNameEng, ps.MotherNameBan, 
                         ps.ReligionId, ps.Nationality, ps.DateofBirth, ps.PhoneNo, ps.Mobile, ps.PhoneHome, ps.MobileHome, ps.Email, ps.Fax, ps.FatherNId, ps.MotherNId, ps.IsFreedomFighter, ps.IsTribal, ps.IsPhysicallyDefect, 
                         ps.FatherIncome, ps.MotherIncome, ps.FatherPhone, ps.MotherPhone, ps.FatherImage, ps.MotherImage, ps.FatherQualificationId, ps.FatherProfessionId, ps.MotherQualificationId, ps.MotherProfessionId, 
                         ps.PersonImage, ps.GenderId, ps.BirthCertificate, ps.UserId, gnd.Gender, rl.Religion, b.BloodGroup, dbo.fee_PaymentType.PaymentType
FROM            dbo.ss_Payment AS p INNER JOIN
                         dbo.ss_Student AS s ON s.Id = p.StudentId INNER JOIN
                         dbo.er_StudentToClass AS er ON er.StudentId = s.Id AND p.Year = er.Year INNER JOIN
                         dbo.bs_ClassName AS c ON c.Id = er.ClassId INNER JOIN
                         dbo.bs_Group AS g ON g.Id = er.GroupId INNER JOIN
                         dbo.bs_Section AS sec ON sec.Id = er.SectionId INNER JOIN
                         dbo.bs_Shift AS sft ON sft.Id = er.ShiftId INNER JOIN
                         dbo.st_Person AS ps ON ps.Id = s.PersonId INNER JOIN
                         dbo.bs_Gender AS gnd ON gnd.Id = ps.GenderId INNER JOIN
                         dbo.bs_Religion AS rl ON rl.Id = ps.ReligionId INNER JOIN
                         dbo.bs_BloodGroup AS b ON b.Id = ps.BloodGroup INNER JOIN
                         dbo.fee_PaymentType ON p.PaymentTypeId = dbo.fee_PaymentType.Id
GO
/****** Object:  View [dbo].[vw_rsMarks]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_rsMarks]
AS
SELECT        m.Id, m.StudentToClassId, m.SubjectId, m.ExamTypeId, m.YearId, m.SubjectiveMarks, m.ObjectiveMarks, m.PracticalMarks, m.OtherMarks, m.CreatedBy, m.CreatedDate, m.UpdatedBy, m.UpdatedDate, 
                         m.BaseMarks, m.CT1, m.CT2, m.CT3, m.Grade, m.GradePoint, m.IsPublished, s.SubjectId AS SbID, sb.SubjectName, CASE WHEN s.PaperNo > 0 THEN sb.SubjectName + '-' + CONVERT(nvarchar(5), s.PaperNo) 
                         ELSE sb.SubjectName END AS Subjects, s.ClassId, s.GroupId, s.PaperNo, s.CategoryId, s.IsOptional, m.CTOutOf, s.ResultCount, c.TotalSubject
FROM            dbo.rs_ObtainMarks AS m INNER JOIN
                         dbo.er_SubjectToClass AS s ON s.Id = m.SubjectId INNER JOIN
                         dbo.bs_SubjectName AS sb ON sb.Id = s.SubjectId INNER JOIN
                         dbo.bs_ClassName AS c ON c.Id = s.ClassId
GO
/****** Object:  View [dbo].[vw_stIdCard]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_stIdCard]
AS
SELECT DISTINCT dbo.st_Person.NameEng, dbo.st_Person.PersonImage, dbo.ss_Student.RegNo, dbo.bs_BloodGroup.BloodGroup
FROM            dbo.ss_Student INNER JOIN
                         dbo.st_Person ON dbo.ss_Student.PersonId = dbo.st_Person.Id LEFT OUTER JOIN
                         dbo.bs_BloodGroup ON dbo.st_Person.BloodGroup = dbo.bs_BloodGroup.Id
WHERE        (dbo.ss_Student.Status = 1)
GO
/****** Object:  View [dbo].[vw_StudentToClass_Last]    Script Date: 2/26/2023 10:45:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_StudentToClass_Last]
AS
	select er_StudentToClass.*
	from ss_Student 
	inner join er_StudentToClass on ss_Student.Id=er_StudentToClass.StudentId 
	where er_StudentToClass.Id=(select Max(Id) from er_StudentToClass as er_StudentToClass_Inner where er_StudentToClass_Inner.StudentId=ss_Student.Id and er_StudentToClass_Inner.Year = 2023)
	
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[4] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -183
         Left = 0
      End
      Begin Tables = 
         Begin Table = "er_StudentToClass"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 204
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ss_Student"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 162
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "st_Person"
            Begin Extent = 
               Top = 163
               Left = 307
               Bottom = 470
               Right = 513
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "bs_ClassName"
            Begin Extent = 
               Top = 6
               Left = 698
               Bottom = 119
               Right = 868
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bs_Group"
            Begin Extent = 
               Top = 6
               Left = 906
               Bottom = 102
               Right = 1076
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bs_Shift"
            Begin Extent = 
               Top = 6
               Left = 1114
               Bottom = 102
               Right = 1284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bs_Section"
            Begin Extent = 
               Top = 192
               Left = 920
               Bottom = 288
               Right = 1090
            End
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_GetAllStudent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "st_PresentAddress"
            Begin Extent = 
               Top = 102
               Left = 1114
               Bottom = 232
               Right = 1284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 203
               Left = 0
               Bottom = 392
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "st_ParmanentAddress"
            Begin Extent = 
               Top = 215
               Left = 648
               Bottom = 345
               Right = 818
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bs_BloodGroup"
            Begin Extent = 
               Top = 291
               Left = 996
               Bottom = 466
               Right = 1166
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_GetAllStudent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_GetAllStudent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[61] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 247
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 268
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "er"
            Begin Extent = 
               Top = 6
               Left = 456
               Bottom = 377
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 664
               Bottom = 262
               Right = 834
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 6
               Left = 872
               Bottom = 102
               Right = 1042
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sec"
            Begin Extent = 
               Top = 6
               Left = 1080
               Bottom = 102
               Right = 1250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sft"
            Begin Extent = 
               Top = 102
               Left = 872
               Bottom = 343
               Right = 1042
            End
            DisplayFlags = 280
            TopColumn = 0
         E' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PaymentDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'nd
         Begin Table = "ps"
            Begin Extent = 
               Top = 102
               Left = 1080
               Bottom = 416
               Right = 1286
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "gnd"
            Begin Extent = 
               Top = 120
               Left = 664
               Bottom = 337
               Right = 834
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rl"
            Begin Extent = 
               Top = 262
               Left = 39
               Bottom = 446
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 210
               Left = 244
               Bottom = 446
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "fee_PaymentType"
            Begin Extent = 
               Top = 273
               Left = 483
               Bottom = 403
               Right = 653
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PaymentDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PaymentDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[5] 2[24] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 222
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 216
               Right = 427
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "sb"
            Begin Extent = 
               Top = 6
               Left = 465
               Bottom = 184
               Right = 635
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 673
               Bottom = 200
               Right = 860
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 32
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_rsMarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_rsMarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_rsMarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[13] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ss_Student"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "st_Person"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 215
               Right = 660
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "bs_BloodGroup"
            Begin Extent = 
               Top = 120
               Left = 698
               Bottom = 216
               Right = 868
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2010
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2430
         Table = 3225
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_stIdCard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_stIdCard'
GO

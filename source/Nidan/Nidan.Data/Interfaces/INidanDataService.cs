﻿using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Nidan.Entity;
using Nidan.Entity.Dto;


namespace Nidan.Data.Interfaces
{
    public interface INidanDataService
    {

        // Create
        Personnel CreatePersonnel(int organisationId, Personnel personnel);
        T Create<T>(int organisationId, T t) where T : class;
        void Create<T>(int organisationId, IEnumerable<T> t) where T : class;

        AbsenceType CreateAbsenceType(int organisationId, AbsenceType absenceType);

        Enquiry CreateEnquiry(int organisationId, Enquiry enquiry);

        Mobilization CreateMobilization(int organisationId, Mobilization mobilization);

        Trainer CreateTrainer(int organisationId, Trainer trainer);

        AreaOfInterest CreateAreaOfInterest(int organisationId, AreaOfInterest areaOfInterest);
        Centre CreateCentre(int organisationId, Centre centre);
        Batch CreateBatch(int organisationId, Batch batch);

        Question CreateQuestion(int organisationId, Question question);
        Event CreateEvent(int organisationId, Event eventplan);
        Course CreateCourse(int organisationId, Course course);
        CourseInstallment CreateCourseInstallment(int organisationId, CourseInstallment courseInstallment);
        BatchPlanner CreateBatchPlanner(int organisationId, BatchPlanner batchPlanner);
        FollowUp CreateFollowUp(int organisationId, FollowUp followUp);
        Subject CreateSubject(int organisationId, Subject subject);
        Session CreateSession(int organisationId, Session session);
        Room CreateRoom(int organisationId, Room room);
        BatchDay CreateBatchDay(int organisationId, BatchDay batchDay);
        Admission CreateAdmission(int organisationId, Admission admission);
        Counselling CreateCounselling(int organisationId, Counselling counselling);
        CandidateFee CreateCandidateFee(int organisationId, CandidateFee candidateFee);
        Module CreateModule(int organisationId, Module module);
        Attendance CreateAttendance(int organisationId, Attendance attendance);
        BatchAttendance CreateBatchAttendance(int organisationId, BatchAttendance batchAttendance);
        FixAsset CreateFixAsset(int organisationId, FixAsset fixAsset);
        ActivityAssigneeGroup CreateActivityAssigneeGroup(int organisationId, ActivityAssigneeGroup activityAssigneeGroup);
        Activity CreateActivity(int organisationId, Activity activity);
        ActivityTask CreateActivityTask(int organisationId, ActivityTask activityTask);
        ActivityTaskState CreateActivityTaskState(int organisationId, ActivityTaskState activityTaskState);
        EventManagement CreateEventManagement(int organisationId, EventManagement eventManagement);

        // Retrieve
        PagedResult<Event> RetrieveEvents(int organisationId, Expression<Func<Event, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Event RetrieveEvent(int organisationId, int eventId, Expression<Func<Event, bool>> predicate);
        AbsenceType RetrieveAbsenceType(int organisationId, int absenceTypeId, Expression<Func<AbsenceType, bool>> predicate);
        PagedResult<AbsenceType> RetrieveAbsenceTypes(int organisationId, Expression<Func<AbsenceType, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        IEnumerable<Colour> RetrieveColours(Expression<Func<Colour, bool>> predicate);
        IEnumerable<Host> RetrieveHosts();
        IEnumerable<Organisation> RetrieveOrganisations();
        Personnel RetrievePersonnel(int organisationId, int personnelId, Expression<Func<Personnel, bool>> predicate);
        IEnumerable<Personnel> RetrievePersonnel(int organisationId, IEnumerable<int> companyIds, IEnumerable<int> departmentIds, IEnumerable<int> divisionIds);
        PagedResult<Personnel> RetrievePersonnels(int organisationId, Expression<Func<Personnel, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        UserAuthorisationFilter RetrieveUserAuthorisation(string aspNetUserId);
        PagedResult<PersonnelSearchField> RetrievePersonnelBySearchKeyword(int organisationId, string searchKeyword, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Question> RetrieveQuestions(int organisationId, Expression<Func<Question, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        List<T> Retrieve<T>(int organisationId, Expression<Func<T, bool>> predicate) where T : class;
        bool PersonnelEmploymentHasAbsences(int organisationId, int personnelId, int employmentId);
        Question RetrieveQuestion(int organisationId, int questionId, Expression<Func<Question, bool>> predicate);
        PagedResult<EnquiryDataGrid> RetrieveEnquiries(int organisationId, Expression<Func<EnquiryDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Enquiry RetrieveEnquiry(int organisationId, int enquiryId, Expression<Func<Enquiry, bool>> predicate);
        PagedResult<Mobilization> RetrieveMobilizations(int organisationId, Expression<Func<Mobilization, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Mobilization RetrieveMobilization(int organisationId, int mobilizationId, Expression<Func<Mobilization, bool>> predicate);
        AreaOfInterest RetrieveAreaOfInterest(int organisationId, int areaOfInterestId, Expression<Func<AreaOfInterest, bool>> predicate);
        PagedResult<AreaOfInterest> RetrieveAreaOfInterests(int organisationId, Expression<Func<AreaOfInterest, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<FollowUp> RetrieveFollowUps(int organisationId, Expression<Func<FollowUp, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<FollowUpSearchField> RetrieveFollowUpsData(int organisationId, Expression<Func<FollowUpSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        FollowUp RetrieveFollowUp(int organisationId, int followUpId, Expression<Func<FollowUp, bool>> predicate);
        PagedResult<Mobilization> RetrieveMobilizationBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<Mobilization, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<EnquirySearchField> RetrieveEnquiryBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<EnquirySearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Centre> RetrieveCentres(int organisationId, Expression<Func<Centre, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Centre> RetrieveCentres(int organisationId, List<OrderBy> orderBy = null, Paging paging = null);
        Centre RetrieveCentre(int organisationId, int centreId, Expression<Func<Centre, bool>> predicate);
        Course RetrieveCourse(int organisationId, int courseId, Expression<Func<Course, bool>> predicate);
        PagedResult<Course> RetrieveCourseBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<Course, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Course> RetrieveCourses(int organisationId, Expression<Func<Course, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Counselling> RetrieveCounsellings(int organisationId, Expression<Func<Counselling, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CounsellingDataGrid> RetrieveCounsellingDataGrid(int organisationId, Expression<Func<CounsellingDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Counselling RetrieveCounselling(int organisationId, int counsellingId, Expression<Func<Counselling, bool>> predicate);
        PagedResult<Batch> RetrieveBatches(int organisationId, Expression<Func<Batch, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Batch RetrieveBatch(int organisationId, int batchId, Expression<Func<Batch, bool>> predicate);
        PagedResult<CounsellingSearchField> RetrieveCounsellingBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<CounsellingSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Template RetrieveTemplateDetails(int organisationId, string name);
        PagedResult<Trainer> RetrieveTrainers(int organisationId, Expression<Func<Trainer, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Trainer RetrieveTrainer(int organisationId, int trainerId, Expression<Func<Trainer, bool>> predicate);
        PagedResult<Trainer> RetrieveTrainerBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<Trainer, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Registration> RetrieveRegistrations(int organisationId, Expression<Func<Registration, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CourseInstallment> RetrieveCourseInstallments(int organisationId, Expression<Func<CourseInstallment, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CourseInstallment RetrieveCourseInstallment(int organisationId, int courseInstallmentId, Expression<Func<CourseInstallment, bool>> predicate);
        PagedResult<CourseInstallment> RetrieveCourseInstallmentBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<CourseInstallment, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Subject> RetrieveSubjects(int organisationId, Expression<Func<Subject, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Subject RetrieveSubject(int organisationId, int subjectId, Expression<Func<Subject, bool>> predicate);
        PagedResult<Holiday> RetrieveHolidays(int organisationId, Expression<Func<Holiday, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Holiday RetrieveHoliday(int organisationId, int holidayId, Expression<Func<Holiday, bool>> predicate);
        PagedResult<Session> RetrieveSessions(int organisationId, Expression<Func<Session, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Session RetrieveSession(int organisationId, int sessionId, Expression<Func<Session, bool>> predicate);
        PagedResult<Room> RetrieveRooms(int organisationId, Expression<Func<Room, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Room RetrieveRoom(int organisationId, int roomId, Expression<Func<Room, bool>> predicate);
        BatchDay RetrieveBatchDay(int organisationId, int batchDayId, Expression<Func<BatchDay, bool>> predicate);
        PagedResult<BatchDay> RetrieveBatchDays(int organisationId, Expression<Func<BatchDay, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        IEnumerable<EnquiryCourse> RetrieveEnquiryCourses(int organisationId, int centreId, int enquiryId);
        IEnumerable<SubjectCourse> RetrieveSubjectCourses(int organisationId, Expression<Func<SubjectCourse, bool>> predicate);
        IEnumerable<SubjectTrainer> RetrieveSubjectTrainers(int organisationId, int subjectId);
        PagedResult<CentreCourse> RetrieveCentreCourses(int organisationId, int centreId, List<OrderBy> orderBy = null, Paging paging = null);
        IEnumerable<BatchTrainer> RetrieveBatchTrainers(int organisationId, int batchId);
        PagedResult<CentreCourseInstallment> RetrieveCentreCourseInstallments(int organisationId, int centreId, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CentreScheme> RetrieveCentreSchemes(int organisationId, int centreId, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CentreSector> RetrieveCentreSectors(int organisationId, int centreId, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Scheme> RetrieveSchemes(int organisationId, Expression<Func<Scheme, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Sector> RetrieveSectors(int organisationId, Expression<Func<Sector, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Admission> RetrieveAdmissions(int organisationId, Expression<Func<Admission, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Admission RetrieveAdmission(int organisationId, int admissionId, Expression<Func<Admission, bool>> predicate);
        PagedResult<CandidateFee> RetrieveCandidateFees(int organisationId, Expression<Func<CandidateFee, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CandidateFee RetrieveCandidateFee(int organisationId, int candidateFeeId, Expression<Func<CandidateFee, bool>> predicate);
        PagedResult<CandidateFeeSearchField> RetrieveCandidateFeeBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<CandidateFeeSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        IEnumerable<CentreCourse> RetrieveCentreCourses(int organisationId, int centreId, Expression<Func<CentreCourse, bool>> predicate);
        IEnumerable<CentreScheme> RetrieveCentreSchemes(int organisationId, int centreId, Expression<Func<CentreScheme, bool>> predicate);
        IEnumerable<CentreSector> RetrieveCentreSectors(int organisationId, int centreId, Expression<Func<CentreSector, bool>> predicate);
        IEnumerable<RoomAvailable> RetrieveRoomAvailables(int organisationId, int centreId, Expression<Func<RoomAvailable, bool>> predicate);
        IEnumerable<TrainerAvailable> RetrieveTrainerAvailables(int organisationId, int centreId, Expression<Func<TrainerAvailable, bool>> predicate);
        PagedResult<CandidateInstallment> RetrieveCandidateInstallments(int organisationId, Expression<Func<CandidateInstallment, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CandidateInstallment RetrieveCandidateInstallment(int organisationId, int candidateInstallmentId, Expression<Func<CandidateInstallment, bool>> predicate);
        Registration RetrieveRegistration(int organisationId, int registrationId, Expression<Func<Registration, bool>> predicate);
        Registration RetrieveRegistration(int organisationId, int centreId, int registrationId, Expression<Func<Registration, bool>> predicate);
        PagedResult<FollowUpHistoryData> RetrieveFollowUpHistories(int organisationId, Expression<Func<FollowUpHistoryData, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        FollowUpHistory RetrieveFollowUpHistory(int organisationId, int followUpHistoryId, Expression<Func<FollowUpHistory, bool>> predicate);
        PagedResult<FollowUpSearchField> RetrieveFollowUpBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<FollowUpSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<RegistrationGrid> RetrieveRegistrationBySearchKeyword(int organisationId, Expression<Func<RegistrationGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<AdmissionGrid> RetrieveAdmissionBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<AdmissionGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Module> RetrieveModules(int organisationId, Expression<Func<Module, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Module RetrieveModule(int organisationId, int moduleId, Expression<Func<Module, bool>> predicate);
        PagedResult<CandidateInstallmentSearchField> RetrieveCandidateInstallmentBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<CandidateInstallmentSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<AdmissionGrid> RetrieveAdmissionGrid(int organisationId, Expression<Func<AdmissionGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CandidateInstallmentGrid> RetrieveCandidateInstallmentGrid(int organisationId, Expression<Func<CandidateInstallmentGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ExpenseHeader> RetrieveExpenseHeaders(int organisationId, Expression<Func<ExpenseHeader, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        ExpenseHeader RetrieveExpenseHeader(int organisationId, int expenseHeaderId, Expression<Func<ExpenseHeader, bool>> predicate);
        PagedResult<OtherFee> RetrieveOtherFees(int organisationId, int centreId, Expression<Func<OtherFee, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        OtherFee RetrieveOtherFee(int organisationId, int centreId, int otherFeeId, Expression<Func<OtherFee, bool>> predicate);
        PagedResult<Project> RetrieveProjects(int organisationId, Expression<Func<Project, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Project RetrieveProject(int organisationId, int projectId, Expression<Func<Project, bool>> predicate);
        PagedResult<CentrePettyCash> RetrieveCentrePettyCashs(int organisationId, int centreId, Expression<Func<CentrePettyCash, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CentrePettyCash RetrieveCentrePettyCash(int organisationId, int centreId, int centrePettyCashId, Expression<Func<CentrePettyCash, bool>> predicate);
        PagedResult<CandidateFeeGrid> RetrieveCandidateFeeGrid(int organisationId, Expression<Func<CandidateFeeGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<MobilizationDataGrid> RetrieveMobilizationDataGrid(int organisationId, Expression<Func<MobilizationDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<EnquiryDataGrid> RetrieveEnquiryDataGrid(int organisationId, Expression<Func<EnquiryDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<FollowUpDataGrid> RetrieveFollowUpDataGrid(int organisationId, Expression<Func<FollowUpDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Voucher> RetrieveVouchers(int organisationId, int centreId, Expression<Func<Voucher, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Voucher RetrieveVoucher(int organisationId, int centreId, int voucherId, Expression<Func<Voucher, bool>> predicate);
        PagedResult<VoucherGrid> RetrieveVoucherGrids(int organisationId, int centreId, Expression<Func<VoucherGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<RegistrationGrid> RetrieveRegistrationGrid(int organisationId, Expression<Func<RegistrationGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<Expense> RetrieveExpenses(int organisationId, int centreId, Expression<Func<Expense, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Expense RetrieveExpense(int organisationId, int centreId, int expenseId, Expression<Func<Expense, bool>> predicate);
        IEnumerable<ExpenseProject> RetrieveExpenseProjects(int organisationId, int centreId, int expenseId);
        CentreVoucherNumber RetrieveCentreVoucherNumber(int organisationId, int centreId, Expression<Func<CentreVoucherNumber, bool>> predicate);
        PagedResult<Attendance> RetrieveAttendances(int organisationId, Expression<Func<Attendance, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Attendance RetrieveAttendance(int organisationId, int attendanceId, Expression<Func<Attendance, bool>> predicate);
        PagedResult<BatchAttendance> RetrieveBatchAttendances(int organisationId, Expression<Func<BatchAttendance, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        BatchAttendance RetrieveBatchAttendance(int organisationId, int batchattendanceId, Expression<Func<BatchAttendance, bool>> predicate);
        PagedResult<AttendanceGrid> RetrieveAttendanceGrid(int organisationId, Expression<Func<AttendanceGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CounsellingDataGrid> RetrieveCounsellingGrid(int organisationId, Expression<Func<CounsellingDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ExpenseDataGrid> RetrieveExpenseDataGrid(int organisationId, Expression<Func<ExpenseDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<MobilizationDataGrid> RetrieveMobilizationDataGrid(int organisationId, string searchKeyword, Expression<Func<MobilizationDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<PettyCashExpenseReport> RetrievePettyCashExpenseReports(int organisationId, Expression<Func<PettyCashExpenseReport, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<MobilizationCentreReportMonthWise> RetriveMobilizationCountReportByMonthAndYear(int organisationId, int centreId, Expression<Func<MobilizationCentreReportMonthWise, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BankDepositeCentreReportMonthWise> RetriveBankDepositeReportByMonthAndYear(int organisationId, int centreId, Expression<Func<BankDepositeCentreReportMonthWise, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<MobilizationCentreReport> RetriveMobilizationCountReportByDate(int organisationId, int centreId, Expression<Func<MobilizationCentreReport, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BankDepositeCentreReport> RetriveBankDepositeReportByDate(int organisationId, int centreId, Expression<Func<BankDepositeCentreReport, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<MobilizationCentreReportMonthWise> RetriveMobilizationCountReportByMonthWise(int organisationId, Expression<Func<MobilizationCentreReportMonthWise, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BankDepositeCentreReportMonthWise> RetriveBankDepositeCentreReportMonthWise(int organisationId, Expression<Func<BankDepositeCentreReportMonthWise, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Gst RetrieveGst(int organisationId, Expression<Func<Gst, bool>> predicate);
        PagedResult<Gst> RetrieveGsts(int organisationId, Expression<Func<Gst, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CentreReceiptSetting RetrieveCentreReceiptSetting(int organisationId, Expression<Func<CentreReceiptSetting, bool>> predicate);
        PagedResult<CentreReceiptSetting> RetrieveCentreReceiptSettings(int organisationId, Expression<Func<CentreReceiptSetting, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CentreEnrollmentReceiptSetting> RetrieveCentreEnrollmentReceiptSettings(int organisationId, Expression<Func<CentreEnrollmentReceiptSetting, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CentreEnrollmentReceiptSetting RetrieveCentreEnrollmentReceiptSetting(int organisationId, Expression<Func<CentreEnrollmentReceiptSetting, bool>> predicate);
        PagedResult<BiometricAttendanceGrid> RetrieveBiometricAttendanceGrid(int organisationId, Expression<Func<BiometricAttendanceGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<StockPurchase> RetrieveStockPurchases(int organisationId, int centreId, Expression<Func<StockPurchase, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        StockPurchase RetrieveStockPurchase(int organisationId, int stockPurchaseId, Expression<Func<StockPurchase, bool>> predicate);
        PagedResult<StockIssue> RetrieveStockIssues(int organisationId, int centreId, Expression<Func<StockIssue, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        StockIssue RetrieveStockIssue(int organisationId, int centreId, int stockIssueId, Expression<Func<StockIssue, bool>> predicate);
        PagedResult<StockDataGrid> RetrieveStockDataGrid(int organisationId, Expression<Func<StockDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<StockDataGrid> RetrieveStockDataGrid(int organisationId, string searchKeyword, Expression<Func<StockDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        FixAsset RetrieveFixAsset(int organisationId, int fixAssetId, Expression<Func<FixAsset, bool>> predicate);
        PagedResult<StockReportDataGrid> RetrieveStockReportDataGrid(int organisationId, Expression<Func<StockReportDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BatchPlanner> RetrieveBatchPlanners(int organisationId, Expression<Func<BatchPlanner, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        BatchPlanner RetrieveBatchPlanner(int organisationId, int batchPlannerId, Expression<Func<BatchPlanner, bool>> predicate);
        BatchPlannerDay RetrieveBatchPlannerDay(int organisationId, int batchPlannerDayId, Expression<Func<BatchPlannerDay, bool>> predicate);
        PagedResult<BatchPlannerDay> RetrieveBatchPlannerDays(int organisationId, Expression<Func<BatchPlannerDay, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CentreProductSetting RetrieveCentreProductSetting(int organisationId, Expression<Func<CentreProductSetting, bool>> predicate);
        PagedResult<CentreProductSetting> RetrieveCentreProductSettings(int organisationId, Expression<Func<CentreProductSetting, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BatchPlannerGrid> RetrieveBatchPlannerGrids(int organisationId, Expression<Func<BatchPlannerGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<FixAssetDataGrid> RetrieveFixAssetDataGrid(int organisationId, Expression<Func<FixAssetDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BatchAttendanceDataGrid> RetrieveBatchAttendanceDataGrid(int organisationId, Expression<Func<BatchAttendanceDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CentreItemSetting RetrieveCentreItemSetting(int organisationId,int centreId,int itemId);
        PagedResult<FixAsset> RetrieveFixAssets(int organisationId, Expression<Func<FixAsset, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<FixAssetMapping> RetrieveFixAssetMappings(int organisationId, Expression<Func<FixAssetMapping, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<SummaryReport> RetrieveSummaryReports(int organisationId, int centreId, Expression<Func<SummaryReport, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<AvailablePettyCashGrid> RetrieveAvailablePettyCashGrid(int organisationId, Expression<Func<AvailablePettyCashGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BankDepositeSearchField> RetrieveBankDeposites(int organisationId, Expression<Func<BankDepositeSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        BankDeposite RetrieveBankDeposite(int organisationId, int bankDepositeId, Expression<Func<BankDeposite, bool>> predicate);
        PagedResult<ExpenseHeadLimit> RetrieveExpenseHeadLimits(int organisationId, int centreId, Expression<Func<ExpenseHeadLimit, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        FixAssetMapping RetrieveFixAssetMapping(int organisationId, int fixAssetMappingId, Expression<Func<FixAssetMapping, bool>> predicate);
        PagedResult<FixAssetMappingCountByCentre> RetrieveFixAssetMappingCountByCentre(int organisationId, Expression<Func<FixAssetMappingCountByCentre, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<FixAssetDetailGrid> RetrieveFixAssetDetailGrid(int organisationId, Expression<Func<FixAssetDetailGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ActivityAssigneeGroup> RetrieveActivityAssigneeGroups(int organisationId, Expression<Func<ActivityAssigneeGroup, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        ActivityAssigneeGroup RetrieveActivityAssigneeGroup(int organisationId, int activityAssigneeGroupId, Expression<Func<ActivityAssigneeGroup, bool>> predicate);
        PagedResult<Activity> RetrieveActivities(int organisationId, Expression<Func<Activity, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Activity RetrieveActivity(int organisationId, int activityId, Expression<Func<Activity, bool>> predicate);
        PagedResult<ActivityTask> RetrieveActivityTasks(int organisationId, Expression<Func<ActivityTask, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        ActivityTask RetrieveActivityTask(int organisationId, int activityTaskId, Expression<Func<ActivityTask, bool>> predicate);
        PagedResult<ActivityTaskState> RetrieveActivityTaskStates(int organisationId, Expression<Func<ActivityTaskState, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        ActivityTaskState RetrieveActivityTaskState(int organisationId, int activityTaskStateId, Expression<Func<ActivityTaskState, bool>> predicate);
        PagedResult<ActivityType> RetrieveActivityTypes(int organisationId, Expression<Func<ActivityType, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<TaskState> RetrieveTaskStates(int organisationId, Expression<Func<TaskState, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ActivityAssignPersonnel> RetrieveActivityAssignPersonnels(int organisationId, int centreId, int activityAssigneeGroupId, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ActivityDataGrid> RetrieveActivityBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<ActivityDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ActivityDataGrid> RetrieveActivityDataGrids(int organisationId, Expression<Func<ActivityDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BankDepositeSearchField> RetrieveBankDepositeBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<BankDepositeSearchField, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ModuleExamSet> RetrieveModuleExamSets(int organisationId, Expression<Func<ModuleExamSet, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        ModuleExamSet RetrieveModuleExamSet(int organisationId, int moduleExamSetId, Expression<Func<ModuleExamSet, bool>> predicate);
        PagedResult<ModuleExamQuestionAnswerGrid> RetrieveModuleExamQuestionSets(int organisationId, Expression<Func<ModuleExamQuestionAnswerGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        ModuleExamQuestionSet RetrieveModuleExamQuestionSet(int organisationId, int moduleExamQuestionSetId, Expression<Func<ModuleExamQuestionSet, bool>> predicate);
        PagedResult<ActivityTaskDataGrid> RetrieveActivityTaskBySearchKeyword(int organisationId, string searchKeyword, Expression<Func<ActivityTaskDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ActivityTaskDataGrid> RetrieveActivityTaskDataGrids(int organisationId, Expression<Func<ActivityTaskDataGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Assessment RetrieveAssessment(int organisationId, int assessmentId, Expression<Func<Assessment, bool>> predicate);
        PagedResult<AssessmentGrid> RetrieveAssessmentGrid(int organisationId, Expression<Func<AssessmentGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CandidateAssessmentGrid> RetrieveCandidateAssessmentGrid(int organisationId,Expression<Func<CandidateAssessmentGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CandidateAssessment RetrieveCandidateAssessment(int organisationId, int candidateAssessmentId, Expression<Func<CandidateAssessment, bool>> predicate);
        Partner RetrievePartner(int organisationId, int partnerId, Expression<Func<Partner, bool>> predicate);
        PagedResult<Partner> RetrievePartners(int organisationId, Expression<Func<Partner, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<BatchTrainer> RetrieveBatchTrainers(int organisationId, Expression<Func<BatchTrainer, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<ModuleExamQuestionSetGrid> RetrieveModuleExamQuestionSetGrid(int organisationId, Expression<Func<ModuleExamQuestionSetGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CandidateAssessmentQuestionAnswer> RetrieveCandidateAssessmentQuestionAnswers(int organisationId, Expression<Func<CandidateAssessmentQuestionAnswer, bool>> predicate,List<OrderBy> orderBy = null, Paging paging = null);
        CandidateAssessmentQuestionAnswer RetrieveCandidateAssessmentQuestionAnswer(int organisationId,int candidateAssessmentQuestionAnswerId);
        PagedResult<CandidateAttemptedQuestionAnswerGrid> RetrieveCandidateAttemptedQuestionAnswerGrid(int organisationId, Expression<Func<CandidateAttemptedQuestionAnswerGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        EventQuestion RetrieveEventQuestion(int organisationId, int eventQuestionId, Expression<Func<EventQuestion, bool>> predicate);
        PagedResult<EventQuestion> RetrieveEventQuestions(int organisationId, Expression<Func<EventQuestion, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        EventManagement RetrieveEventManagement(int organisationId, int eventManagementId, Expression<Func<EventManagement, bool>> predicate);
        PagedResult<EventManagement> RetrieveEventManagements(int organisationId, Expression<Func<EventManagement, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Company RetrieveCompany(int organisationId, int companyId);
        PagedResult<Company> RetrieveCompanies(int organisationId, Expression<Func<Company, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        EventManagementGrid RetrieveEventManagementGrid(int organisationId, int eventManagementId, Expression<Func<EventManagementGrid, bool>> predicate);
        PagedResult<EventManagementGrid> RetrieveEventManagementGrids(int organisationId, Expression<Func<EventManagementGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CompanyBranch RetrieveCompanyBranch(int organisationId, int companyBranchId);
        PagedResult<CompanyBranchGrid> RetrieveCompanyBranches(int organisationId, Expression<Func<CompanyBranchGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        CompanyFollowUp RetrieveCompanyFollowUp(int organisationId, int companyFollowUpId);
        PagedResult<CompanyFollowUpGrid> RetrieveCompanyFollowUpGrid(int organisationId, Expression<Func<CompanyFollowUpGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<CompanyFollowUpHistoryGrid> RetrieveCompanyFollowUpHistoryGrid(int organisationId, Expression<Func<CompanyFollowUpHistoryGrid, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);

        // Update
        T UpdateEntityEntry<T>(T t) where T : class;
        T UpdateOrganisationEntityEntry<T>(int organisationId, T t) where T : class;
        bool UpdateEventManagement(int organisationId,int centreId, int eventId, List<EventManagement> eventManagements);
        // Delete
        void Delete<T>(int organisationId, Expression<Func<T, bool>> predicate) where T : class;
        void DeleteList<T>(int organisationId, Expression<Func<T, bool>> predicate) where T : class;


        //Document
        IEnumerable<DocumentType> RetrieveDocumentTypes(int organisationId);
        IEnumerable<Document> RetrieveDocuments(int organisationId, int centreId, string category, string studentCode);
        PagedResult<Document> RetrieveDocuments(int organisationId, Expression<Func<Document, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        PagedResult<DocumentType> RetrieveDocumentTypes(int organisationId, Expression<Func<DocumentType, bool>> predicate, List<OrderBy> orderBy = null, Paging paging = null);
        Document RetrieveDocument(int organisationId, Guid documentGuid);
        //PagedResult<Personnel> RetrievePersonnel(int organisationId, Func<Personnel, bool> predicate, List<OrderBy> orderBy, Paging paging);
    }
}

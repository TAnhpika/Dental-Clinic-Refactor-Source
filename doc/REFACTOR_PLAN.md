# KẾ HOẠCH REFACTOR CẤU TRÚC SOURCE CODE

## 📋 TỔNG QUAN

Refactor từ cấu trúc hiện tại sang cấu trúc chuẩn theo `HUONG_DAN_CAU_TRUC_THU_MUC.md`

### Cấu trúc hiện tại:
```
src/
├── java/
│   ├── Filter/           # 4 files
│   ├── controller/       # 76 files
│   ├── dao/             # 21 files
│   ├── model/           # 24 files
│   └── utils/
└── conf/
```

### Cấu trúc mục tiêu:
```
src/
└── java/
    └── com/
        └── dentalclinic/
            ├── controller/
            │   ├── auth/
            │   ├── appointment/
            │   ├── treatment/
            │   ├── medicine/
            │   ├── payment/
            │   ├── messaging/
            │   ├── admin/
            │   └── profile/
            ├── model/
            │   ├── entity/
            │   └── dto/
            ├── dao/
            │   ├── interfaces/
            │   └── impl/
            ├── service/
            │   ├── interfaces/
            │   └── impl/
            ├── filter/
            ├── listener/
            ├── util/
            └── exception/
```

---

## 🎯 PHÂN LOẠI CONTROLLER (76 files)

### 1. **auth/** - Authentication & Authorization (9 files)
- LoginServlet.java
- LogoutServlet.java
- RegisterServlet.java
- RegisterInformation.java
- ChangePasswordServlet.java
- ResetPasswordServlet.java
- UpdatePasswordServlet.java
- FaceIdLoginServlet.java
- GoogleCallbackServlet.java

### 2. **appointment/** - Quản lý lịch hẹn (15 files)
- BookingServlet.java
- BookingPageServlet.java
- CancelAppointmentServlet.java
- RescheduleAppointmentServlet.java
- ConfirmServlet.java
- DoctorAppointmentsServlet.java
- PatientAppointmentsServlet.java
- StaffBookingServlet.java
- CancelledAppointmentsServlet.java
- CompletedAppointmentsServlet.java
- DoctorHaveAppointmentServlet.java
- GetAvailableSlotsServlet.java
- RelativesAppointmentServlet.java
- StaffHandleQueueServlet.java
- ViewAppointmentServlet.java

### 3. **schedule/** - Quản lý lịch làm việc (8 files)
- DoctorRegisterScheduleServlet.java
- DoctorScheduleConfirmServlet.java
- DoctorWorkDaysServlet.java
- StaffRegisterSecheduleServlet.java
- ManagerApprovalDoctorSchedulerServlet.java
- ManagerApprovalStaffScheduleServlet.java
- StaffScheduleApprovalServlet.java
- StaffScheduleServlet.java

### 4. **treatment/** - Điều trị & Hồ sơ bệnh án (8 files)
- MedicalReportServlet.java
- CreateMedicalReportServlet.java
- InputMedicalReportServlet.java
- MedicalReportDetailServlet.java
- UpdateMedicalReportServlet.java
- DeleteMedicalReportServlet.java
- ExportMedicalReportServlet.java
- AddReportServlet.java

### 5. **medicine/** - Quản lý thuốc & Đơn thuốc (6 files)
- SellMedicineServlet.java
- ConfirmSellMedicineServlet.java
- StaffMedicineServlet.java
- StaffPrescriptionServlet.java
- ViewPrescriptionServlet.java
- UpdateStockServlet.java

### 6. **payment/** - Thanh toán (7 files)
- PayOSServlet.java
- PaymentConfirmServlet.java
- StaffPaymentServlet.java
- CheckBillServlet.java
- ViewBillServlet.java
- ViewPaymentServlet.java
- UserPaymentServlet.java

### 7. **messaging/** - Tin nhắn & Chat (6 files)
- ChatServlet.java
- ChatHistoryServlet.java
- ChatAiServlet.java
- MedicalNoteAiServlet.java
- BlogServlet.java
- ServiceServlet.java

### 8. **admin/** - Quản trị hệ thống (12 files)
- AddStaffServlet.java
- DeleteStaffServlet.java
- EditDoctorServlet.java
- ManagerCustomerListServlet.java
- ManagerResetStaffPasswordServlet.java
- StaffInfoServlet.java
- UserHompageServlet.java
- UserRegisterWhenTheyNotRegisterInformation.java
- CloudflareManagementServlet.java
- NotificationServlet.java
- TwilioCallServlet.java
- TwilioSMSServlet.java

### 9. **profile/** - Hồ sơ cá nhân (5 files)
- AvatarServlet.java
- DoctorHomePageServlet.java
- LandingPageServlet.java
- StaffProfileServlet.java
- ViewProfileServlet.java

---

## 📦 PHÂN LOẠI MODEL (24 files)

### **entity/** - Domain Objects (24 files)
Tất cả các file hiện tại trong model/ sẽ chuyển vào entity/:
- User.java
- Patients.java
- Doctors.java
- Staff.java
- Manager.java
- Appointment.java
- DoctorSchedule.java
- StaffSchedule.java
- TimeSlot.java
- SlotReservation.java
- MedicalReport.java
- Prescription.java
- PrescriptionDetail.java
- Medicine.java
- Service.java
- BillService.java
- Bill.java
- PaymentInfo.java
- PaymentInstallment.java
- BlogPost.java
- ChatMessage.java
- Notification.java
- NotificationTemplate.java
- Specialty.java

### **dto/** - Data Transfer Objects (Cần tạo mới)
Sẽ tạo các DTO cho việc truyền dữ liệu giữa các layer:
- UserDTO.java
- AppointmentDTO.java
- MedicalRecordDTO.java
- PaymentDTO.java
- StatisticsDTO.java
- DashboardDTO.java

---

## 🗄️ PHÂN LOẠI DAO (21 files)

### **interfaces/** - DAO Interfaces (Cần tạo mới)
Tạo interface cho mỗi DAO:
- IUserDAO.java
- IPatientDAO.java
- IDoctorDAO.java
- IStaffDAO.java
- IManagerDAO.java
- IAppointmentDAO.java
- IDoctorScheduleDAO.java
- IStaffScheduleDAO.java
- ITimeSlotDAO.java
- IMedicineDAO.java
- IServiceDAO.java
- IServicePriceDAO.java
- IBillDAO.java
- IPaymentInstallmentDAO.java
- IBlogDAO.java
- INotificationDAO.java
- INotificationTemplateDAO.java
- ISpecialtyDAO.java
- IRelativesDAO.java
- IRelativesAppointmentDAO.java
- IFaceImageDAO.java

### **impl/** - DAO Implementations
Đổi tên các DAO hiện tại thành *DAOImpl.java:
- UserDAO.java → UserDAOImpl.java
- PatientDAO.java → PatientDAOImpl.java
- DoctorDAO.java → DoctorDAOImpl.java
- ... (tương tự cho tất cả)

---

## 🔧 FILTER (4 files)

Chuyển từ `Filter/` → `filter/`:
- AuthenticationFilter.java
- RoleFilter.java (đổi tên thành AuthorizationFilter.java)
- EncodingFilter.java (đổi tên thành CharacterEncodingFilter.java)
- SecurityFilter.java

---

## 🛠️ UTILS

Chuyển từ `utils/` → `util/`:
- DatabaseConnection.java
- PasswordUtil.java
- DateTimeUtil.java
- EmailUtil.java
- ValidationUtil.java
- FileUploadUtil.java
- Constants.java
- Env.java

---

## ⚠️ EXCEPTION (Cần tạo mới)

Tạo các custom exception:
- DAOException.java
- ServiceException.java
- ValidationException.java
- AuthenticationException.java

---

## 🔄 SERVICE LAYER (Cần tạo mới)

### **interfaces/**
- IAuthService.java
- IUserService.java
- IAppointmentService.java
- ITreatmentService.java
- IMedicineService.java
- IPaymentService.java
- IMessagingService.java
- IStatisticsService.java

### **impl/**
- AuthServiceImpl.java
- UserServiceImpl.java
- AppointmentServiceImpl.java
- TreatmentServiceImpl.java
- MedicineServiceImpl.java
- PaymentServiceImpl.java
- MessagingServiceImpl.java
- StatisticsServiceImpl.java

---

## 📝 CÁC BƯỚC THỰC HIỆN

### Bước 1: Tạo cấu trúc thư mục mới
```bash
mkdir -p src/java/com/dentalclinic/{controller/{auth,appointment,schedule,treatment,medicine,payment,messaging,admin,profile},model/{entity,dto},dao/{interfaces,impl},service/{interfaces,impl},filter,listener,util,exception}
```

### Bước 2: Di chuyển và refactor từng module
1. **Model** - Di chuyển entity, tạo DTO
2. **DAO** - Tạo interface, refactor implementation
3. **Service** - Tạo service layer mới
4. **Controller** - Phân loại và di chuyển
5. **Filter** - Di chuyển và đổi tên
6. **Util** - Di chuyển utilities
7. **Exception** - Tạo custom exceptions

### Bước 3: Update package declarations
- Tất cả file Java cần update package từ:
  - `package controller;` → `package com.dentalclinic.controller.auth;`
  - `package model;` → `package com.dentalclinic.model.entity;`
  - `package dao;` → `package com.dentalclinic.dao.impl;`
  - v.v.

### Bước 4: Update imports
- Tất cả import statements cần được cập nhật theo package mới

### Bước 5: Testing
- Test từng module sau khi refactor
- Đảm bảo không có lỗi compilation
- Kiểm tra runtime

---

## ⚡ LƯU Ý QUAN TRỌNG

1. **Backup code** trước khi refactor
2. **Tạo branch mới** cho refactoring
3. **Refactor từng bước** - không làm tất cả cùng lúc
4. **Test sau mỗi bước** - đảm bảo code vẫn chạy được
5. **Update web.xml** - cập nhật servlet mappings
6. **Update JSP files** - cập nhật các import trong JSP

---

## 🎯 ƯU TIÊN THỰC HIỆN

**Giai đoạn 1** (Quan trọng nhất):
1. Model (entity + dto)
2. DAO (interfaces + impl)
3. Filter

**Giai đoạn 2**:
4. Service layer
5. Util
6. Exception

**Giai đoạn 3**:
7. Controller (phân loại theo module)
8. Testing toàn bộ

---

## 📊 TIMELINE DỰ KIẾN

- **Giai đoạn 1**: 2-3 ngày
- **Giai đoạn 2**: 2-3 ngày  
- **Giai đoạn 3**: 3-4 ngày
- **Testing & Bug fixes**: 2-3 ngày

**Tổng cộng**: ~10-13 ngày làm việc

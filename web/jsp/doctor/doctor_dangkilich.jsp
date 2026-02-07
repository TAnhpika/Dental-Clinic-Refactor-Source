<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null || !"DOCTOR".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ include file="/includes/dashboard_head.jsp" %>
    <title>Đăng ký lịch làm việc - Doctor</title>
</head>
<body>
    <div class="dashboard-wrapper">
        <%@ include file="/jsp/doctor/doctor_menu.jsp" %>
        
        <main class="dashboard-main">
            <%@ include file="/jsp/doctor/doctor_header.jsp" %>
            
            <div class="dashboard-content">
                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="mb-1"><i class="fas fa-calendar-alt me-2"></i>Đăng ký lịch nghỉ</h4>
                        <p class="text-muted mb-0">Đăng ký ngày nghỉ và xem lịch làm việc</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/DoctorAppointmentsServlet" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                    </a>
                </div>
                
                <div class="row g-4">
                    <!-- Register Form -->
                    <div class="col-lg-6">
                        <div class="dashboard-card">
                            <h6 class="mb-4"><i class="fas fa-calendar-times me-2 text-warning"></i>Đăng ký ngày nghỉ</h6>
                            
                            <form action="${pageContext.request.contextPath}/DoctorRegisterScheduleServlet" method="POST">
                                <div class="mb-3">
                                    <label class="form-label">Mã bác sĩ <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="doctor_id" required 
                                           value="${param.doctor_id != null ? param.doctor_id : ''}">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Ngày nghỉ <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="work_date" required>
                                </div>
                                
                                <input type="hidden" name="request_type" value="leave">
                                
                                <button type="submit" class="btn-dashboard btn-dashboard-primary w-100">
                                    <i class="fas fa-paper-plane me-1"></i>Đăng ký nghỉ
                                </button>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Registered Leave -->
                    <div class="col-lg-6">
                        <div class="dashboard-card">
                            <h6 class="mb-4"><i class="fas fa-list me-2 text-info"></i>Lịch nghỉ đã đăng ký</h6>
                            
                            <table class="dashboard-table">
                                <thead>
                                    <tr>
                                        <th>Ngày nghỉ</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${schedules}" var="schedule">
                                        <c:if test="${schedule.slotId == null}">
                                            <tr>
                                                <td>${schedule.workDate}</td>
                                                <td>
                                                    <span class="badge bg-${schedule.status == 'Approved' ? 'success' : schedule.status == 'Pending' ? 'warning' : 'secondary'}">
                                                        ${schedule.status}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Approved Schedules -->
                <div class="dashboard-card mt-4">
                    <h6 class="mb-4"><i class="fas fa-check-circle me-2 text-success"></i>Lịch đã được xác nhận</h6>
                    
                    <table class="dashboard-table">
                        <thead>
                            <tr>
                                <th>Ngày</th>
                                <th>Ca làm việc</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${approvedSchedules}" var="schedule">
                                <tr>
                                    <td>${schedule.workDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${schedule.slotId == 1}">
                                                <span class="badge bg-info">Sáng (8h-12h)</span>
                                            </c:when>
                                            <c:when test="${schedule.slotId == 2}">
                                                <span class="badge bg-warning text-dark">Chiều (13h-17h)</span>
                                            </c:when>
                                            <c:when test="${schedule.slotId == 3}">
                                                <span class="badge bg-primary">Cả ngày (8h-17h)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Khác</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><span class="badge bg-success">Đã xác nhận</span></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty approvedSchedules}">
                                <tr>
                                    <td colspan="3" class="text-center text-muted py-4">
                                        <i class="fas fa-calendar-check" style="font-size: 32px;"></i>
                                        <p class="mt-2 mb-0">Chưa có lịch được xác nhận</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <%@ include file="/includes/dashboard_scripts.jsp" %>
</body>
</html>

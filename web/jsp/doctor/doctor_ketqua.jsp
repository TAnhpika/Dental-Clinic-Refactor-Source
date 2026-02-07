<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Appointment"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null || !"DOCTOR".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
    
    List<Appointment> completedAppointments = (List<Appointment>) request.getAttribute("completedAppointments");
    String error = (String) request.getAttribute("error");
    int totalCompleted = (completedAppointments != null) ? completedAppointments.size() : 0;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ include file="/includes/dashboard_head.jsp" %>
    <title>Kết quả khám - Doctor</title>
    <style>
        .result-card {
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
            border-left: 4px solid #10b981;
        }
        .result-card:hover {
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.15);
            transform: translateY(-2px);
        }
    </style>
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
                        <h4 class="mb-1"><i class="fas fa-clipboard-check me-2"></i>Kết quả khám bệnh</h4>
                        <p class="text-muted mb-0">Tổng số: <%= totalCompleted %> lượt khám hoàn thành</p>
                    </div>
                    <div class="input-group" style="max-width: 300px;">
                        <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm..." onkeyup="searchCompletedAppointments()">
                    </div>
                </div>
                
                <% if (error != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i><%= error %>
                </div>
                <% } %>
                
                <!-- Results Grid -->
                <div class="row g-4" id="appointmentCards">
                    <% if (completedAppointments != null && !completedAppointments.isEmpty()) {
                        for (Appointment appointment : completedAppointments) {
                            String timeSlot = "N/A";
                            String workDateString = "N/A";
                            
                            try {
                                if (appointment.getStartTime() != null && appointment.getEndTime() != null) {
                                    timeSlot = appointment.getStartTime() + " - " + appointment.getEndTime();
                                }
                            } catch (Exception e) { }
                            
                            try {
                                if (appointment.getWorkDate() != null) {
                                    workDateString = appointment.getFormattedDate();
                                }
                            } catch (Exception e) { }
                    %>
                    <div class="col-lg-6">
                        <div class="result-card">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <span class="badge bg-success"><%= timeSlot %> | <%= workDateString %></span>
                                <span class="badge bg-light text-success"><i class="fas fa-check-circle me-1"></i>Hoàn thành</span>
                            </div>
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/img/default-avatar.png" 
                                     class="rounded-circle me-3" style="width: 56px; height: 56px; object-fit: cover;"
                                     onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.png'">
                                <div class="flex-grow-1">
                                    <h6 class="mb-1"><%= appointment.getPatientName() != null ? appointment.getPatientName() : "Không có tên" %></h6>
                                    <small class="text-muted">Mã cuộc hẹn: #<%= appointment.getAppointmentId() %></small>
                                    <p class="mb-0 mt-1 small text-muted">
                                        <i class="fas fa-comment me-1"></i><%= appointment.getReason() != null ? appointment.getReason() : "Khám tổng quát" %>
                                    </p>
                                </div>
                                <a href="${pageContext.request.contextPath}/ViewReportServlet?appointmentId=<%= appointment.getAppointmentId() %>" 
                                   class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-file-medical me-1"></i>Xem kết quả
                                </a>
                            </div>
                        </div>
                    </div>
                    <% } } else { %>
                    <div class="col-12">
                        <div class="dashboard-card text-center py-5">
                            <i class="fas fa-clipboard-check text-muted" style="font-size: 64px;"></i>
                            <h5 class="mt-4 text-muted">Chưa có kết quả khám nào</h5>
                            <p class="text-muted">Danh sách kết quả khám sẽ hiển thị sau khi hoàn thành các cuộc hẹn.</p>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </main>
    </div>
    
    <%@ include file="/includes/dashboard_scripts.jsp" %>
    
    <script>
        function searchCompletedAppointments() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const cards = document.querySelectorAll('.result-card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.parentElement.style.display = text.includes(filter) ? '' : 'none';
            });
        }
    </script>
</body>
</html>

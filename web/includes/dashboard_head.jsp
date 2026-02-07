<%-- Common Head Component for All Dashboards Include this in all dashboard pages Note: Do NOT add page directive here
    to avoid conflict with parent JSP --%>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%-- Bootstrap 5 CSS --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <%-- Font Awesome 6 --%>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

            <%-- Dashboard Common (variables, base, cards, forms...) --%>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard-common.css">

            <%-- Dashboard layout (từ SCSS: wrapper, sidebar, main, header, responsive) --%>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard.css">

                <style>
                    /* Font chữ cho dashboard (không áp dụng lên icon) */
                    body, body * {
                        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                    }
                    /* Giữ font Font Awesome cho icon - tránh lỗi icon bị mất */
                    .fa, .fas, .far, .fab, .fa-solid, .fa-regular, .fa-brands,
                    [class^="fa-"], [class*=" fa-"] {
                        font-family: "Font Awesome 6 Free", "Font Awesome 6 Brands" !important;
                        font-weight: 900;
                    }
                    .fa-regular, .far { font-weight: 400; }
                </style>
<%-- 
    Font Loader Component - Inject contextPath vào CSS @font-face
    Sử dụng: <%@ include file="/includes/font-loader.jsp" %> trong <head>
--%>
<style>
@font-face {
    font-family: 'DejaVu Sans';
    src: url('${pageContext.request.contextPath}/fonts/DejaVuSans.ttf') format('truetype');
    font-weight: 400;
    font-style: normal;
    font-display: swap;
}

@font-face {
    font-family: 'DejaVu Sans';
    src: url('${pageContext.request.contextPath}/fonts/DejaVuSans.ttf') format('truetype');
    font-weight: 700;
    font-style: normal;
    font-display: swap;
}
</style>

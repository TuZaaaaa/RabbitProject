<%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/19
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
</div>
<!-- /#page-content-wrapper -->

</div>
<!-- /#wrapper -->

<script type="text/javascript" src="static/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src='https://apps.bdimg.com/libs/bootstrap/3.3.4/js/bootstrap.min.js'></script>
<script type="text/javascript">
    $(document).ready(function () {
        var trigger = $('.hamburger'),
            overlay = $('.overlay'),
            isClosed = false;

        trigger.click(function () {
            hamburger_cross();
        });

        function hamburger_cross() {

            if (isClosed === true) {
                overlay.hide();
                trigger.removeClass('is-open');
                trigger.addClass('is-closed');
                isClosed = false;
            } else {
                overlay.show();
                trigger.removeClass('is-closed');
                trigger.addClass('is-open');
                isClosed = true;
            }
        }

        $('[data-toggle="offcanvas"]').click(function () {
            $('#wrapper').toggleClass('toggled');
        });
    });
</script>
</body>
</html>

<%-- 
    Document   : queuingpane
    Created on : Apr 12, 2018, 11:58:57 AM
    Author     : SAMINUNU
--%>
<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
        <p>Together We Save Lives...!</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li> 
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/controlpanelmenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Control Panel</a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Controlpanel/universalpagemenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Universal Settings</a></li>
                    <li class="last active"><a href="#">Manage Queues</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<main id="main">
    <div>
        <section>
            <%@include file="view/viewqueuetypes.jsp" %>
        </section>
    </div>
</main>
<script>
    
    breadCrumb();

    $('#addnewqueuetype').click(function () {
        $('#addqueuetype').modal('show');
    });


    function updateQueues(value) {
        var tableData = $('#' + value).closest('tr')
                .find('td')
                .map(function () {
                    return $(this).text();
                }).get();
        var tablerowid = $('#' + value).closest('tr').attr('id');

        document.getElementById('queuetypeupdateid').value = tablerowid;
        document.getElementById('queuetypeupdatename').value = tableData[1];
        document.getElementById('queuetypeupdateweight').value = tableData[2];
        document.getElementById('queuetypeupdatedesc').value = tableData[3];

        $('#updatequeuetype').modal('show');
    }

    $('#editqueuetype').click(function () {
        var name = $('#queuetypeupdatename').val();
        var queuetypeid = $('#queuetypeupdateid').val();
        var weight = $('#queuetypeupdateweight').val();
        var description = $('#queuetypeupdatedesc').val();

        console.log("===========================nameedit" + name);
        console.log("===========================queuetypeidedit" + queuetypeid);
        console.log("===========================weightedit" + weight);
        console.log("===========================descriptionedit" + description);

        $.ajax({
            type: 'POST',
            data: {name: name, queuetypeid: queuetypeid, weight: weight, description: description},
            dataType: 'text',
            url: "queuingsystemsettings/updatequeuingtypes.htm",
            success: function (data, textStatus, jqXHR) {

                ajaxSubmitData('localsettigs/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');

                $('#updatequeuetype').modal('hide');

            }
        });

    });

    function sliderT(queueidz, valuex) {
        console.log(queueidz);
        console.log(valuex);
        if (valuex === 'true') {
            console.log('true--->>>> set to false----' + queueidz);
            var qstatus = 'false';//manageshelvingtab
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate this Queue Type',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {queuestatus: qstatus, queuetypeid: queueidz},
                                url: "queuingsystemsettings/activateDeactivatequeue.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx').val("false");
                        }
                    },
                    close: function () {
                        ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'false') {
            console.log('false--->>>> set to true-----' + queueidz);
            var qstatus = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this Queue Type',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {queuestatus: qstatus, queuetypeid: queueidz},
                                url: "queuingsystemsettings/activateDeactivatequeue.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx').val("true");
                        }
                    },
                    close: function () {
                        ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });

        }
    }
    function sliderF(queueidz, valuex) {
        console.log(queueidz);
        console.log(valuex);
        if (valuex === 'false') {
            console.log('false--->>>> set to true-----' + queueidz);
            var qstatus = 'true';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Activate this Queue Type',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-green',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {queuestatus: qstatus, queuetypeid: queueidz},
                                url: "queuingsystemsettings/activateDeactivatequeue.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx2').val("true");
                        }
                    },
                    close: function () {
                        ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        } else if (valuex === 'true') {
            console.log('true--->>>> set to false----' + queueidz);
            var qstatus = 'false';
            $.confirm({
                title: 'Message!',
                content: 'Your about to Deactivate this Queue Type',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'GET',
                                cache: false,
                                dataType: 'text',
                                data: {queuestatus: qstatus, queuetypeid: queueidz},
                                url: "queuingsystemsettings/activateDeactivatequeue.htm",
                                success: function (data) {}
                            });
                            $('.sliderxx2').val("false");
                        }
                    },
                    close: function () {
                        ajaxSubmitData('queuingsystemsettings/queuepane.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                    }
                }
            });
        }
    }

</script>
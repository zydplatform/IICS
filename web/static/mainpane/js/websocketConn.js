var stompClient = null;
var connectionSwitchOn = false;
var myself = null;
var activeUserList = [];
var frame = null;
var mActiveMembers = null;
var mUser = null;

var mtoken = $("meta[name='_csrf']").attr("content");
var mheader = $("meta[name='_csrf_header']").attr("content");
var mparameter = $("meta[name='_csrf_parameter']").attr("content");

var mheaders = {};

mheaders[mheader] = mtoken;

function chat_init() {
    connect();
    $("#chat-active-window").hide();
    $(".discussion").hide();
}

$("#chat-active").click(function (e) {
    e.preventDefault();
    if (connectionSwitchOn) {
        disconnect();
        setConnected(false);

    } else {
        connect();
        setConnected(true);

    }

});

function setConnected(connected) {
    connectionSwitchOn = connected;
    if (connected) {
        $("#chat-active .chat-active-status").css("color", "#428bca");
        $("#chat-active").attr("title", "You are Online");
        $("#chat-active label").html("Online");

    } else {
        $("#chat-active .chat-active-status").css("color", "#666666");
        $("#chat-active").attr("title", "You are Offline");
        $("#chat-active label").html("Offline");

    }

}

function connect() {

    var socket = new SockJS('/SchoolMate/stompchat/');
    stompClient = Stomp.over(socket);

    $("#no-online-users").show();
    $("#no-online-users").html("Connecting... ");
    
    stompClient.connect('','', function(mframe) {
        frame = mframe;
        myself = frame.headers['user-name'];
        
        setConnected(true);
        console.log('Connected: ' + frame);

        stompClient.subscribe('/user/queue/chats', function (message) {

            //alert($(".discussion #"	+ message.body.sender).html());
            if (mUser !== null) {
                $("#chat-onlineUsers-window .onliners #" + $.escapeSelector(mUser) + " .label").html(mUser + "<span class='badge'><span class='glyphicon glyphicon-envelope'></span></span>");
            } else {

                $("#chat-active-window").show();
                $(".discussion").show();

                var msg = JSON.parse(message.body);
                var nUser = msg.sender;

                //alert(nUser);
                $("#chat-active-current-user").html(nUser);

                if ($(".discussion #" + $.escapeSelector(nUser)).html() === undefined
                        || $(".discussion #" + $.escapeSelector(nUser)).html() === null
                        || $(".discussion #" + $.escapeSelector(nUser)).html() === "") {

                    $(".discussion").append("<ol id='" + nUser + "' style='list-style-type: none;'></ol>");

                    $(".discussion #" + $.escapeSelector(nUser)).append(""
                            + "<li class='other'>" + "<div class='avatar'>"
                            + "<span class='label label-default'>" + msg.sender
                            + "</span>" + "</div>" + "<div class='messages'>"
                            + "<p>" + msg.message + "</p>"
                            + "<span class='time'></span>" + "</div>" + "</li>");

                } else {

                    $(".discussion #" + $.escapeSelector(nUser)).append(""
                            + "<li class='other'>" + "<div class='avatar'>"
                            + "<span class='label label-default'>" + msg.sender
                            + "</span>" + "</div>" + "<div class='messages'>"
                            + "<p>" + msg.message + "</p>"
                            + "<span class='time'></span>" + "</div>" + "</li>");
                    $(".discussion #" + $.escapeSelector(nUser)).show();
                }

                $("#chat-active-window").hide();
                $(".discussion").hide();
                $(".discussion #" + $.escapeSelector(nUser)).hide();
                $("#chat-onlineUsers-window .onliners #" + $.escapeSelector(nUser) + " .label").html(nUser + "<span class='badge'><span class='glyphicon glyphicon-envelope'></span></span>");

            }


            showMessage(JSON.parse(message.body));
        });

        stompClient.subscribe('/topic/active', function (
                activeMembers) {

            showActive(activeMembers);
        });
    });

}

function disconnect() {
    if (stompClient !== null) {
        stompClient.disconnect();
    }
    $("#no-online-users").show();
    $("#no-online-users").html(":(  You are offline");
    $("#chat-onlineUsers-window .onliners").append("");
    $("#chat-onlineUsers-window .onliners").hide();
    setConnected(false);
    console.log("Disconnected");

}

function showActive(activeMembers) {
    renderActive(activeMembers.body);
}

function renderActive(activeMembers) {
    mActiveMembers = activeMembers;
    var members = $.parseJSON(activeMembers);
    
    if (members.length < 2) {

        $("#no-online-users").show();
        $("#no-online-users").html(":(  There are no users available online");

    } else {

        $.each(members, function (index, value) {

            if (value !== myself && activeUserList.indexOf(value) === -1) {

                activeUserList.push(value);
                $("#no-online-users").hide();

                $("#chat-onlineUsers-window .onliners").show();
                $("#chat-onlineUsers-window .onliners").append("<tr id='" + value + "'>"
                        + "<td width='10%' style='cursor:pointer;'>"
                        + "<img alt='ugly face' src='static/mainpane/images/staff_icon.png'  width='40px' height='40px'>"
                        + "</td>"
                        + "<td align='left' style='cursor:pointer;'>"
                        + "<span class='label label-default'>" + value + "</span>"
                        + "</td>" + "</tr>"
                        );
            }
        });

    }

    $("#chat-onlineUsers-window tr").unbind().click(function (e) {

        $("#chat-onlineUsers-window").hide();
        $("#chat-active-window").show();
        $(".discussion").show();

        mUser = $(this).attr("id");

        $("#chat-active-current-user").html(mUser);

        if ($(".discussion #" + $.escapeSelector(mUser)).html() === undefined
                || $(".discussion #" + $.escapeSelector(mUser)).html() === null
                || $(".discussion #" + $.escapeSelector(mUser)).html() === "") {

            $(".discussion").append("<ol id='" + mUser + "' style='list-style-type: none;'></ol>");
        } else {
            $(".discussion #" + $.escapeSelector(mUser)).show();
        }

        $("#close-chat").click(function (e) {

            $("#chat-onlineUsers-window").show();
            $("#chat-onlineUsers-window .onliners").show();
            
            if (members.length < 2) {

        $("#no-online-users").show();
        $("#no-online-users").html(":(  There are no users available online");

            } else {

                $.each(members, function (index, value) {

                    if (value !== myself && activeUserList.indexOf(value) === -1) {

                        activeUserList.push(value);
                        $("#no-online-users").hide();

                        $("#chat-onlineUsers-window .onliners").show();
                        $("#chat-onlineUsers-window .onliners").append("<tr id='" + value + "'>"
                                + "<td width='10%' style='cursor:pointer;'>"
                                + "<img alt='ugly face' src='static/mainpane/images/staff_icon.png'  width='40px' height='40px'>"
                                + "</td>"
                                + "<td align='left' style='cursor:pointer;'>"
                                + "<span class='label label-default'>" + value + "</span>"
                                + "</td>" + "</tr>"
                                );
                    }
                });

            }
            
            $("#chat-active-window").hide();
            $(".discussion").hide();
            $(".discussion #" + $.escapeSelector(mUser)).hide();
            $("#chat-onlineUsers-window .onliners #" + $.escapeSelector(mUser) + " .label").html(mUser);
        });

    });

}
// ########################################################################################

function sendMessageTo(user) {
    var message = $("#chat-message").val();

    stompClient.send("/app/chat", {}, JSON.stringify({
        'recipient': user,
        'message': message,
        'sender': myself
    }));
}

$("#chat-send").click(function () {
    sendMessageTo(mUser);

});

function showMessage(message) {

    if (message.sender === myself && message.recipient === mUser) {
        $(".discussion #" + $.escapeSelector(mUser)).append(
                "" + "<li class='other'>" + "<div class='avatar'>"
                + "<span class='label label-success'>" + "You"
                + "</span>" + "</div>" + "<div class='messages'>"
                + "<p>" + message.message + "</p>"
                + "<span class='time'></span>" + "</div>" + "</li>");
    }

    if (message.sender === mUser && message.recipient === myself) {
        $(".discussion #" + $.escapeSelector(mUser)).append(
                "" + "<li class='other'>" + "<div class='avatar'>"
                + "<span class='label label-default'>" + message.sender
                + "</span>" + "</div>" + "<div class='messages'>"
                + "<p>" + message.message + "</p>"
                + "<span class='time'></span>" + "</div>" + "</li>");
    }

    $("#chat-message").val("");
}

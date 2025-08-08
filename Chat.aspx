<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="SignalR_01.Chat" %>
<%@ Import Namespace="Microsoft.AspNet.SignalR" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>SignalR in ASPX</title>
    <script src="Scripts/jquery-3.7.0.min.js"></script>
    <script src="Scripts/jquery.signalR-2.4.3.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            var username = '<%= Session["username"] %>';
            var chat = $.connection.myHub;

            chat.client.broadcastMessage = function (name, message) {
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                $('#discussion').append('<li><strong>' + encodedName + '</strong>: ' + encodedMsg + '</li>');
            };

            $('#sendButton').click(function () {
                var msg = $('#messageInput').val();
                var toUser = $('#userInput').val();

                if (msg.trim() !== '' && toUser.trim() !== '') {
                    chat.server.sendPrivate(username, toUser, msg);
                    $('#messageInput').val('');
                }
               
            });

            $.connection.hub.qs = { "username": username }; // Send username to server
            $.connection.hub.start()
                .done(function () {
                    $('#sendButton').removeAttr('disabled');
                    console.log("Connected to SignalR hub.");
                })
                .fail(function (err) {
                    console.error("SignalR connection failed: " + err);
                });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="text" id="userInput" placeholder="To User Name" />
            <input type="text" id="messageInput" placeholder="Message" />
            <input type="button" id="sendButton" value="Send" disabled="disabled" />
            <ul id="discussion"></ul>
        </div>
    </form>
</body>
</html>

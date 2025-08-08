using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace SignalR_01
{
    public class MyHub : Hub
    {
        //public void Send(string name, string message)
        //{
        //    Clients.All.broadcastMessage(name, message);
        //}
        // Track usernames and their connection IDs
        private static ConcurrentDictionary<string, string> userConnections = new ConcurrentDictionary<string, string>();

        public override Task OnConnected()
        {
            string username = Context.QueryString["username"];
            if (!string.IsNullOrEmpty(username))
            {
                userConnections[username] = Context.ConnectionId;
            }
            return base.OnConnected();
        }

        public override Task OnDisconnected(bool stopCalled)
        {
            var user = userConnections.FirstOrDefault(x => x.Value == Context.ConnectionId);
            if (!string.IsNullOrEmpty(user.Key))
            {
                userConnections.TryRemove(user.Key, out _);
            }
            return base.OnDisconnected(stopCalled);
        }

        public void SendPrivate(string fromUser, string toUser, string message)
        {
            if (userConnections.TryGetValue(toUser, out string connectionId))
            {
                Clients.Client(connectionId).broadcastMessage(fromUser, message);
            }
        }

        public void broadcastMessage(string name, string message)
        {
            Clients.All.broadcastMessage(name, message);
        }

        //public void SendPsc(string fromUser, string toUser, fileblob message)
        //{
        //    if (userConnections.TryGetValue(toUser, out string connectionId))
        //    {
        //        Clients.Client(connectionId).broadcastMessage(fromUser, message);
        //    }
        //}
        //public class fileblob
        //{
        //    public string dataToSign { get; set; }
        //    public string fileName { get; set; }
        //}
    }
}
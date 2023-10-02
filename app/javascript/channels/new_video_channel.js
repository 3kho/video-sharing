import consumer from "./consumer"

$(function() {
  consumer.subscriptions.create(
    {
      channel: "NewVideoChannel"
    },
    {
      initialized() {
        console.log("init")
      },

      connected() {
        console.log("connected")
      },
      received: function(resp) {
        console.log(resp)
        const user = resp.user
        alert(`New video title: ${resp.title} shared by ${user.name}`)
      }
    }
  );
});

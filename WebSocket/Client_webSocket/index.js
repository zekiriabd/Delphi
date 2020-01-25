window.onload = function() {

 var connection = new WebSocket("ws://localhost:8080/socket/","chatHub");

 connection.onmessage = function(msg){
    const li = document.createElement("li");
    li.textContent = msg.data;
    document.getElementById("messagesList").appendChild(li);
 };

 document.getElementById("sendButton").addEventListener("click", event => {

    const user = document.getElementById("userInput").value;
    const message = document.getElementById("messageInput").value;

    connection.send(user + " :" + message);

    event.preventDefault();
 });

}
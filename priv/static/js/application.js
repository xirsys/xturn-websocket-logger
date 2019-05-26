(() => {
  class WebSocketLoggerHandler {
    setupSocket() {
      this.socket = new WebSocket("ws://localhost:4000/ws/chat")

      this.socket.addEventListener("message", (event) => {
        const obj = JSON.parse(event.data), data = JSON.stringify(obj, null, 2);
        const pTag = document.createElement("pre"), cTag = document.createElement("code");
        pTag.className = cTag.className = "language-javascript";
        cTag.textContent = data;

        const dTag = document.createElement("div"), link = document.createElement("a");
        if (obj.type == "stun") {
          link.textContent = `${obj.sender} ${obj.type}: ${obj.message.method} ${obj.message.class} [${obj.client_ip}:${obj.client_port}]`;
        } else {
          link.textContent = `${obj.sender} ${obj.type} [${obj.client_ip}:${obj.client_port}]`
        }

        link.addEventListener("click", function(ev) {
          const code = ev.target.nextSibling;
          if (code.style.display === "none") {
            code.style.display = "block";
          } else {
            code.style.display = "none";
          }
        });
        pTag.append(link);
        pTag.append(cTag);
        document.getElementById("main").append(pTag);

        Prism.highlightElement(cTag);
      })

      this.socket.addEventListener("close", () => {
        this.setupSocket();
      })
    }
  }

  const websocketClass = new WebSocketLoggerHandler()
  websocketClass.setupSocket();
})()
from http.server import BaseHTTPRequestHandler, HTTPServer
import os

HOST_NAME = "0.0.0.0"
PORT_NUMBER = 8000

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        container_hostname = os.environ.get("CONTAINER_HOSTNAME", "Unknown")

        try:
            with open("templates/index.html", "r", encoding="utf-8") as f:
                html_content = f.read()
        except FileNotFoundError:
            html_content = f"<html><body><h1>Error: 'index.html' not found.</h1></body></html>"

        response_content = html_content.replace("{{ container_hostname }}", container_hostname)
        self.wfile.write(bytes(response_content, "utf-8"))

if __name__ == "__main__":
    webServer = HTTPServer((HOST_NAME, PORT_NUMBER), MyHandler)
    print(f"Server started at http://{HOST_NAME}:{PORT_NUMBER}")
    webServer.serve_forever()





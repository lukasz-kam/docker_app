import http.client
import sys

HOST = 'localhost'
PORT = 8000

try:
    conn = http.client.HTTPConnection(HOST, PORT, timeout=1)
    conn.request("GET", "/")
    response = conn.getresponse()

    if response.status == 200:
        print("Healthcheck successful!")
        sys.exit(0)
    else:
        print("Healthcheck failed.")
        sys.exit(1)

except Exception as e:
    sys.exit(1)
finally:
    conn.close()
import urllib.request
import sys

def get_instance_hostname():
    token_url = 'http://169.254.169.254/latest/api/token'
    metadata_url = 'http://169.254.169.254/latest/meta-data/hostname'

    try:
        request_token = urllib.request.Request(
            token_url,
            headers={'X-aws-ec2-metadata-token-ttl-seconds': '21600'},
            method='PUT'
        )
        with urllib.request.urlopen(request_token, timeout=1) as response:
            token = response.read().decode('utf-8')

        request_hostname = urllib.request.Request(
            metadata_url,
            headers={'X-aws-ec2-metadata-token': token}
        )
        with urllib.request.urlopen(request_hostname, timeout=1) as response:
            return response.read().decode('utf-8')

    except Exception:
        return '127.0.0.1'

if __name__ == '__main__':
    hostname = get_instance_hostname()
    print(hostname)
    sys.exit(0)
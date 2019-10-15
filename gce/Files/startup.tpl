#!/bin/sh
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
cat <<EOF > /var/www/html/index.html
<html><body><h1>Hello World</h1>
<p>This page was created from a simple startup script!</p>
</body></html>
EOF
#Run all below in generate-certs job, parametize the wildcard certs, email, and dont do pip uninstall/re-install, but need 16.0.0, try pip install --upgrade

#Update gitlab-ci to have stage to curl the ip address (curl ifconfig.me/ip) and then add a temp sg ingress rule to add the ip address of the gitlab runner
#Update gitlab-ci to have stage after renewal-cert stage to remove the temp sg ingress rule

sudo yum install certbot -q -y
sudo pip install certbot-route53
mkdir letsencrypt && cd letsencrypt && mkdir log && mkdir work && mkdir config && cd ..
pip uninstall pyOpenSSL
pip install pyOpenSSL==16.0.0 --user
sudo yum install java-1.8.0-openjdk-devel -y -q
certbot certonly --dns-route53 -d *.statsmaniavault.com -d statsmaniavault.com --logs-dir $PWD/letsencrypt/log/  --config-dir $PWD/letsencrypt/config --work-dir $PWD/letsencrypt/work -m karlazzam93@gmail.com --agree-tos --no-eff-email
keytool -importcert -keystore keystore.jks -file fullchain.pem -noprompt -storepass changeit -dname "CN=*.statsmaniavault.com" -alias *.statsmaniavault.com -ext SAN=dns:*.statsmaniavault.com

server {
        listen 80;
        server_name es.tikachips.com fr.tikachips.com pt.tikachips.com;
        access_log off;
        location / {
                proxy_pass http://127.0.0.1:8518/tika/;
        }
        proxy_set_header Host $host;
        proxy_set_header X-Real-Ip $remote_addr;
        proxy_set_header X-Forwared-For $proxy_add_x_forwarded_for;
}


server {
        listen 80;
        server_name en.tikachips.com;
        access_log off;
        location / {
                proxy_pass http://127.0.0.1:8518/tika2/;
        }
        proxy_set_header Host $host;
        proxy_set_header X-Real-Ip $remote_addr;
        proxy_set_header X-Forwared-For $proxy_add_x_forwarded_for;
}



server {
        listen 80;
        server_name www.tikachips.com tikachips.com;
        return http://es.tikachips.com;
}


server {
        listen 80;
        server_name tikachips.co.nz www.tikachips.co.nz tikachips.nz www.tikachips.nz;
        return 301 $scheme://en.tikachips.com$request_uri;
}


server {
        listen 80;
        server_name tika.cl tikachips.cl;
        return 301 $scheme://www.tika.cl$request_uri;
}

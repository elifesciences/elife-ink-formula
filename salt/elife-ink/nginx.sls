ink-nginx-configuration:
    file.managed:
        - name: /etc/nginx/sites-enabled/ink.conf
        - source: salt://elife-ink/config/etc-nginx-sites-enabled-ink.conf
        - template: jinja
        - require:
            - nginx-config
            - ink-environment
        - listen_in:
            - service: nginx-server-service

slanger-nginx-configuration:
    file.managed:
        - name: /etc/nginx/sites-enabled/slanger.conf
        - source: salt://elife-ink/config/etc-nginx-sites-enabled-slanger.conf
        - template: jinja
        - require:
            - nginx-config
            - ink-environment
        - listen_in:
            - service: nginx-server-service



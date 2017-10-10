ink-repository:
    git.latest:
        - name: https://gitlab.coko.foundation/yld/ink-api
        - rev: demo
        #- identity: {{ pillar.elife.projects_builder.key or '' }}
        - force_fetch: True
        - force_checkout: True
        - force_reset: True
        - target: /srv/ink

    file.directory:
        - name: /srv/ink
        - user: {{ pillar.elife.deploy_user.username }}
        - group: {{ pillar.elife.deploy_user.username }}
        # subfolders such as postgres/ or tmp/ require special permissions
        # don't mess with them
        #- recurse:
        #    - user
        #    - group
        - require:
            - git: ink-repository

ink-environment:
    file.managed:
        - name: /srv/ink/.env
        - source: salt://elife-ink/config/srv-ink-.env
        - template: jinja
        - user: {{ pillar.elife.deploy_user.username }}
        - group: {{ pillar.elife.deploy_user.username }}
        - require:
            - ink-repository

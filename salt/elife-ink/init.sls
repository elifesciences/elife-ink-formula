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
        - recurse:
            - user
            - group
        - require:
            - git: ink-repository


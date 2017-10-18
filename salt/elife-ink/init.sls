elife-ink-repository:
    builder.git_latest:
        - name: git@github.com:elifesciences/elife-ink.git
        - identity: {{ pillar.elife.projects_builder.key or '' }}
        - rev: {{ salt['elife.rev']() }}
        - branch: {{ salt['elife.branch']() }}
        - target: /srv/elife-ink
        - force_fetch: True
        - force_checkout: True
        - force_reset: True

    file.directory:
        - name: /srv/elife-ink
        - user: {{ pillar.elife.deploy_user.username }}
        - group: {{ pillar.elife.deploy_user.username }}
        - recurse:
            - user
            - group
        - require:
            - builder: elife-ink-repository

ink-repository:
    git.latest:
        - name: https://gitlab.coko.foundation/yld/ink-api
        - rev: demo
        #- identity: {{ pillar.elife.projects_builder.key or '' }}
        - force_fetch: True
        - force_checkout: True
        - force_reset: True
        - target: /srv/ink
        - require:
            - elife-ink-repository

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

# the smallest orchestrator in the world
ink-docker-containers:
    cmd.run:
        - name: /usr/local/bin/docker-compose up --force-recreate -d
        - cwd: /srv/ink
        - require:
            - ink-environment


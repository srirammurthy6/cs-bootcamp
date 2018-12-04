namespace: Integrations.demo.aos.tools
flow:
  name: delete_file
  inputs:
    - host: 10.0.46.54
    - username: root
    - password: admin@123
    - filename: deploy_war.sh
  workflow:
    - delete_file:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && rm -rf '+filename}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      delete_file:
        x: 167
        y: 183
        navigate:
          7199d556-6200-4c43-2bb0-17111f8c23dd:
            targetId: 1f40c6e7-64db-a6c5-e037-8860cf6e18b4
            port: SUCCESS
    results:
      SUCCESS:
        1f40c6e7-64db-a6c5-e037-8860cf6e18b4:
          x: 336
          y: 183

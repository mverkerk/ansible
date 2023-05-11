This role will compile, install and configure Python and install specified pip packages

- Link python source file in 'files' folder
- Alter vars/main.yml or set vars in playbook

In order to create a list of installed modules:

pip3 list | cut -d" " -f1 | tail -n +3 > pip-packages.lst [ENTER]

This role will compile, install and configure R and install packages.

Packages can be provided with the following methods:
- in a R generated file - the 'r_rda_packages' variable specifies the rda file and r_rda_packages_var 
  specifies the variable name ('pkgs' by default)
- by package names specified in 'r_packages' list/array variable
- by GitHub repositories, specified in 'r_github_packages' lists/array variable. Each repository looks
  like: 'github_owner/repository_name'
- by GitLab repositories, specified in 'r_gitlab_packages' list/array variable, as 
  'gitlab_owner/repository_name'

* If there are OS dependencies for these packages, they should be placed in the 'r_os_packages' list/array.*  
  
General Instructions
--------------------
A link or copy of the R archive should be placed in the R/files folder and the version/archive information
should be placed in the R/defaults/main.yml file. There are other (documented) default variables there.

The variables can also be overwritten in a triggering playbook.

playbook example
----------------

R_example.yml:
```
---
- hosts: hostname
  remote_user: root
  vars:
    r_os_packages:
      - "proj-devel"
      - "proj-epsg"
      - "proj-nad"
      - "geos-devel"
      - "gmp"
      - "gmp-devel"
    r_packages:
      - "coloc"
      - "snpStats"
    r_rda_packages: r_packages_server_09-03-2021.rda
    r_github_packages:
      - "perishky/ewaff"
      - "perishky/meffil"
    r_gitlab_packages:
      - "luccoffeng/virsim"         
    r_source_packages:
      - "https://github.com/downloads/PMBio/peer/R_peer_source_1.3.tgz"
    r_install_dest: /opt/software/versions
    r_linkdir: /opt/software/R
    r_dolink: false
  roles:
    - R
```
This R role prefixes the R installation in the r_install_dest/R-version folder and creates
profile.d scripts / man.db entries that point to the r_linkdir. This way several R installations
can be installed next to eachother. To make a (newest) version of R the default, either specify
'r_dolink: true' or manually link the r_linkdir (e.g. /opt/software/R) to the residing directory 
e.g. /opt/software/versions/R-version: ln -sf /opt/software/versions/R-x-x /opt/software/R  

Installing on Cluster
---------------------
If you're running a cluster with shared (NFS) network folder the following variable can be set to
one of the hostnames in the cluster, to be sure the actual installation only occurs only once. There
profile.d scripts, mandb links are put on all servers in the cluster.

r_one_installation: server1

Package Installation
--------------------
Because of the high frequent and sometimes error phrone package updates, the package installation
iterations do not stop with errors. Check the playbook log and the /tmp/ folder for specific
installation logs:

- r_instpack.results
- r_instgithub.results
- r_instgitlab.results
- r_instsource.results

Instructions to create a rda file with packages from an existing R installation
-------------------------------------------------------------------------------
pkgs <- rownames(installed.packages())
save(pkgs, file="r_packages.rda")

# localops-playbooks

[Ansible playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) to manage installation and configuration of local environments using [localops](https://github.com/gasrios/localops).

You may be interested in this project if:

1. You constantly need to set up computers for your own use, with different configurations each time (my personal motivation);
1. You manage several distinct computer configurations, and are just plain tired of doing so manually, having to remember every little detail and difference each one has (come to think of it, my personal motivation, too).

The existing playbooks suit my particular needs and may, or may not, interest you. Some perform very basic tasks, like installing Google Chrome or LibreOffice; others will go as far as installing Jenkins and Nginx, configuring the latter to proxy the former using HTTPS. One usually does not need to run such services locally, I do so to test and develop CI/CD pipelines and the like, hopefully someone else may benefit from them.

## Currently supported distros:

* [Ubuntu 18.04 (Bionic Beaver)](http://releases.ubuntu.com/18.04/), 64 bit only
* [Ubuntu 20.04 (Focal Fossa)](http://releases.ubuntu.com/20.04/)

## Currently Available Playbooks

* [AWS Amplify](https://aws.amazon.com/amplify/)
* [Ansible Lint](https://ansible-lint.readthedocs.io/en/latest/)
* [AWS Command Line Interface](https://aws.amazon.com/cli/)
* Local [certificate authority](https://en.wikipedia.org/wiki/Certificate_authority)
* [Chef Workstation](https://docs.chef.io/workstation/)
* [Codacy Analysis CLI](https://github.com/codacy/codacy-analysis-cli)
* [Diagrams](https://diagrams.mingrammer.com/)
* [direnv](https://direnv.net/)
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker local registry](https://docs.docker.com/registry/insecure/) as [systemctl](https://www.freedesktop.org/software/systemd/man/systemctl.html) service
* [Dropbox](https://www.dropbox.com/)
* [GIMP](https://www.gimp.org/) with [UFRaw](https://sourceforge.net/projects/ufraw/)
* [GitHub CLI](https://cli.github.com/)
* [Google Chrome](https://www.google.com/chrome)
* [Google Cloud SDK](https://cloud.google.com/sdk)
* [Helix](https://github.com/helix-editor/helix)
* [Helm](https://helm.sh/)
* [http-server](https://www.npmjs.com/package/http-server)
* [IntelliJ](https://www.jetbrains.com/idea/)
* [Java](https://openjdk.java.net/)
* [Jenkins](https://jenkins.io/)
* [Jupyter](https://jupyter.org/)
* [Zero to JupyterHub with Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/)  **(see note 1 below!)**
* [kubectl CLI](https://kubernetes.io/docs/reference/kubectl/)
* [Kubeval](https://www.kubeval.com/)
* [LibreOffice](https://www.libreoffice.org/)
* [LocalStack](https://localstack.cloud/)
* [MicroK8s](https://microk8s.io/) **(see note 2 below!)** and [Kubeval](https://github.com/instrumenta/kubeval)
* [NFS Server](https://tools.ietf.org/html/rfc5661)
* [Nginx](https://nginx.org/en/)
* [Node.js](https://nodejs.org/en/)
* [NordVPN](https://nordvpn.com/)
* [Packer](https://packer.io/) by Hashicorp
* [PHP](https://www.php.net/) with [Symfony](https://symfony.com/) and [The API Platform Framework](https://api-platform.com/) support
* [PhpStorm](https://www.jetbrains.com/phpstorm/)
* [ReactJs](https://reactjs.org/)
* [Rust](https://www.rust-lang.org/)
* [Salesforce](https://www.salesforce.com/)
* [Signal](https://signal.org/download/)
* [Slack](https://slack.com/)
* [Spotify for Linux](https://www.spotify.com/br/download/linux/)
* [Spring Boot CLI](https://javasterling.com/spring-boot/spring-boot-cli)
* [Terraform](https://www.terraform.io/) by Hashicorp
* [Visual Studio Code](https://code.visualstudio.com/)
* [wabt](https://github.com/WebAssembly/wabt)
* [Zoom](https://zoom.us/)

Some of the above do nothing beyond installing packages from official Ubuntu repositories, which may seem to be overkill. Still, having a playbook might be useful, as it can be imported by other playbook to orchestrate installation of complex environments, and/or add additional configuration to them.

1. JupyterHub playbook will install it on the cluster being referred to by your environment variables KUBECONFIG and CONTEXT, which may or may not be local to your computer. If you install MicroK8s using localops, JupyterHub will be installed in it by default.
1. MicroK8s [can't reach the internet](https://MicroK8s.io/docs/troubleshooting#heading--common-issues). If you need your MicroK8s cluster to access the Internet, localops provides script [MicroK8s/ufw-allow-microk8s.sh](https://github.com/gasrios/localops/blob/master/MicroK8s/ufw-allow-microk8s.sh) to help you configure your firewall. However, localops **DOES NOT** execute it, as this might be a security issue. Please review and customize it as you see fit, given your use cases. Even after correctly configuring your firewall, you may experience connectivity issues, after rebooting. Running "MicroK8s stop" before shutting down should prevent them from happening and, even if they do, "MicroK8s stop" and "MicroK8s start" should fix them.

## Testing

* [test/setup.sh](https://github.com/gasrios/localops/blob/master/test/setup.sh) creates "test" Docker images. As a side effect, it also tests the installation process.
* [test/test-playbook.sh](https://github.com/gasrios/localops/blob/master/test/test-playbook.sh) tests a given playbook against all supported distros.
* [test/test-all-playbooks.sh](https://github.com/gasrios/localops/blob/master/test/test-all-playbooks.sh) tests all playbooks against all supported distros.

Before testing the playbook, static code check is performed using [Ansible Lint](https://ansible-lint.readthedocs.io/en/latest/).

Each playbook is executed twice for each supported platform; ideally, the second execution should yield no changes, providing evidence of idempotency.

Here is what executing a test looks like:
```
~/projects/localops/test$ ./test-playbook.sh ../user/ansible-lint.yaml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: user/ansible-lint.yaml
Static code check found no errors
Testing ubuntu-18.04

PLAY [all] *******************************************************************************************************

TASK [Install Ansible Lint] **************************************************************************************
changed: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


PLAY [all] *******************************************************************************************************

TASK [Install Ansible Lint] **************************************************************************************
ok: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

Testing ubuntu-20.04

PLAY [all] *******************************************************************************************************

TASK [Install Ansible Lint] **************************************************************************************
changed: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


PLAY [all] *******************************************************************************************************

TASK [Install Ansible Lint] **************************************************************************************
ok: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
_____
## Copyright & License

The following copyright notice applies to all files in localops, unless otherwise indicated in the file.

### © 2021 Guilherme Rios All Rights Reserved

All files in localops are licensed under the [MIT License](https://github.com/gasrios/localops/blob/master/LICENSE), unless otherwise indicated in the file.

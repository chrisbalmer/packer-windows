# Windows Packer Templates

These are some templates to build Windows images for VMware ESXi/Workstation/Fusion. The `-base` templates build a simple image and then the other templates add other features onto the base image. All keys used are public KMS keys that will activate if you join a domain with a KMS server configured. Otherwise you will need to supply valid MAK keys in the `autounattend.xml` files for Windows to activate.

## Tasks

- [X] Fix VMware tools, it is rebooting automatically, need to avoid the reboot: This is due to case sensitivity for the arguments.
- [X] Find out why PowerShell scripts are not finishing before the next is run: Needed to add `-NoNewWindow` to the `Start-Process` cmdlet.

## WinRM

This enables WinRM with SSL using the `ansible.ps1` script from the official [Ansible](https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1) repo. There is a warning about it not being for production but as far as I can tell the only issue would be using this packer build as a template and not re-running the script with `-ForceNewSSLCert $True` or deploying your own SSL certificate.

The original script defaults `-DisableBasicAuth` to `$False` but I have changed it to `$True` as we're using NTLM and you can use NTLM with Ansible as well instead of basic.

If you deploy this into a production environment, I recommend joining it to your domain during the deployment and then using Kerberos with Ansible instead of NTLM. Basically anything using WinRM should be using Kerberos and a proper SSL certificate from your own PKI. Kerberos will encrypt the communication but it doesn't hurt to continue using SSL on top of that.

This is a good primer for WinRM and encryption/auth protocols: https://foxdeploy.com/2017/02/08/is-winrm-secure-or-do-i-need-https/

## Autounattend

### Windows 2019 Options

- Windows Server 2019 SERVERDATACENTER
- Windows Server 2019 SERVERDATACENTERCORE
- Windows Server 2019 SERVERSTANDARD
- Windows Server 2019 SERVERSTANDARDCORE

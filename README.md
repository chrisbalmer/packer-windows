# Windows Packer Templates

These are some templates to build Windows images for VMware ESXi/Workstation/Fusion. The `-base` templates build a simple image and then the other templates add other features onto the base image.

## Build Process

To build a full image, update the vars file for the OS you want to build with valid data (i.e. replace the location of the ISO). Then run the build script. This will build the base image which includes all updates available for the OS, then the cloudbase-init prep image and finally build out the OVA for use with VMware.

When building, specify the name of the var file you're using. No `.json` and no path to the vars folder.

Example:

```bash
./build.sh 2019-std-1809-core
```

## WinRM

This enables WinRM with SSL using the `ansible.ps1` script from the official [Ansible](https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1) repo. There is a warning about it not being for production but as far as I can tell the only issue would be using this packer build as a template and not re-running the script with `-ForceNewSSLCert $True` or deploying your own SSL certificate.

The original script defaults `-DisableBasicAuth` to `$False` but I have changed it to `$True` as we're using NTLM and you can use NTLM with Ansible as well instead of basic.

If you deploy this into a production environment, I recommend joining it to your domain during the deployment and then using Kerberos with Ansible instead of NTLM. Basically anything using WinRM should be using Kerberos and a proper SSL certificate from your own PKI. Kerberos will encrypt the communication but it doesn't hurt to continue using SSL on top of that.

This is a good primer for WinRM and encryption/auth protocols: https://foxdeploy.com/2017/02/08/is-winrm-secure-or-do-i-need-https/

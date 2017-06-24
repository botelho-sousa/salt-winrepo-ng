# both 32-bit (x86) AND a 64-bit (AMD64) installer available
{% set PROGRAM_FILES = "%ProgramFiles%" %}
openvpn: 
  {% for version in ['2.3.12', '2.3.11', '2.3.10', '2.3.8', '2.3.6'] %}
  {% if version in ['2.3.10'] %}
    {% set win_ver = "I603" %}
  {% else %}
    {% set win_ver = "I601" %}
  {% endif %}
  '{{ version }}':
    full_name: 'OpenVPN {{ version }}-{{ win_ver }} ' # Note: the OpenVPN installer adds a space at the end of its install string
    {% if grains['cpuarch'] == 'AMD64' %}
    installer: 'https://swupdate.openvpn.org/community/releases/openvpn-install-{{ version }}-{{ win_ver }}-x86_64.exe'
    {% elif grains['cpuarch'] == 'x86' %}
    installer: 'https://swupdate.openvpn.org/community/releases/openvpn-install-{{ version }}-{{ win_ver }}-i686.exe'
    {% endif %}
    install_flags: '/S /SELECT_OPENSSL_UTILITIES=1 /SELECT_EASYRSA=1 /SELECTSHORTCUTS=1 /SELECTOPENVPN=1 /SELECTASSOCIATIONS=1 /SELECTOPENVPNGUI=1 /SELECTPATH=1'
    uninstaller: '%ProgramFiles%\OpenVPN\Uninstall.exe'
    uninstall_flags: '/S'
    msiexec: False
    locale: en_US
    reboot: False
  {% endfor %}
#
# https://chocolatey.org/packages/openvpn
# Install with the following options:
# /SELECTSHORTCUTS=1 - create the start menu shortcuts
# /SELECTOPENVPN=1 - OpenVPN itself
# /SELECTSERVICE=1 - install the OpenVPN service
# /SELECTTAP=1 - install the TAP device driver
# /SELECTOPENVPNGUI=1 - install the default OpenVPN GUI
# /SELECTASSOCIATIONS=1 - associate with .ovpn files
# /SELECTOPENSSLUTILITIES=1 - install the utilities for generating public-private key pairs
# /SELECTEASYRSA=1 - install the RSA X509 certificate management scripts
# /SELECTPATH=1 - add openvpn.exe in PATH
# /SELECTOPENSSLDLLS=1 - dependencies - OpenSSL DLL's
# /SELECTLZODLLS=1 - dependencies - LZO compressor DLL's
# /SELECT_PKCS11DLLS=1 - dependencies - PCKS#11 DLL's

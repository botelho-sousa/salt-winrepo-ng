# both 32-bit (x86) AND a 64-bit (AMD64) installer available
{% set versions = {
	'6.4':[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17],
	'6.2':[0,1,2,3,4,5,6,7,8,9],
	'6.0':[9,10,11,12,13,14,15,16,17,18,19,20,21],
	'5.4':[0,1,2,3,4,5,6,7,8,9,10,11,12],
	'5.2':[0,1,2,3], '5.0':[1,2,3,4,5,6,7],
	'4.4':[1,2,3,4,5,10],
	'4.2':[3,4,5,6,7,8],
	'4.0':[9,10,11,12,13,14,15,16,17,22,23,24,25,26,27],
	'3.0':[26,27,28,29]},
	%}
{% set source_path = 'https://cdn.zabbix.com/zabbix/binaries/stable/' %}

zabbix-agent2:
{% for major, subversions in versions.items() %}
{% for minor in subversions %}
  '{{major}}.{{minor}}.2400':
    {% if grains['cpuarch'] == 'AMD64' %}
    full_name: 'Zabbix Agent 2 (64-bit)'
    installer: '{{source_path}}{{major}}/{{major}}.{{minor}}/zabbix_agent2-{{major}}.{{minor}}-windows-amd64-openssl.msi'
    uninstaller: '{{source_path}}{{major}}/{{major}}.{{minor}}/zabbix_agent2-{{major}}.{{minor}}-windows-amd64-openssl.msi'
    {% else %}
    full_name: 'Zabbix Agent 2 (32-bit)'
    installer: '{{source_path}}{{major}}/{{major}}.{{minor}}/zabbix_agent2-{{major}}.{{minor}}-windows-i386-openssl.msi'
    uninstaller:  '{{source_path}}{{major}}/{{major}}.{{minor}}/zabbix_agent2-{{major}}.{{minor}}-windows-i386-openssl.msi'
    {% endif %}
    install_flags: '/qn /norestart'
    uninstall_flags: '/qn /norestart'
    msiexec: True
    locale: en_US
    reboot: False
{% endfor %}
{% endfor %}

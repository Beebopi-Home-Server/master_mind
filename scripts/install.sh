#!/bin/bash

if [ -z "/opt/master_mind" ]; then
    sudo git clone https://github.com/Beebopi-Home-Server/master_mind.git /opt/master_mind
fi
cd /opt/master_mind

# Instala o serviço do systemd
sudo cp /opt/master_mind/scripts/master_mind.service /lib/systemd/system/
sudo systemctl daemon-reload

# [Debian] Instala as dependências python 
sudo apt install python3-gunicorn python3-fastpi

# Dá as devidas permissões aos scripts de execução
chmod +x ./scripts/run.sh

# Considerações finais
echo "Inicie/Ative o serviço master_mind.service"


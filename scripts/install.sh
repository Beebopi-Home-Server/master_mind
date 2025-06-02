#!/bin/bash

if [ -z "/opt/master_mind" ]; then
    sudo git clone https://github.com/Beebopi-Home-Server/master_mind.git /opt/master_mind
fi
cd /opt/master_mind

# Instala o serviço do systemd
sudo cp /opt/master_mind/scripts/master_mind.service /lib/systemd/system/
sudo systemctl daemon-reload

# Instala as dependências python 
sudo python -m venv .venv
.venv/bin/pip install -r requirements.txt

# Dá as devidas permissões aos scripts de execução
sudo chmod +x ./scripts/run.sh

# Considerações finais
echo "Inicie/Ative o serviço master_mind.service"


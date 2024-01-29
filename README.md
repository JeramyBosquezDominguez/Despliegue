# Despliegue

# Crear el usuario tomcat
sudo useradd -U -s /bin/false tomcat

# Actualizar el sistema e instalar Java
sudo apt-get update
sudo apt-get -y install openjdk-17-jdk

# Descargar e instalar Apache Tomcat
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.18/bin/apache-tomcat-10.1.18.tar.gz
tar xzvf apache-tomcat-10.1.18.tar.gz -C /opt/tomcat --strip-components=1

# Cambiar los propietarios y permisos de Tomcat
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin

# Configurar usuarios en tomcat-users.xml
sudo sh -c 'sed -i "/<\/tomcat-users>/i \  <role rolename=\"manager-gui\" />" /opt/tomcat/conf/tomcat-users.xml && sed -i "/<\/tomcat-users>/i \  <user username=\"manager\" password=\"manager_password\" roles=\"manager-gui\" />" /opt/tomcat/conf/tomcat-users.xml && sed -i "/<\/tomcat-users>/i \  <role rolename=\"admin-gui\" />" /opt/tomcat/conf/tomcat-users.xml && sed -i "/<\/tomcat-users>/i \  <user username=\"admin\" password=\"admin_password\" roles=\"manager-gui,admin-gui\" />" /opt/tomcat/conf/tomcat-users.xml'

# Reiniciar Tomcat
sudo systemctl restart tomcat

# Configurar context.xml para el manager
sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml
sudo sed -i '/<Valve / {s/^/<!-- /; n; s/$/ -->/}' /opt/tomcat/webapps/manager/META-INF/context.xml

# Configurar context.xml para el host-manager
sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml
sudo sed -i '/<Valve / {s/^/<!-- /; n; s/$/ -->/}' /opt/tomcat/webapps/host-manager/META-INF/context.xml

# Recargar el daemon de systemctl
sudo systemctl daemon-reload

# Iniciar Tomcat
sudo systemctl start tomcat

# Habilitar Tomcat para que se inicie en el arranque
sudo systemctl enable tomcat

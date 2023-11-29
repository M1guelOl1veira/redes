FROM ubuntu:latest

#Criação do diretório para o serviço SSH funcionar normalmente
RUN mkdir -p /var/run/sshd

RUN apt update &&\ 
    apt install -y openjdk-8-jdk && \
    apt install -y openssh-server

#Adicionando um usuário e definindo senha
RUN useradd -rm -d /home/user -s /bin/bash user && \
    echo user:password1234 | chpasswd

#Criando o diretório para armazenar as chaves e dando permissão de escrita, leitura e execução para o usuário
RUN mkdir /home/user/.ssh && \
    chmod 700 /home/user/.ssh

#Copiando a chave pública
COPY id_rsa.pub /home/user/.ssh/authorized_keys

#Mudar o owner da .ssh para user e adiciona permissão de leitura e escrita para o dono da chave
RUN chown user:user -R /home/user/.ssh && \
    chmod 600 /home/user/.ssh/authorized_keys

EXPOSE 22

#Starta o ssh daemon
CMD ["/usr/sbin/sshd", "-D"]
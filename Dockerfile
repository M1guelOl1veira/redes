FROM ubuntu:latest

#Criação do diretório para o serviço SSH funcionar normalmente
RUN mkdir -p /var/run/sshd

RUN apt update &&\ 
    apt install -y iputils-ping && \
    apt install -y openssh-server

#Adicionando um usuário e definindo senha
RUN useradd -rm -d /home/user -s /bin/bash user && \
    echo user:password1234 | chpasswd

EXPOSE 22

#Starta o ssh da
CMD ["/usr/sbin/sshd", "-D"]
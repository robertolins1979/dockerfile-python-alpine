# Imagem: Última versão do Python + Linux Alpine
FROM python:3-alpine

# Seta timezone
RUN ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Upgrade inicial
RUN apk upgrade --allow-untrusted

# Essenciais
#RUN apk --no-cache add curl gnupg gcc g++ libc-dev musl-dev python3-dev unixodbc-dev coreutils
RUN apk --no-cache add curl gnupg gcc g++ libc-dev musl-dev unixodbc-dev coreutils

# Download/instalação do driver ODBC 18 - Alpine
ARG ARQUITETURA=amd64
RUN curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/msodbcsql18_18.3.2.1-1_${ARQUITETURA}.apk
#RUN curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/mssql-tools18_18.3.1.1-1_${ARQUITETURA}.apk

RUN curl https://packages.microsoft.com/keys/microsoft.asc  | gpg --import -

RUN apk add --allow-untrusted msodbcsql18_18.3.2.1-1_${ARQUITETURA}.apk
#RUN apk add --allow-untrusted mssql-tools18_18.3.1.1-1_${ARQUITETURA}.apk

# Update pip
RUN pip install --upgrade pip

# Instalação do requirements.txt
#RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt

# Start
CMD [ "python", "-u","--version" ]

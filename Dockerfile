# This docker image is going to be huge! :'(

FROM mcr.microsoft.com/dotnet/framework/sdk:3.5

# install chocolatey
RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# RUN powershell -Command choco install -y DotNet4.0 7zip windows-sdk-7.1
RUN powershell -Command choco install -y windows-sdk-7.1

# Unfortunately, the choco packages don't really work for our needs so we have
# to install a bunch of MSIs manually. Fun times!
COPY *.ps1 /scripts/

# Install the vs 2010 content from DVD
RUN powershell -Command /scripts/install_tools.ps1 -InstallURI http://download.microsoft.com/download/F/1/0/F10113F5-B750-4969-A255-274341AC6BCE/GRMSDK_EN_DVD.iso

RUN REG ADD 'HKLM\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v7.0A' /f /v InstallationFolder /t reg_sz /d 'C:\\Program Files\\Microsoft SDKs\\Windows\\v7.1\\'

# Needed for resource files
RUN powershell -Command choco install -y windows-sdk-8.0

# Start developer command prompt with any other commands specified.
ENTRYPOINT 'C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd' /Release /x64 &&






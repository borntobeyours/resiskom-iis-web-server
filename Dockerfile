# Use the official Microsoft IIS image
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

# Remove the default IIS website
RUN powershell -NoProfile -Command \
    Remove-Website -Name 'Default Web Site'

# Create a new website and set the binding
RUN powershell -NoProfile -Command \
    New-Item -Path 'C:\inetpub\wwwroot\custom-site' -Type Directory -Force; \
    New-Website -Name 'custom-site' -PhysicalPath 'C:\inetpub\wwwroot\custom-site' -Port 80 -Force

# Copy your web application files to the container
COPY html/ /inetpub/wwwroot/custom-site/

# Expose the port for IIS
EXPOSE 80
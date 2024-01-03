#!/bin/bash

echo "################################################################"
echo "Kurulum başliyor!"
echo "################################################################"

# Sistem güncellemeleri
sudo yum update -y

# Gerekli araçların kurulumu
sudo yum install -y git wget

# Gerekli kütüphanelerin kurulumu
echo "################################################################"
echo "Gereksinimler kuruluyor."
echo "################################################################"

sudo yum install wget git python3 gperftools-libs libglvnd-glx

# Kurulum dizini oluşturma
mkdir -p ~/A1111
cd ~/A1111

# Automatic1111 reposunu klonlama
echo "################################################################"
echo "WebUI indiriliyor."
echo "################################################################"

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# Modellerin ve eklentilerin indirilmesi
echo "################################################################"
echo "Modeller indiriliyor."
echo "################################################################"

cd stable-diffusion-webui/models/Stable-diffusion
wget https://civitai.com/api/download/models/245598 --content-disposition
wget https://civitai.com/api/download/models/143906 --content-disposition

cd ..

echo "################################################################"
echo "Upscaler indiriliyor."
echo "################################################################"

mkdir ESGRAN
cd ESGRAN
wget https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth

cd ../..

# WebUI kullanıcı yapılandırması
echo "################################################################"
echo "WebUI User Yapılandırması"
echo "################################################################"

read -p "Kullanici adini giriniz: " username
read -sp "Sifreyi giriniz: " password

sed -i "s/^#export COMMANDLINE_ARGS=.*/export COMMANDLINE_ARGS=\"--share --gradio-auth $username:$password\"/" webui-user.sh

# Çalıştırma izinlerinin yapılandırması
echo "################################################################"
echo "Calıstırma Izinleri Yapilandiriliyor."
echo "################################################################"

sudo chmod +x webui.sh

echo "################################################################"
echo "Kurulum tamamlandi!"
echo "################################################################"
echo "################################################################"
echo "Ilk baslatma zaman alabilir!"
echo "################################################################"

# WebUI betiğini çalıştırma
./webui.sh -f

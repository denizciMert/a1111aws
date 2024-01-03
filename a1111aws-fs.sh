#!/bin/bash

echo "################################################################"
echo "Kurulum basliyor!"
echo "################################################################"
echo ""
# Sistem güncellemeleri
sudo yum update -y

# Gerekli araçların kurulumu
sudo yum install -y git wget

# Gerekli kütüphanelerin kurulumu
echo ""
echo "################################################################"
echo "Gereksinimler kuruluyor."
echo "################################################################"
echo ""

sudo yum install wget git python3 gperftools-libs libglvnd-glx

# Kurulum dizini oluşturma
mkdir -p ~/A1111
cd ~/A1111

# Automatic1111 reposunu klonlama
echo ""
echo "################################################################"
echo "WebUI indiriliyor."
echo "################################################################"
echo ""

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# Modellerin ve eklentilerin indirilmesi
echo ""
echo "################################################################"
echo "Modeller indiriliyor."
echo "################################################################"
echo ""

cd stable-diffusion-webui/models/Stable-diffusion

echo ""
echo "################################################################"
echo "Model - Realistic Vision V6.0 B1"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/245598 --content-disposition

echo ""
echo "################################################################"
echo "Model - epiCRealism RC1"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/143906 --content-disposition

cd ..

echo ""
echo "################################################################"
echo "Upscaler indiriliyor."
echo "################################################################"
echo ""

mkdir ESRGAN
cd ESRGAN
echo ""
echo "################################################################"
echo "Upscaler - 4x-UltraSharp"
echo "################################################################"
echo ""
wget https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth

cd ../..

echo ""
echo "################################################################"
echo "Eklentiler indiriliyor."
echo "################################################################"
echo ""

cd extensions
echo ""
echo "################################################################"
echo "Extension - Reactor"
echo "################################################################"
echo ""
git clone https://github.com/Gourieff/sd-webui-reactor

echo ""
echo "################################################################"
echo "Extension - Controlnet"
echo "################################################################"
echo ""
git clone https://github.com/Mikubill/sd-webui-controlnet

echo ""
echo "################################################################"
echo "Extension - Roop"
echo "################################################################"
echo ""
git clone https://github.com/s0md3v/sd-webui-roop

cd ..

# WebUI kullanıcı yapılandırması
echo ""
echo "################################################################"
echo "WebUI User Yapılandırması"
echo "################################################################"
echo ""

read -p "Kullanici adini giriniz: " username
read -sp "Sifreyi giriniz: " password

sed -i "s/^#export COMMANDLINE_ARGS=.*/export COMMANDLINE_ARGS=\"--share --gradio-auth $username:$password\"/" webui-user.sh

# Çalıştırma izinlerinin yapılandırması
echo ""
echo "################################################################"
echo "Calıstırma Izinleri Yapilandiriliyor."
echo "################################################################"
echo ""

sudo chmod +x webui.sh

echo ""
echo "################################################################"
echo "Kurulum tamamlandi!"
echo "################################################################"
echo ""
echo "################################################################"
echo "Ilk baslatma zaman alabilir!"
echo "################################################################"
echo ""

# WebUI betiğini çalıştırma
./webui.sh -f

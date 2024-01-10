#!/bin/bash

# Sistem güncellemeleri
echo "################################################################"
echo "Kurulum basliyor!"
echo "################################################################"
echo ""
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
echo "Model - Juggernaut XL V7"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/240840 --content-disposition

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

echo ""
echo "################################################################"
echo "Model - epiCPhotoGasm LastUnicorn"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/223670 --content-disposition
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

echo ""
echo "################################################################"
echo "Upscaler - 4x-NMKD Siax 200k"
echo "################################################################"
echo ""
wget https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth
cd ..

echo ""
echo "################################################################"
echo "Egitilmis araclar indiriliyor."
echo "################################################################"
echo ""
mkdir Lora
cd Lora

echo ""
echo "################################################################"
echo "LoRA - ReaLora"
echo "################################################################"
echo "Atlandi..."
#wget https://civitai.com/api/download/models/151465 --content-disposition

echo ""
echo "################################################################"
echo "LoRA - hairdetailer"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/86284 --content-disposition

echo ""
echo "################################################################"
echo "LoRA - Dolphin Shorts"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/134305 --content-disposition

echo ""
echo "################################################################"
echo "LoRA - Detail Slider"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/171989 --content-disposition

echo ""
echo "################################################################"
echo "LoRA - Hair Length Slider"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/123434 --content-disposition

echo ""
echo "################################################################"
echo "LoRA - High-waist Denim Shorts"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/133844 --content-disposition
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
echo "Atlandi..."
#git clone https://github.com/s0md3v/sd-webui-roop
cd ..

echo ""
echo "################################################################"
echo "Gomulu metinler indiriliyor"
echo "################################################################"
echo ""
cd embeddings

echo ""
echo "################################################################"
echo "Embedding - BadHand V4"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/20068 --content-disposition

echo ""
echo "################################################################"
echo "Embedding - Deep Negative V1 75T"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/5637 --content-disposition

echo ""
echo "################################################################"
echo "Embedding - Love Potion"
echo "################################################################"
echo "Atlandi..."
#wget https://civitai.com/api/download/models/219575 --content-disposition

echo ""
echo "################################################################"
echo "Embedding - Bad Dream"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/77169 --content-disposition

echo ""
echo "################################################################"
echo "Embedding - Fast Negative"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/94057 --content-disposition

echo ""
echo "################################################################"
echo "Embedding - Unrealistic Dream"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/77173 --content-disposition

echo ""
echo "################################################################"
echo "Embedding - epiCNegative"
echo "################################################################"
echo ""
wget https://civitai.com/api/download/models/95263 --content-disposition
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
sed -i "s/^#export NO_TCMALLOC=\"True\"$/export NO_TCMALLOC=\"True\"/" webui-user.sh

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
echo ""
echo "Ilk baslatma zaman alabilir!"
echo "################################################################"
echo ""

# WebUI betiğini çalıştırma
./webui.sh -f

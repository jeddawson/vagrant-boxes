#!/usr/bin/env bash

ANDROID_STUDIO_VERSION=0.5.3
ANDROID_STUDIO_BUILD=135.1092050
ANDROID_STUDIO_FILE=android-studio-ide-$ANDROID_STUDIO_BUILD-linux.zip

ANDROID_SDK_VERSION=r22.6.2
ANDROID_SDK_FILE=android-sdk_$ANDROID_SDK_VERSION-linux.tgz

# install java7
sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo apt-get update
# accept the license agreement
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java7-installer

# make a place to install development tools
mkdir -p ~/dev/tools
cd ~/dev/tools

# download and unpack android-studio
wget http://dl.google.com/dl/android/studio/ide-zips/$ANDROID_STUDIO_VERSION/$ANDROID_STUDIO_FILE
unzip $ANDROID_STUDIO_FILE
rm $ANDROID_STUDIO_FILE

# create a launcher for android-studio
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Android-Studio
Comment=
Exec=/home/vagrant/dev/tools/android-studio/bin/studio.sh
Icon=/home/vagrant/dev/tools/android-studio/bin/idea.png
Path=/home/vagrant/dev/tools/android-studio
Terminal=false
StartupNotify=false
GenericName=" >> /home/vagrant/Desktop/Android-Studio.Desktop

# download android sdk
wget http://dl.google.com/android/$ANDROID_SDK_FILE
tar -zxf $ANDROID_SDK_FILE
rm $ANDROID_SDK_FILE

# put the sdk in the android studio directory
mv android-sdk-linux android-studio/sdk

# install android sdk extras to get google libs
ANDROID=/home/vagrant/dev/tools/android-studio/sdk/tools/android
echo y | $ANDROID update sdk --no-ui --filter extra

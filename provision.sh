#!/usr/bin/env bash

#
# Install development environment
#
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y groupinstall "Development Tools"
sudo yum -y install screen java-1.7.0-openjdk-devel python-pip
sudo yum -y install python-devel libxml2-devel libxslt-devel libjpeg-devel zlib-devel libpng12-devel

# Disable SELinux for development
sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config /etc/selinux/config


# #########################################################
# Python Tools

# Upgrade Python package manager
sudo pip install --upgrade pip 
sudo pip install --upgrade virtualenv

# IPython
sudo pip install ipython[all]

# Pandas
sudo pip install pandas

# Newspaper: Scraping, Extraction and NLP 
cd /home/vagrant
sudo pip install newspaper
sudo curl https://raw.githubusercontent.com/codelucas/newspaper/master/download_corpora.py | python

# Goose: Content Extrction
cd /home/vagrant
sudo mkvirtualenv --no-site-packages goose
git clone https://github.com/grangier/python-goose.git
cd python-goose
sudo pip install -r requirements.txt
sudo python setup.py install

# Feedparser
sudo pip install feedparser

# Work with CSV files on the command line
sudo pip install csvkit

# Elasticsearch Client
sudo pip install elasticsearch


# #########################################################
# MITIE NLP
cd /home/vagrant
git clone https://github.com/mit-nlp/MITIE.git
cd /home/vagrant/MITIE
export MITIE_MODELS=MITIE-models-v0.2
if [ ! -d "MITIE-models" ]; then
  wget --quiet http://sourceforge.net/projects/mitie/files/binaries/$MITIE_MODELS.tar.bz2
  tar -xvjf $MITIE_MODELS.tar.bz2
  rm $MITIE_MODELS.tar.bz2
fi
make


# #########################################################
#
# NodeJs and common Libs
#
sudo yum -y install nodejs npm


# #########################################################
#
# Apacke Kafka
#
export KAFKA=kafka_2.9.2-0.8.1.1
cd /home/vagrant
if [ ! -d "$KAFKA" ]; then
  wget --quiet http://mirror.csclub.uwaterloo.ca/apache/kafka/0.8.1.1/$KAFKA.tgz
  tar -xzf $KAFKA.tgz
  rm $KAFKA.tgz
  ln -s $KAFKA kafka
fi 


# #########################################################
#
# Docker
#
cd /home/vagrant
sudo yum -y install docker
sudo systemctl daemon-reload
sudo systemctl restart docker


# #########################################################
#
# Elasticsearch
#
cd /home/vagrant
sudo rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch
sudo cp -f /vagrant/elasticsearch.repo /etc/yum.repos.d/
sudo yum -y install elasticsearch
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest


# #########################################################
#
# Scala
#
cd /home/vagrant
wget --quiet http://downloads.typesafe.com/scala/2.11.5/scala-2.11.5.rpm
sudo rpm -ivh scala-2.11.5.rpm


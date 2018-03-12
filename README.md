# Ubuntu Base Setup

- update packages

```bash
sudo apt-get update
sudo apt-get upgrade
```

- Add the ppa repo for NVIDIA graphics driver

```bash
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
```

- Install the recommended driver (currently nvidia-390)

```bash
sudo ubuntu-drivers autoinstall
sudo reboot
```

- check if drivers were installed
```bash
nvidia-smi
```

- Instal CUDA Toolkit for x86_64 Ubuntu 16.04 using debian package

>>> Note:
check tensorflow installation guide and issues to choose the right CUDA version (currently 9.0 works with tf 1.5)
>>>

```bahs
wget -O <cuda-repo-ubuntu1604_90.deb> http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-<cuda-repo-ubuntu1604_90.deb>
sudo dpkg -i <cuda-repo-ubuntu1604_90.deb>
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
echo 'export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
```

- If not successfull, instal CUDA Toolkit 8.0 for x64 Ubuntu 16.0 loaclly
```bash
wget -O cuda_8_linux.run https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
sudo chmod +x cuda_8_linux.run
./cuda_8.0.61_375.26_linux.run
```
>>> Note:
#Do you accept the previously read EULA?
#accept
#Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 367.48?
#n (we installed drivers previously)
#Install the CUDA 8.0 Toolkit?
#y
#Enter Toolkit Location:
#/usr/local/cuda-8.0 (enter)
#Do you wish to run the installation with ‚sudo’?
#y
#Do you want to install a symbolic link at /usr/local/cuda?
#y 
#Install the CUDA 8.0 Samples?
#y 
#Enter CUDA Samples Location:
#enter 
>>>

- Install cuDNN
   - go to website and download cudnn-8 https://developer.nvidia.com/cudnn
```bash
tar -zxvf cudnn-8.0-linux-x64-v5.1.tgz 
```
   - copy libs to /usr/local/cuda folder
```bash
sudo cp -P cuda/include/cudnn.h /usr/local/cuda/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
```

- Basic Development tools
```bash
sudo apt-get install build-essential git vim
```

- Python Development
```bash
sudo apt-get install python-dev python-pip python-virtualenv python-numpy python-matplotlib python3-pip python3-dev
```

- install conda
    - go to website and download Miniconda2/3 https://conda.io/miniconda.html
```bash
sudo chmod a+x Miniconda2-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh
```

- install jupyter and notebook conda to manage conda environments in jupyter
```bash
conda install jupyter notebook nb_conda
```
 
- Instal tensorflow
    - create conda environment for tensorflow
```bash
conda create -n py36tf15 anaconda python=3.6
```

    - Instal tensorflow package with gpu support
```bash
(py36tf15)$ pip3 install tensorflow-gpu==1.5
#or CPU version
(py36tf15)$ pip3 install tensorflow
```

- Cleanup downloaded libraries (remove tarballs, zip files, etc):
```bash
conda clean -tp
```


- check installation, run simple python scipt from console
```bash
python
```

```python
import tensorflow as tf
tf_session = tf.Session()
x = tf.constant(1)
y = tf.constant(1)
print(tf_session.run(x + y))

# Check if tf is using GPU
sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))

# Test tf with GPU
with tf.device('/gpu:0'):
    a = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[2, 3], name='a')
    b = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[3, 2], name='b')
    c = tf.matmul(a, b)

with tf.Session() as sess:
    print (sess.run(c))
```

# cloud computing

- [cloud computing](#cloud-computing)
  - [getting started](#getting-started)
  - [set up](#set-up)
    - [choosing instance](#choosing-instance)
    - [launching instance](#launching-instance)
    - [connecting to instance](#connecting-to-instance)
    - [transferring files to/from instance](#transferring-files-tofrom-instance)
    - [installing software](#installing-software)
    - [](#)

The idea of cloud computing is to connect to a remote server which is more powerful and/or reliable than a local machine and run code 'there', retrieving results upon completion. This effectively allows a researcher to rent costly equipment that is necessary or preferred for doing computations, GPUs for training neural network being an obvious example.

Many universities have such a server, but there are also commercially available solutions provided by Amazon, Google, Microsoft, IBM and others. In what follows, we will be using the former, but irrespective of the provider, the steps required to tap into the cloud resources are similar: set up an account, create a virtual machine, connect to the machine, upload the environment and code, run the code, retrieve the results. Don't forget to pay.

## getting started

Amazon provides the Web Services Cloud (AWS) with lots of options to outsource computing to the company's servers, from simple virtual machines to quantum technologies: Please refer to the [official page](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/amazon-web-services-cloud-platform.html) to get a glimpse of what is available.

For the purposes of data crunching or simulations, a good choice would be the [Elastic Compute Cloud (EC2)](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/compute-services.html#amazon-ec2). The user can launch an Amazon instance and pay pro capacity rata; depending on the instance type, this can be as low as $0.0067 per hour. Moreover, new AWS users

> [...] can get started with Amazon EC2 for free. For more information, see [AWS Free Tier](https://aws.amazon.com/free/).

There are ways to economize on costs by making use of spot and reserved instances.

Please refer to the (rather good and comprehensible) [official documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html) when reading on.

## set up

### choosing instance

There are many types of instances available, differing in the number of CPUs and GPUs, as well as in the RAM capacity.

### launching instance

Is well described here: [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html). Once an instance is launched you can control its usage by stopping and starting it as required to save costs: [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html).

### connecting to instance

Each instance gets an IP address such as

`ec2-3-30-30-130.eu-central-1.compute.amazonaws.com`

which can be used to connect to the instance via a client such as `ssh` on Linux. A secure connection is established using public-private key cryptography: In a nutshell, a pair of long random-looking numbers is generated in a certain way, one of which, called the private key, you should keep in a secure secret place, while the other, called the public key, is to be uploaded to the instance; the way the numbers are generated ensures that a message encrypted with the private key can be decrypted with the public key. You can either generate the pair when creating an instance or at any other time using a key generator such as `ssh-keygen`.

More on connecting to a running instance is here: [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html).

### transferring files to/from instance

Remember that `git` can (and must) be installed on a virtual machine, and is definitely the preferred solution to transfer anything from Github. For larger files deposited on your local or for bulky results of computations on the virtual machine, copying can be achieved from a separate terminal using a file transfer utility, such as `scp` on Linux. More information in the usual place: [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html).

### installing software

Would be done with a package manager specific to the operating system of the instance: `yum` for Amazon Linux, `apt` for Ubuntu etc:

```bash
yum install git
```

Python is usually pre-installed, but might require the version (2 or 3) suffix when calling the command, such as

```bash
python3 --version
```

Also pre-installed would be a text editor such as `vim` or `nano`: these can be used to edit small text files, e.g. the `.env` files used for specifying environment variables. Both editors are somewhat 

Further instruction and examples are here: [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-software.html);

So far, with a `nano` instance running Amazon Linux, the following is enough to create the virtual environment from the 

### 
- [managing storage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Storage.html);
- monitoring usage statistics.

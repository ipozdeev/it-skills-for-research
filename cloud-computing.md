# cloud computing

## aws
Amazong provides a Web Services Cloud (AWS) with lots of options to outsource computing to the company's servers. Solutions range from simple virtual machines to quantum technologies $mdash; please refer to the [official page](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/amazon-web-services-cloud-platform.html) for an overview of solutions.

For the purposes of data crunching or simulations that we could but are too costly to be run on a local machine, the preferred service would be the [Elastic Compute Cloud (EC2)](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/compute-services.html#amazon-ec2). The user can launch an Amazon instance and pay pro capacity rata, which can be as low as $0.004 per hour, depending on the instance type.

instance types:
*   On-Demand Instances
*   Spot Instances: cost-efficient, but can be shut down if someone has paid for this capacity (good for simulations?);
*   Reserved Instances

create volume -> attach it to an EC2 instance

ssh concepts
aws keeps the public, the user - the private key

connection instructions: [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html)

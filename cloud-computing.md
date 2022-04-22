# cloud computing

- [cloud computing](#cloud-computing)
  - [aws](#aws)

## aws

Amazon provides a Web Services Cloud (AWS) with lots of options to outsource computing to the company's servers. Solutions range from simple virtual machines to quantum technologies $mdash; please refer to the [official page](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/amazon-web-services-cloud-platform.html) for an overview of solutions.

For the purposes of data crunching or simulations that we could but are too costly to be run on a local machine, the preferred service would be the [Elastic Compute Cloud (EC2)](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/compute-services.html#amazon-ec2). The user can launch an Amazon instance and pay pro capacity rata, which can be as low as $0.004 per hour, depending on the instance type.

instance types:

- On-Demand Instances
- Spot Instances: cost-efficient, but can be shut down if someone has paid for this capacity (good for simulations?);
- Reserved Instances

Please refer to the (rather good and comprehensible) [official documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html), paying the most attention to:

- [launching instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html);
- [stopping instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html);
- [connecting to instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html);
- running your code;
- [transferring files to and from](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html);
- [installing software](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-software.html);
- creating virtual coding environments;
- [managing storage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Storage.html);
- monitoring usage statistics;
